Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43FDBDDD.7030209@fillibach.de>
From: Kosta Welke <kosta@fillibach.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: multipart/mixed;
 boundary="------------040502020507040907040902"
Subject: [Bluez-devel] pand multiconnection patch
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 23 Feb 2006 14:51:25 +0100

This is a multi-part message in MIME format.
--------------040502020507040907040902
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi!

I am currently trying to build a (somewhat small) IP-based ad-hoc 
network using bluetooth. In order to do this, I need pand to create 
multiple connections. (see maxconn switch)

One problem with bluetooth is that while inquiring, sending payload data 
is somewhat impaired. This is why I added a new switch inqint, which 
reduces the number of inquiries made: If there is at least one 
connection, inquire every inqint seconds, else inquire every persist 
seconds (which is the current behavior in cvs).

Furthermore, I want to send real-time-critical data over the link (i.e. 
VoIP), and do not want any inquiries made during these periods. That's 
why I introduced a lockfile switch. If the lockfile cannot be 
writelocked, no inquiries are made if there is at least one connection.

I have tested this patch "at home", but only with up to 3 bluetooth 
devices. I seems to work. I will do further tests during the next weeks. 
If I find any errors, I'll submit the fixes.

If you do not like the lockfile, I can send you a patch without it.

The patch is attached. If my email client screws up, it can also be
found at
http://lastpageofthe.net/pand-multiconnection.patch

Furthermore, I'd like to update the manpage of pand. I'd also like to 
make it more verbose, by incorporating stuff from Marcel's pand howto.
The file in cvs says it should not be modified. Is that right? Where can 
I find the manpage source to edit?

Yours,
Kosta

--------------040502020507040907040902
Content-Type: text/plain;
 name="pand-multiconnection.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pand-multiconnection.patch"

--- main.c	15 Feb 2006 08:21:57 -0000	1.21
+++ main.c	23 Feb 2006 13:39:15 -0000
@@ -39,6 +39,7 @@
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <sys/socket.h>
+#include <time.h>
 
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/hci.h>
@@ -61,16 +62,22 @@ static int secure;
 static int master;
 static int cleanup;
 static int search_duration = 10;
+static int maxconn = 1;
+static int inqint = 60;
 
-static struct {
-	int      valid;
-	char     dst[40];
-	bdaddr_t bdaddr;
-} cache;
+typedef struct {
+	int sk; //file descriptor
+	char netdev[16]; //bnep device name
+	char dst[40]; //bluetooth address
+	bdaddr_t bdaddr; //bluetooth address
+	int validcache;
+} bnepconn;
 
+static bnepconn *connections = 0;
 static char netdev[16] = "bnep%d";
 static char *pidfile = NULL;
 static char *devupcmd = NULL;
+static char *lockfile = NULL;
 
 static bdaddr_t src_addr = *BDADDR_ANY;
 static int src_dev = -1;
@@ -234,35 +241,72 @@ static int do_listen(void)
 	return 0;
 }
 
