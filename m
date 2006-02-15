Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43F2E0C4.4040204@ubuntu.com>
From: Charles Majola <charles@ubuntu.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-devel] [PATCH] Unsafe handling of -e option in pand
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
Date: Wed, 15 Feb 2006 10:05:24 +0200

 From this bug report :

https://launchpad.net/distros/ubuntu/+source/bluez-utils/+bug/6714

--- bluez-utils/pand/bnep.c	
+++ bluez-utils/pand/bnep.c	
@@ -184,13 +184,13 @@
 {
 	struct bnep_connadd_req req;
 
-	strcpy(req.device, dev);
+	strncpy(req.device, dev, 16);
 	req.sock = sk;
 	req.role = role;
 	req.flow_label = 0;     /* 0 == Best Effort QoS */
 	if (ioctl(ctl, bnepconnadd, &req))
 		return -1;
-	strcpy(dev, req.device);
+	strncpy(dev, req.device, 16);
 	return 0;
 }
 

=== modified file 'bluez-utils/pand/main.c'
--- bluez-utils/pand/main.c	
+++ bluez-utils/pand/main.c	
@@ -182,6 +182,8 @@
 	while (!terminate) {
 		socklen_t alen = sizeof(l2a);
 		int nsk;
+                char this_netdev[16];
+                
 		nsk = accept(sk, (struct sockaddr *) &l2a, &alen);
 		if (nsk < 0) {
 			syslog(LOG_ERR, "Accept failed. %s(%d)", strerror(errno), errno);
@@ -197,14 +199,14 @@
 			close(nsk);
 			continue;
 		}
-
-		if (!bnep_accept_connection(nsk, role, netdev)) {
+                strncpy(this_netdev, netdev, 16);
+		if (!bnep_accept_connection(nsk, role, this_netdev)) {
 			char str[40];
 			ba2str(&l2a.l2_bdaddr, str);
 
 			syslog(LOG_INFO, "New connection from %s %s", str, netdev);
 
-			run_devup(netdev, str, sk, nsk);
+			run_devup(this_netdev, str, sk, nsk);
 		} else {
 			syslog(LOG_ERR, "Connection failed. %s(%d)",
 					strerror(errno), errno);
@@ -608,7 +610,7 @@
 			break;
 
 		case 'e':
-			strcpy(netdev, optarg);
+			strncpy(netdev, optarg, 16);
 			break;
 
 		case 'n':



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
