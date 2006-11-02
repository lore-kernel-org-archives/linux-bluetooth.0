Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Olivier Dole <olivier.dole@palmsource.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1162463647.19652.28.camel@ODole-Ubuntu>
References: <1162463647.19652.28.camel@ODole-Ubuntu>
Content-Type: multipart/mixed; boundary="=-bo2j8WqT47odVsTA7j3x"
Date: Thu, 02 Nov 2006 11:38:06 +0100
Message-Id: <1162463886.19652.31.camel@ODole-Ubuntu>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Proposal: patch for pand
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--=-bo2j8WqT47odVsTA7j3x
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Sorry tiny error in my patch... a vim swap file was included. Sorry for
this mistake :p
so Here is a cleaner patch.

Regards,
Olivier DOLE

Le jeudi 02 novembre 2006 =C3=A0 11:34 +0100, Olivier Dole a =C3=A9crit :
> Hi everyone,
>=20
> For my work I need a similar mechanism to "devup" script in pand when a
> PAN disconnection occurs.
> That's why I've done the following patch (see attachment for source
> code) which allows PAN daemon to run a "devdown" script either when a
> disconnection is spotted i.e. remote device closes the connection or
> when you explicitly do the disconnection. To use it, simply add the
> following option to your command line:
> pand --options --devdown /path/to/devdown-script
> or
> pand -options -o /path/to/devdown-script
> or you can also read the pand man page ;)
> The behaviour is the same as for "devup" script. I mean when the script
> is run the following arguments are supplied to the script:
> $1 <-> device interface e.g. "bnep0"
> $2 <-> bluetooth address of the disconnected device e.g.
> "00:45:78:AE:B4:01"
> and of course your script must have the correct permissions to run.
>=20
> Any feedback about this patch is of course welcome ;)
> Hope you will find this patch usefull.
>=20
> Regards,
> Olivier DOLE
> -----------------------------------------------------------------------=
--
> Using Tomcat but need to do more? Need to support web services, securit=
y?
> Get stuff done quickly with pre-integrated technology to make your job =
easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geron=
imo
> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=
=3D121642
> _______________________________________________ Bluez-devel mailing lis=
t Bluez-devel@lists.sourceforge.net https://lists.sourceforge.net/lists/l=
istinfo/bluez-devel

--=-bo2j8WqT47odVsTA7j3x
Content-Disposition: attachment; filename=bluez_pand_dev-down.patch
Content-Type: text/x-patch; name=bluez_pand_dev-down.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

diff -Naur pand.orig/main.c pand.new/main.c
--- pand.orig/main.c	2006-09-30 00:23:28.000000000 +0200
+++ pand.new/main.c	2006-11-02 11:03:27.000000000 +0100
@@ -73,6 +73,7 @@
 static char netdev[16] = "bnep%d";
 static char *pidfile = NULL;
 static char *devupcmd = NULL;
+static char *devdowncmd = NULL;
 
 static bdaddr_t src_addr = *BDADDR_ANY;
 static int src_dev = -1;
@@ -89,15 +90,22 @@
 	KILL
 } modes;
 
-static void run_devup(char *dev, char *dst, int sk, int nsk)
+struct script_arg {
+	char	dev[20];
+	char	dst[20];
+	int		sk;
+	int		nsk;
+};
+	
+static void run_script(char *script, char *dev, char *dst, int sk, int nsk)
 {
 	char *argv[4];
 	struct sigaction sa;
 
-	if (!devupcmd)
+	if (!script)
 		return;
-
-	if (access(devupcmd, R_OK | X_OK))
+		
+	if (access(script, R_OK | X_OK))
 		return;
 
 	if (fork())
@@ -114,16 +122,57 @@
 	sigaction(SIGCHLD, &sa, NULL);
 	sigaction(SIGPIPE, &sa, NULL);
 
-	argv[0] = devupcmd;
+	argv[0] = script;
 	argv[1] = dev;
 	argv[2] = dst;
 	argv[3] = NULL;
 
-	execv(devupcmd, argv);
+	execv(script, argv);
 
 	exit(1);
 }
 
+/* Wait for disconnect or error condition on the socket */
+static int w4_hup(int sk, struct script_arg *down_cmd)
+{
+	struct pollfd pf;
+	sigset_t sigs;
+	int n;
+
+	sigfillset(&sigs);
+	sigdelset(&sigs, SIGCHLD);
+	sigdelset(&sigs, SIGPIPE);
+	sigdelset(&sigs, SIGTERM);
+	sigdelset(&sigs, SIGINT);
+	sigdelset(&sigs, SIGHUP);
+
+	while (!terminate) {
+		pf.fd = sk;
+		pf.events = POLLERR | POLLHUP;
+		n = ppoll(&pf, 1, NULL, &sigs);
+		if (n < 0) {
+			if (errno == EINTR || errno == EAGAIN)
+				continue;
+			syslog(LOG_ERR, "Poll failed. %s(%d)",
+						strerror(errno), errno);
+			return 1;
+		}
+
+		if (n) {
+			int err = 0;
+			socklen_t olen = sizeof(err);
+			getsockopt(sk, SOL_SOCKET, SO_ERROR, &err, &olen);
+			syslog(LOG_INFO, "%s disconnected%s%s", netdev,
+				err ? " : " : "", err ? strerror(err) : "");
+			if (down_cmd) 
+				run_script(devdowncmd, down_cmd->dev, down_cmd->dst, down_cmd->sk, down_cmd->nsk);
+			close(sk);
+			return 0;
+		}
+	}
+	return 0;
+}
+
 static int do_listen(void)
 {
 	struct l2cap_options l2o;
@@ -207,12 +256,21 @@
 
 		if (!bnep_accept_connection(nsk, role, devname)) {
 			char str[40];
+			struct script_arg down_cmd;
+
 			ba2str(&l2a.l2_bdaddr, str);
 
 			syslog(LOG_INFO, "New connection from %s %s",
-								str, devname);
+								str, netdev);
 
-			run_devup(devname, str, sk, nsk);
+			run_script(devupcmd, devname, str, sk, nsk);
+	
+			memset(&down_cmd, 0, sizeof(struct script_arg));
+			strncpy(down_cmd.dev, devname, strlen(devname) + 1);
+			strncpy(down_cmd.dst, str, strlen(str) + 1);
+			down_cmd.sk = sk;
+			down_cmd.nsk = nsk;
+			w4_hup(nsk, &down_cmd);
 		} else {
 			syslog(LOG_ERR, "Connection failed. %s(%d)",
 						strerror(errno), errno);
@@ -227,46 +285,6 @@
 	return 0;
 }
 