-/* Wait for disconnect or error condition on the socket */
-static int w4_hup(int sk)
+/* Wait for disconnect or error condition on the socket 
+ * Returns:
+ * -1 - critical error
+ * 0 - else
+ */
+static int w4_hup(int wait4long)
 {
-	struct pollfd pf;
-	int n;
+	struct pollfd pf[maxconn];
+	bnepconn *pfmap[maxconn];
+	int i = 0, n, conns = 0, wait;
+	time_t t_start = time(NULL);
+	if (wait4long)
+		wait = inqint;
+	else
+		wait = persist;
+	int delta_t = wait;
 
-	while (!terminate) {
-		pf.fd = sk;
-		pf.events = POLLERR | POLLHUP;
-		n = poll(&pf, 1, -1);
+	while (!terminate && (delta_t > 0)) {
+		conns = 0;
+		for (i = 0; i < maxconn; i++)
+			if (connections[i].sk != -1) {
+				pf[conns].fd = connections[i].sk;
+				pf[conns].events = POLLERR | POLLHUP;
+				pfmap[conns] = &connections[i];
+				conns++;
+			}
+		
+		if (!conns) {
+			delta_t = -1;
+			continue;
+		}
+
+		n = poll(pf, conns, delta_t * 1000);
 		if (n < 0) {
 			if (errno == EINTR || errno == EAGAIN)
 				continue;
 			syslog(LOG_ERR, "Poll failed. %s(%d)",
-						strerror(errno), errno);
-			return 1;
+				strerror(errno), errno);
+			return -1;
 		}
 
 		if (n) {
-			int err = 0;
-			socklen_t olen = sizeof(err);
-			getsockopt(sk, SOL_SOCKET, SO_ERROR, &err, &olen);
-			syslog(LOG_INFO, "%s disconnected%s%s", netdev,
-				err ? " : " : "", err ? strerror(err) : "");
-
-			close(sk);
-			return 0;
+			for (i = 0; i < conns; i++)
+				if (pf[i].revents) {
+					int err = 0;
+					socklen_t olen = sizeof(err);
+					getsockopt(pf[i].fd, SOL_SOCKET, 
+							SO_ERROR, &err, &olen);
+					syslog(LOG_INFO, "%s disconnected%s%s",
+						pfmap[i]->netdev, 
+						err ? " : " : "", 
+						err ? strerror(err) : "");
+					close(pf[i].fd);
+					pfmap[i]->sk = -1;
+				}
 		}
+		delta_t = t_start + wait - time(NULL);
+	}
+
+	//make sure that at least $persist seconds have passed
+	if (!terminate && !conns) {
+		delta_t = t_start + persist - time(NULL);
+		if (delta_t > 0)
+			sleep(delta_t);
 	}
+
 	return 0;
 }
 
@@ -272,17 +316,17 @@ static int w4_hup(int sk)
  *   1  - non critical error
  *   0  - success
  */
