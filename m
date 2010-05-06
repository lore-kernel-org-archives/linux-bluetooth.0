Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Subject: [PATCH 1/6] Removed extra spaces at end of line in compat dir
Date: Fri,  7 May 2010 00:27:07 +0200
Message-Id: <1273184832-8265-1-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 compat/bnep.c  |   10 +++++-----
 compat/dun.c   |    4 ++--
 compat/dund.c  |    6 +++---
 compat/hidd.c  |    2 +-
 compat/msdun.c |    8 ++++----
 compat/pand.c  |    8 ++++----
 compat/sdp.c   |   12 ++++++------
 7 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/compat/bnep.c b/compat/bnep.c
index 71eb0cc..2e4fb9d 100644
--- a/compat/bnep.c
+++ b/compat/bnep.c
@@ -93,7 +93,7 @@ int bnep_init(void)
 	}
 
 	/* Temporary ioctl compatibility hack */
-	{ 
+	{
 		struct bnep_connlist_req req;
 		struct bnep_conninfo ci[1];
 
@@ -194,19 +194,19 @@ static int bnep_connadd(int sk, uint16_t role, char *dev)
 	return 0;
 }
 
-struct __service_16 { 
+struct __service_16 {
 	uint16_t dst;
 	uint16_t src;
 } __attribute__ ((packed));
 
-struct __service_32 { 
+struct __service_32 {
 	uint16_t unused1;
 	uint16_t dst;
 	uint16_t unused2;
 	uint16_t src;
 } __attribute__ ((packed));
 
-struct __service_128 { 
+struct __service_128 {
 	uint16_t unused1;
 	uint16_t dst;
 	uint16_t unused2[8];
@@ -246,7 +246,7 @@ int bnep_accept_connection(int sk, uint16_t role, char *dev)
 	return bnep_connadd(sk, role, dev);
 }
 
-/* Create BNEP connection 
+/* Create BNEP connection
  * sk      - Connect L2CAP socket
  * role    - Local role
  * service - Remote service
diff --git a/compat/dun.c b/compat/dun.c
index 3f4b46f..59f036f 100644
--- a/compat/dun.c
+++ b/compat/dun.c
@@ -158,7 +158,7 @@ static int dun_exec(char *tty, char *prog, char **args)
 {
 	int pid = fork();
 	int fd;
-	
+
 	switch (pid) {
 	case -1:
 		return -1;
@@ -244,7 +244,7 @@ int dun_cleanup(void)
 static int show_conn(struct rfcomm_dev_info *di, unsigned long arg)
 {
 	pid_t pid;
-	
+
 	if (di->state == BT_CONNECTED &&
 		(di->flags & (1<<RFCOMM_REUSE_DLC)) &&
 		(di->flags & (1<<RFCOMM_TTY_ATTACHED)) &&
diff --git a/compat/dund.c b/compat/dund.c
index deb2852..af1b536 100644
--- a/compat/dund.c
+++ b/compat/dund.c
@@ -247,7 +247,7 @@ static int create_connection(char *dst, bdaddr_t *bdaddr, int mrouter)
 	sa.rc_bdaddr  = src_addr;
 
 	if (bind(sk, (struct sockaddr *) &sa, sizeof(sa)))
-		syslog(LOG_ERR, "Bind failed. %s(%d)", 
+		syslog(LOG_ERR, "Bind failed. %s(%d)",
 			strerror(errno), errno);
 
 	sa.rc_channel = ch;
@@ -337,7 +337,7 @@ static int do_connect(void)
 		for (i = 0; i < n; i++) {
 			char dst[40];
 			ba2str(&ii[i].bdaddr, dst);
-			
+
 			r = create_connection(dst, &ii[i].bdaddr, 0);
 			if (r < 0) {
 				terminate = 1;
@@ -405,7 +405,7 @@ static struct option main_lopts[] = {
 
 static const char *main_sopts = "hsc:k:Kr:i:lnp::DQ::AESMP:C::P:Xam:u";
 
-static const char *main_help = 
+static const char *main_help =
 	"Bluetooth LAP (LAN Access over PPP) daemon version %s\n"
 	"Usage:\n"
 	"\tdund <options> [pppd options]\n"
diff --git a/compat/hidd.c b/compat/hidd.c
index 40bf663..88944cf 100644
--- a/compat/hidd.c
+++ b/compat/hidd.c
@@ -573,7 +573,7 @@ static void do_search(int ctl, bdaddr_t *bdaddr, uint8_t subclass, int fakehid,
 
 	for (i = 0; i < num_rsp; i++) {
 		memcpy(class, (info+i)->dev_class, 3);
-		if ((class[0] == 0x00 && class[2] == 0x00 && 
+		if ((class[0] == 0x00 && class[2] == 0x00 &&
 				(class[1] == 0x40 || class[1] == 0x1f)) ||
 				(class[0] == 0x10 && class[1] == 0x02 && class[2] == 0x40)) {
 			bacpy(&dst, &(info+i)->bdaddr);
diff --git a/compat/msdun.c b/compat/msdun.c
index 2d592d7..ae88c0c 100644
--- a/compat/msdun.c
+++ b/compat/msdun.c
@@ -58,7 +58,7 @@ static int w4_str(int fd, char *str)
 	char buf[40];
 	unsigned len = 0;
 	int r;
-	
+
 	while (1) {
 		r = read(fd, buf + len, sizeof(buf) - len - 1);
 		if (r < 0) {
@@ -92,7 +92,7 @@ static int ms_server(int fd)
 		write_n(fd, "CLIENTSERVER", 12);
 	case MS_PPP:
 		return MS_SUCCESS;
-	default:	
+	default:
 		return MS_FAILED;
 	}
 }
@@ -123,7 +123,7 @@ int ms_dun(int fd, int server, int timeo)
 
 			alarm(0);
 			signal(SIGALRM, osig);
-		
+
 			switch (r) {
 			case MS_SUCCESS:
 			case MS_PPP:
@@ -142,7 +142,7 @@ int ms_dun(int fd, int server, int timeo)
 		}
 
 		alarm(timeout);
-		
+
 		if (server)
 			r = ms_server(fd);
 		else
diff --git a/compat/pand.c b/compat/pand.c
index e38cfb6..c3860fa 100644
--- a/compat/pand.c
+++ b/compat/pand.c
@@ -343,7 +343,7 @@ static int create_connection(char *dst, bdaddr_t *bdaddr)
 	bacpy(&l2a.l2_bdaddr, bdaddr);
 	l2a.l2_psm = htobs(BNEP_PSM);
 
-	if (!connect(sk, (struct sockaddr *) &l2a, sizeof(l2a)) && 
+	if (!connect(sk, (struct sockaddr *) &l2a, sizeof(l2a)) &&
 			!bnep_create_connection(sk, role, service, netdev)) {
 
 		syslog(LOG_INFO, "%s connected", netdev);
@@ -430,7 +430,7 @@ static int do_connect(void)
 			ba2str(&ii[i].bdaddr, dst);
 
 			if (use_sdp) {
-				syslog(LOG_INFO, "Searching for %s on %s", 
+				syslog(LOG_INFO, "Searching for %s on %s",
 						bnep_svc2str(service), dst);
 
 				if (bnep_sdp_search(&src_addr, &ii[i].bdaddr, service) <= 0)
@@ -488,7 +488,7 @@ static int write_pidfile(void)
 							strerror(errno), errno);
 				return -1;
 			}
-			
+
 			/* We're already running; send a SIGHUP (we presume that they
 			 * are calling ifup for a reason, so they probably want to
 			 * rescan) and then exit cleanly and let things go on in the
@@ -571,7 +571,7 @@ static struct option main_lopts[] = {
 
 static const char *main_sopts = "hsc:k:Kr:d:e:i:lnp::DQ::AESMC::P:u:o:z";
 
-static const char *main_help = 
+static const char *main_help =
 	"Bluetooth PAN daemon version %s\n"
 	"Usage:\n"
 	"\tpand <options>\n"
diff --git a/compat/sdp.c b/compat/sdp.c
index 358a02c..8898136 100644
--- a/compat/sdp.c
+++ b/compat/sdp.c
@@ -368,7 +368,7 @@ int get_alternate_device_info(const bdaddr_t *src, const bdaddr_t *dst, uint16_t
 	return -EIO;
 }
 
-void bnep_sdp_unregister(void) 
+void bnep_sdp_unregister(void)
 {
 	if (record && sdp_record_unregister(session, record))
 		syslog(LOG_ERR, "Service record unregistration failed.");
@@ -424,7 +424,7 @@ int bnep_sdp_register(bdaddr_t *device, uint16_t role)
 
 	/* Supported protocols */
 	{
-		uint16_t ptype[4] = { 
+		uint16_t ptype[4] = {
 			0x0800,  /* IPv4 */
 			0x0806,  /* ARP */
 		};
@@ -483,7 +483,7 @@ int bnep_sdp_register(bdaddr_t *device, uint16_t role)
 		profile[0].version = 0x0100;
 		pfseq = sdp_list_append(NULL, &profile[0]);
 		sdp_set_profile_descs(record, pfseq);
-		
+
 		sdp_set_info_attr(record, "Group Network Service", name, desc);
 		break;
 
@@ -558,7 +558,7 @@ int bnep_sdp_search(bdaddr_t *src, bdaddr_t *dst, uint16_t service)
 static unsigned char async_uuid[] = {	0x03, 0x50, 0x27, 0x8F, 0x3D, 0xCA, 0x4E, 0x62,
 					0x83, 0x1D, 0xA4, 0x11, 0x65, 0xFF, 0x90, 0x6C };
 
-void dun_sdp_unregister(void) 
+void dun_sdp_unregister(void)
 {
 	if (record && sdp_record_unregister(session, record))
 		syslog(LOG_ERR, "Service record unregistration failed.");
@@ -575,7 +575,7 @@ int dun_sdp_register(bdaddr_t *device, uint8_t channel, int type)
 
 	session = sdp_connect(BDADDR_ANY, BDADDR_LOCAL, 0);
 	if (!session) {
-		syslog(LOG_ERR, "Failed to connect to the local SDP server. %s(%d)", 
+		syslog(LOG_ERR, "Failed to connect to the local SDP server. %s(%d)",
 				strerror(errno), errno);
 		return -1;
 	}
@@ -670,7 +670,7 @@ int dun_sdp_search(bdaddr_t *src, bdaddr_t *dst, int *channel, int type)
 
 	s = sdp_connect(src, dst, 0);
 	if (!s) {
-		syslog(LOG_ERR, "Failed to connect to the SDP server. %s(%d)", 
+		syslog(LOG_ERR, "Failed to connect to the SDP server. %s(%d)",
 				strerror(errno), errno);
 		return -1;
 	}
-- 
1.7.0.4