-/* Wait for disconnect or error condition on the socket */
-static int w4_hup(int sk)
-{
-	struct pollfd pf;
-	sigset_t sigs;
-	int n;
-
-	sigfillset(&sigs);
-	sigdelset(&sigs, SIGCHLD);
-	sigdelset(&sigs, SIGPIPE);
-	sigdelset(&sigs, SIGTERM);
-	sigdelset(&sigs, SIGINT);
-	sigdelset(&sigs, SIGHUP);
-
-	while (!terminate) {
-		pf.fd = sk;
-		pf.events = POLLERR | POLLHUP;
-		n = ppoll(&pf, 1, NULL, &sigs);
-		if (n < 0) {
-			if (errno == EINTR || errno == EAGAIN)
-				continue;
-			syslog(LOG_ERR, "Poll failed. %s(%d)",
-						strerror(errno), errno);
-			return 1;
-		}
-
-		if (n) {
-			int err = 0;
-			socklen_t olen = sizeof(err);
-			getsockopt(sk, SOL_SOCKET, SO_ERROR, &err, &olen);
-			syslog(LOG_INFO, "%s disconnected%s%s", netdev,
-				err ? " : " : "", err ? strerror(err) : "");
-
-			close(sk);
-			return 0;
-		}
-	}
-	return 0;
-}
-
 /* Connect and initiate BNEP session
  * Returns:
  *   -1 - critical error (exit persist mode)
@@ -279,6 +297,7 @@
 	struct sockaddr_l2 l2a;
 	socklen_t olen;
 	int sk, r = 0;
+	struct script_arg down_cmd;
 
 	syslog(LOG_INFO, "Connecting to %s", dst);
 
@@ -314,10 +333,15 @@
 
 		syslog(LOG_INFO, "%s connected", netdev);
 
-		run_devup(netdev, dst, sk, -1);
+		run_script(devupcmd, netdev, dst, sk, -1);
 
-		if (persist) {
-			w4_hup(sk);
+		if (persist || devdowncmd) {
+				memset(&down_cmd, 0, sizeof(struct script_arg));
+				strncpy(down_cmd.dev, netdev, strlen(netdev) + 1);
+				strncpy(down_cmd.dst, dst, strlen(dst) + 1);
+				down_cmd.sk = sk;
+				down_cmd.nsk = -1;
+				w4_hup(sk, &down_cmd);
 
 			if (terminate && cleanup) {
 				syslog(LOG_INFO, "Disconnecting from %s.", dst);
@@ -525,11 +549,12 @@
 	{ "cache",    0, 0, 'C' },
 	{ "pidfile",  1, 0, 'P' },
 	{ "devup",    1, 0, 'u' },
+	{ "devdown",  1, 0, 'o' },
 	{ "autozap",  0, 0, 'z' },
 	{ 0, 0, 0, 0 }
 };
 
-static char main_sopts[] = "hsc:k:Kr:d:e:i:lnp::DQ::AESMC::P:u:z";
+static char main_sopts[] = "hsc:k:Kr:d:e:i:lnp::DQ::AESMC::P:u:o:z";
 
 static char main_help[] = 
 	"Bluetooth PAN daemon version " VERSION " \n"
@@ -556,7 +581,8 @@
 	"\t--persist -p[interval]    Persist mode\n"
 	"\t--cache -C[valid]         Cache addresses\n"
 	"\t--pidfile -P <pidfile>    Create PID file\n"
-	"\t--devup -u <script>       Script to run when interface comes up\n";
+	"\t--devup -u <script>       Script to run when interface comes up\n"
+	"\t--devdown -o <script>	 Script to run when interface comes down\n";
 
 int main(int argc, char *argv[])
 {
@@ -661,6 +687,10 @@
 			devupcmd = strdup(optarg);
 			break;
 
+		case 'o':
+			devdowncmd = strdup(optarg);
+			break;
+
 		case 'z':
 			cleanup = 1;
 			break;
diff -Naur pand.orig/pand.1 pand.new/pand.1
--- pand.orig/pand.1	2006-06-04 15:05:36.000000000 +0200
+++ pand.new/pand.1	2006-11-02 10:58:31.000000000 +0100
@@ -66,6 +66,9 @@
 \fB\-\-devup\fR \fB\-u <script>\fR
 Script to run when interface comes up
 .TP
+\fB\-\-devdown\fR \fB\-o <script>\fR
+Script to run when interface comes down. The script is executed with \fIdevice\fR \fIdestination\fR as arguments.
+.TP
 \fB\-\-autozap\fR \fB\-z\fR
 Disconnect automatically on exit
 

--=-bo2j8WqT47odVsTA7j3x
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--=-bo2j8WqT47odVsTA7j3x
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-bo2j8WqT47odVsTA7j3x--
