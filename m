Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: David Woodhouse <dwmw2@infradead.org>
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1051440611.2850.138.camel@imladris.demon.co.uk>
Mime-Version: 1.0
Subject: [Bluez-devel] [PATCH] Check return code of pin helper.
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 27 Apr 2003 11:50:11 +0100

On Red Hat 9, the python interpreter segfaults when running bluepin if
hcid is started from the init script, but it all works fine if hcid was
started from a command prompt. This confuses me, but it confused me even
more before I make hcid report what was happening...

Apr 27 11:42:35 imladris hcid[31158]: PIN helper exited abnormally with code 11

--- bluez-utils-2.3/hcid/security.c~	2003-03-20 05:58:12.000000000 +0000
+++ bluez-utils-2.3/hcid/security.c	2003-04-27 11:34:41.000000000 +0100
@@ -224,10 +224,11 @@
 static void call_pin_helper(int dev, struct hci_conn_info *ci)
 {
 	pin_code_reply_cp pr;
+	struct sigaction sa;
 	char str[255], *pin, name[20];
 	bdaddr_t ba;
 	FILE *pipe;
-	int len;
+	int len, ret;
 	
 	/* Run PIN helper in the separate process */
 	switch (fork()) {
@@ -256,6 +257,11 @@
 
 	setenv("PATH", "/bin:/usr/bin:/usr/local/bin", 1);
 
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_flags = SA_NOCLDSTOP;
+	sa.sa_handler = SIG_DFL;
+	sigaction(SIGCHLD, &sa, NULL);
+
 	pipe = popen(str, "r");
 	if (!pipe) {
 		syslog(LOG_ERR, "Can't exec PIN helper. %s(%d)", strerror(errno), errno);
@@ -263,15 +269,15 @@
 	}	
 
 	pin = fgets(str, sizeof(str), pipe);
-	pclose(pipe);
+	ret = pclose(pipe);
 
 	if (!pin || strlen(pin) < 5)
-		goto reject;
+		goto nopin;
 
 	strtok(pin, "\n\r");
 
 	if (strncmp("PIN:", pin, 4))
-		goto reject;
+		goto nopin;
 
 	pin += 4;
 	len  = strlen(pin);
@@ -284,6 +290,10 @@
 			PIN_CODE_REPLY_CP_SIZE, &pr);
 	exit(0);
 
+ nopin:
+	if (!pin || strncmp("ERR", pin, 3))
+		syslog(LOG_ERR, "PIN helper exited abnormally with code %d\n", ret);
+
 reject:
 	hci_send_cmd(dev, OGF_LINK_CTL, OCF_PIN_CODE_NEG_REPLY, 6, &ci->bdaddr);
 	exit(0);



-- 
dwmw2




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