-static int create_connection(char *dst, bdaddr_t *bdaddr)
+static int create_connection(bnepconn* conn)
 {
 	struct l2cap_options l2o;
 	struct sockaddr_l2 l2a;
 	socklen_t olen;
-	int sk, r = 0;
+	int r = 0;
 
-	syslog(LOG_INFO, "Connecting to %s", dst);
+	syslog(LOG_INFO, "Connecting to %s", conn->dst);
 
-	sk = socket(AF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP);
-	if (sk < 0) {
+	conn->sk = socket(AF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP);
+	if (conn->sk < 0) {
 		syslog(LOG_ERR, "Cannot create L2CAP socket. %s(%d)",
 						strerror(errno), errno);
 		return -1;
@@ -291,61 +335,113 @@ static int create_connection(char *dst, 
 	/* Setup L2CAP options according to BNEP spec */
 	memset(&l2o, 0, sizeof(l2o));
 	olen = sizeof(l2o);
-	getsockopt(sk, SOL_L2CAP, L2CAP_OPTIONS, &l2o, &olen);
+	getsockopt(conn->sk, SOL_L2CAP, L2CAP_OPTIONS, &l2o, &olen);
 	l2o.imtu = l2o.omtu = BNEP_MTU;
-	setsockopt(sk, SOL_L2CAP, L2CAP_OPTIONS, &l2o, sizeof(l2o));
+	setsockopt(conn->sk, SOL_L2CAP, L2CAP_OPTIONS, &l2o, sizeof(l2o));
 
 	memset(&l2a, 0, sizeof(l2a));
 	l2a.l2_family = AF_BLUETOOTH;
 	bacpy(&l2a.l2_bdaddr, &src_addr);
 
-	if (bind(sk, (struct sockaddr *) &l2a, sizeof(l2a)))
+	if (bind(conn->sk, (struct sockaddr *) &l2a, sizeof(l2a)))
 		syslog(LOG_ERR, "Bind failed. %s(%d)",
-						strerror(errno), errno);
+				strerror(errno), errno);
 
 	memset(&l2a, 0, sizeof(l2a));
 	l2a.l2_family = AF_BLUETOOTH;
-	bacpy(&l2a.l2_bdaddr, bdaddr);
+	bacpy(&l2a.l2_bdaddr, &conn->bdaddr);
 	l2a.l2_psm = htobs(BNEP_PSM);
+	strncpy(conn->netdev, netdev, 16);
+	conn->netdev[15] = '\0';
 
-	if (!connect(sk, (struct sockaddr *) &l2a, sizeof(l2a)) && 
-			!bnep_create_connection(sk, role, service, netdev)) {
-
-		syslog(LOG_INFO, "%s connected", netdev);
+	if (!connect(conn->sk, (struct sockaddr *) &l2a, sizeof(l2a)) && 
+			!bnep_create_connection(conn->sk, role, service, 
+				conn->netdev)) {
 
-		run_devup(netdev, dst, sk, -1);
-
-		if (persist) {
-			w4_hup(sk);
+		syslog(LOG_INFO, "%s connected", conn->netdev);
 
-			if (terminate && cleanup) {
-				syslog(LOG_INFO, "Disconnecting from %s.", dst);
-				do_kill(dst);
-			}
-		}
+		run_devup(conn->netdev, conn->dst, conn->sk, -1);
 
 		r = 0;
 	} else {
 		syslog(LOG_ERR, "Connect to %s failed. %s(%d)",
-						dst, strerror(errno), errno);
+				conn->dst, strerror(errno), errno);
 		r = 1;
+		close(conn->sk);
+		conn->sk = -1;
 	}
 
-	close(sk);
-
 	if (use_cache) {
-		if (!r) {
+		if (!r)
 			/* Succesesful connection, validate cache */
-			strcpy(cache.dst, dst);
-			bacpy(&cache.bdaddr, bdaddr);
-			cache.valid = use_cache;
-		} else
-			cache.valid--;
+			conn->validcache = use_cache;
+		else
+			conn->validcache--;
 	}
 
 	return r;
 }
 
+/* Search for an unconnected entry in connections
+ * Returns:
+ * -1   - we already have maxconn connections
+ * else - index of unconnected entry
+ */
+bnepconn* find_next_unconnected()
+{
+	int i;
+	for (i = 0; i < maxconn; i++)
+		if (-1 == connections[i].sk)
+			return &connections[i];
+	return NULL;
+}
+
+/* Returns:
+ * 1 - if we are connected to at least one device
+ * 0 - no connections are currently established
+ */
+int has_connection()
+{
+	int i;
+	for (i = 0; i < maxconn; i++)
+		if (-1 != connections[i].sk)
+			return 1;
+	return 0;
+}
+
+/* Check if lockfile is writelocked.
+ * Returns:
+ * 1 - file is unlocked
+ * 0 - file is locked
+ * -1 - error (will be treated as unlocked)
+ */
+static int lockfile_unlocked()
+{
+	if (!lockfile)
+		return 1;
+	int r;
+	
+	FILE* fp = fopen(lockfile, "w");
+	if (!fp)
+		return -1;
+	int fd = fileno(fp);
+
+	static struct flock lock ;
+	lock.l_type = F_WRLCK;
+	lock.l_start = 0;
+	lock.l_whence = SEEK_SET;
+	lock.l_len = 0;
+	lock.l_pid = getpid();
+
+	r = fcntl(fd, F_GETLK, &lock);
+	fclose(fp);
+	if (r == -1)
+		return -1;
+	if (lock.l_type == F_UNLCK)
+		return 1;
+	return 0;
+}
+
 /* Search and connect
  * Returns:
  *   -1 - critical error (exit persist mode)
@@ -355,56 +451,111 @@ static int create_connection(char *dst, 
 static int do_connect(void)
 {
 	inquiry_info *ii;
-	int reconnect = 0;
-	int i, n, r = 0;
+	int i = 0, k, n, r = 0, emptycache, duplicate, may_inquire;
+	bnepconn *conn = NULL;
 
 	do {
-		if (reconnect)
-			sleep(persist);
-		reconnect = 1;
-
-		if (cache.valid > 0) {
-			/* Use cached bdaddr */
-			r = create_connection(cache.dst, &cache.bdaddr);
-			if (r < 0) {
-				terminate = 1;
-				break;
+		emptycache = 0;
+		while (!terminate && !emptycache) {
+			emptycache = 1;
+			for(i = 0; i < maxconn; i++)
+			if ((connections[i].sk == -1) && 
+					(connections[i].validcache > 0)) {
+				emptycache = 0;
+				/* Use cached bdaddr */
+				r = create_connection(&connections[i]);
+				if (r < 0) {
+					terminate = 1;
+					break;
+				}
 			}
-			continue;
+			if (!emptycache)
+				sleep(persist);
 		}
 
-		syslog(LOG_INFO, "Inquiring");
-
-		/* FIXME: Should we use non general LAP here ? */
+		if (has_connection()) {
+			may_inquire = lockfile_unlocked();
+			if (!may_inquire)
+				syslog(LOG_INFO, 
+					"Lockfile is locked. skipping inquiry");
+		} else
+			may_inquire = 1;
 
-		ii = NULL;
-		n  = hci_inquiry(src_dev, search_duration, 0, NULL, &ii, 0);
-		if (n < 0) {
-			syslog(LOG_ERR, "Inquiry failed. %s(%d)",
+		if (!terminate && may_inquire 
+			&& (conn = find_next_unconnected())) {
+		  
+			syslog(LOG_INFO, "Inquiring");
+
+			/* FIXME: Should we use non general LAP here ? */
+
+			ii = NULL;
+			n  = hci_inquiry(src_dev, search_duration, 0, 
+						NULL, &ii, 0);
+			if (n < 0) {
+				syslog(LOG_ERR, "Inquiry failed. %s(%d)",
 						strerror(errno), errno);
-			continue;
-		}
-
-		for (i = 0; i < n; i++) {
-			char dst[40];
-			ba2str(&ii[i].bdaddr, dst);
-
-			if (use_sdp) {
-				syslog(LOG_INFO, "Searching for %s on %s", 
-						bnep_svc2str(service), dst);
+				continue;
+			}
 
-				if (bnep_sdp_search(&src_addr, &ii[i].bdaddr, service) <= 0)
+			for (i = 0; i < n; i++) {
+				//dont connect to same address twice
+				duplicate = 0;
+				for(k = 0; k < maxconn; k++)
+					if ((connections[k].sk != -1) 
+					    && !bacmp(&connections[k].bdaddr, 
+						    &ii[i].bdaddr))
+						duplicate = 1;
+				if (duplicate)
 					continue;
+
+				bacpy(&conn->bdaddr, &ii[i].bdaddr);
+				ba2str(&ii[i].bdaddr, conn->dst);
+
+				if (use_sdp) {
+					syslog(LOG_INFO, 
+						"Searching for %s on %s",
+						bnep_svc2str(service), 
+						conn->dst);
+
+					if (bnep_sdp_search(&src_addr, 
+						&ii[i].bdaddr, service) <= 0)
+						continue;
+				}
+
+				r = create_connection(conn);
+				if (r < 0) {
+					terminate = 1;
+					break;
+				} else if (!r) {
+					conn = find_next_unconnected();
+					if (!conn)
+						break;
+				}
 			}
+			bt_free(ii);
+		}
 
-			r = create_connection(dst, &ii[i].bdaddr);
-			if (r < 0) {
+		if (persist) {
+			r = w4_hup(may_inquire);
+			if (r < 0)
 				terminate = 1;
-				break;
-			}
 		}
-		bt_free(ii);
+
 	} while (!terminate && persist);
+			
+	if (terminate && cleanup) {
+		for (i = 0; i < maxconn; i++)
+			if (connections[i].sk != -1) {
+				syslog(LOG_INFO, "Disconnecting from %s.", 
+						connections[i].dst);
+				do_kill(connections[i].dst);
+			}
+	}
+
+	for(i = 0; i < maxconn; i++) {
+		close(connections[i].sk);
+		connections[i].sk = -1;
+	}
 
 	return r;
 }
@@ -444,11 +595,12 @@ static int write_pidfile(void)
 			/* Try to open the file for read. */
 			fd = open(pidfile, O_RDONLY);
 			if(fd == -1) {
-				syslog(LOG_ERR, "Could not read old pidfile: %s(%d)",
-							strerror(errno), errno);
+				syslog(LOG_ERR, 
+					"Could not read old pidfile: %s(%d)",
+					strerror(errno), errno);
 				return -1;
 			}
-			
+
 			/* We're already running; send a SIGHUP (we presume that they
 			 * are calling ifup for a reason, so they probably want to
 			 * rescan) and then exit cleanly and let things go on in the
@@ -524,10 +676,13 @@ static struct option main_lopts[] = {
 	{ "pidfile",  1, 0, 'P' },
 	{ "devup",    1, 0, 'u' },
 	{ "autozap",  0, 0, 'z' },
+	{ "maxconn",  1, 0, 'm' },
+	{ "inqint",   1, 0, 'I' },
+	{ "lockfile", 1, 0, 'L' },
 	{ 0, 0, 0, 0 }
 };
 
-static char main_sopts[] = "hsc:k:Kr:d:e:i:lnp::DQ::AESMC::P:u:z";
+static char main_sopts[] = "hsc:k:Kr:d:e:i:lnp::DQ::AESMC::P:u:zm:I:L:";
 
 static char main_help[] = 
 	"Bluetooth PAN daemon version " VERSION " \n"
@@ -554,7 +709,11 @@ static char main_help[] = 
 	"\t--persist -p[interval]    Persist mode\n"
 	"\t--cache -C[valid]         Cache addresses\n"
 	"\t--pidfile -P <pidfile>    Create PID file\n"
-	"\t--devup -u <script>       Script to run when interface comes up\n";
+	"\t--devup -u <script>       Script to run when interface comes up\n"
+	"additional search options:\n"
+	"\t--maxconn -m <number>     Try to up to that many connections\n"
+	"\t--inqint -I <interval>    Seconds to wait between inquires if connected\n"
+	"\t--lockfile -L <file>      Don't inquire if connected and file is wlocked\n";
 
 int main(int argc, char **argv)
 {
@@ -663,6 +822,22 @@ int main(int argc, char **argv)
 			cleanup = 1;
 			break;
 
+		case 'm':
+			maxconn = atoi(optarg);
+			break;
+
+		case 'I':
+			inqint = atoi(optarg);
+			if ((INT_MAX / 1000) < inqint) {
+				inqint = INT_MAX / 1000;
+				printf("inqint too big, using %i\n", inqint);
+			}
+			break;
+
+		case 'L':
+			lockfile = optarg;
+			break;
+
 		case 'h':
 		default:
 			printf(main_help);
@@ -736,15 +911,30 @@ int main(int argc, char **argv)
 	if (pidfile && write_pidfile())
 		return -1;
 
+	connections = malloc(maxconn * sizeof(bnepconn));
+	if (!connections) {
+		syslog(LOG_ERR, "malloc failed.");
+		return -1;
+	}
+
+	int i;
+	for(i = 0; i < maxconn; i++) {
+		connections[i].sk = -1;
+		connections[i].validcache = 0;
+		strncpy(connections[i].netdev, netdev, 16);
+		connections[i].netdev[15] = '\0';
+	}
+
 	if (dst) {
 		/* Disable cache invalidation */
 		use_cache = 0;
-
-		strncpy(cache.dst, dst, sizeof(cache.dst) - 1);
-		str2ba(dst, &cache.bdaddr);
-		cache.valid = 1;
+		
+		strncpy(connections[0].dst, dst, sizeof(connections[0].dst) - 1);
+		connections[0].dst[sizeof(connections[0].dst)-1] = '\0';
+		str2ba(dst, &connections[0].bdaddr);
+		connections[0].validcache = 1;
 		free(dst);
-	}
+	} 
 
 	switch (mode) {
 	case CONNECT:

--------------040502020507040907040902--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
