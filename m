Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="========GMX308691193144858563618"
Date: Tue, 23 Oct 2007 15:07:38 +0200
From: "eGore" <eGore@gmx.de>
Message-ID: <20071023130738.308690@gmx.net>
MIME-Version: 1.0
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] [PATCH] randomizer for passkey-agent
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--========GMX308691193144858563618
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hi list,

I wanted a passkey-agent that does not always use the same passkey so it can run in daemon mode and provide passkeys. This is an attempt to implement this functionality.

Please review and commit.

Thanks in advance,
  Christoph Brill
-- 
Psssst! Schon vom neuen GMX MultiMessenger gehört?
Der kanns mit allen: http://www.gmx.net/de/go/multimessenger

--========GMX308691193144858563618
Content-Type: text/x-patch; charset="iso-8859-15";
	name="bluez-passkey-random.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="bluez-passkey-random.patch"

--- daemon/passkey-agent.c.org	2007-01-25 16:09:25.000000000 +0100
+++ daemon/passkey-agent.c	2007-10-23 15:02:48.000000000 +0200
@@ -32,6 +32,7 @@
 #include <signal.h>
 #include <getopt.h>
 #include <string.h>
+#include <time.h>
 
 #include <dbus/dbus.h>
 
@@ -39,6 +40,9 @@
 
 static char *passkey = NULL;
 static char *address = NULL;
+int use_random = 0;
+int use_default = 0;
+int key_length = 4;
 
 static volatile sig_atomic_t __io_canceled = 0;
 static volatile sig_atomic_t __io_terminated = 0;
@@ -48,6 +52,16 @@
 	__io_canceled = 1;
 }
 
+static char * next_key() {
+	int i;
+	char * key = malloc((key_length + 1) * sizeof(char));
+	for (i = 0; i < key_length; i++) {
+		key[i] = 48+(rand() %10);
+	}
+	key[key_length] = '\0';
+	return key;
+}
+
 static DBusHandlerResult agent_filter(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
@@ -78,6 +92,12 @@
 	const char *path, *address;
 	dbus_bool_t numeric;
 
+	if (use_random) {
+		if (passkey)
+			free(passkey);
+		passkey = next_key();
+	}
+
 	if (!passkey)
 		return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
 
@@ -150,7 +170,7 @@
 	if (!dbus_message_get_args(msg, NULL,
 			DBUS_TYPE_STRING, &path, DBUS_TYPE_STRING, &address,
 							DBUS_TYPE_INVALID)) {
-		fprintf(stderr, "Invalid arguments for passkey Confirm method");
+		fprintf(stderr, "Invalid arguments for passkey Cancel method");
 		return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
 	}
 
@@ -224,7 +244,7 @@
 };
 
 static int register_agent(DBusConnection *conn, const char *agent_path,
-				const char *remote_address, int use_default)
+				const char *remote_address)
 {
 	DBusMessage *msg, *reply;
 	DBusError err;
@@ -280,7 +300,7 @@
 }
 
 static int unregister_agent(DBusConnection *conn, const char *agent_path,
-				const char *remote_address, int use_default)
+				const char *remote_address)
 {
 	DBusMessage *msg, *reply;
 	DBusError err;
@@ -334,17 +354,23 @@
 
 static void usage(void)
 {
+#ifdef HAVE_CONFIG_H
 	printf("Bluetooth passkey agent ver %s\n\n", VERSION);
+#else
+	printf("Bluetooth passkey agent\n\n");
+#endif
 
 	printf("Usage:\n"
-		"\tpasskey-agent [--default] [--path agent-path] <passkey> [address]\n"
+		"\tpasskey-agent [--default] [--path agent-path] [--random] [--length keylength] <passkey> [address]\n"
 		"\n");
 }
 
 static struct option main_options[] = {
-	{ "default",	0, 0, 'd' },
-	{ "path",	1, 0, 'p' },
-	{ "help",	0, 0, 'h' },
+	{ "default", no_argument,       &use_default, 1   },
+	{ "path",    required_argument, 0,            'p' },
+	{ "help",    no_argument,       0,            'h' },
+	{ "random",  no_argument,       &use_random,  1   },
+	{ "length",  required_argument, 0,            'l' },
 	{ 0, 0, 0, 0 }
 };
 
@@ -353,12 +379,14 @@
 	struct sigaction sa;
 	DBusConnection *conn;
 	char match_string[128], default_path[128], *agent_path = NULL;
-	int opt, use_default = 0;
+	int opt = 0;
+
+	srand(time(NULL));
 
 	snprintf(default_path, sizeof(default_path),
 				"/org/bluez/passkey_agent_%d", getpid());
 
-	while ((opt = getopt_long(argc, argv, "+dp:h", main_options, NULL)) != EOF) {
+	while ((opt = getopt_long(argc, argv, "+dp:hrl:", main_options, NULL)) != EOF) {
 		switch(opt) {
 		case 'd':
 			use_default = 1;
@@ -373,8 +401,15 @@
 		case 'h':
 			usage();
 			exit(0);
+		case 'r':
+			use_random = 1;
+			break;
+		case 'l':
+			key_length = atoi(optarg);
+			use_random = 1;
+			break;
 		default:
-			exit(1);
+			abort ();
 		}
 	}
 
@@ -382,12 +417,17 @@
 	argv += optind;
 	optind = 0;
 
-	if (argc < 1) {
+	if (argc < 1 && !use_random) {
 		usage();
 		exit(1);
 	}
 
-	passkey = strdup(argv[0]);
+	if (!use_random) {
+		passkey = strdup(argv[0]);
+	} else {
+		passkey = next_key();
+	}
+
 	address = (argc > 1) ? strdup(argv[1]) : NULL;
 
 	if (!use_default && !address) {
@@ -404,7 +444,7 @@
 		exit(1);
 	}
 
-	if (register_agent(conn, agent_path, address, use_default) < 0) {
+	if (register_agent(conn, agent_path, address) < 0) {
 		dbus_connection_unref(conn);
 		exit(1);
 	}
@@ -430,7 +470,7 @@
 	}
 
 	if (!__io_terminated)
-		unregister_agent(conn, agent_path, address, use_default);
+		unregister_agent(conn, agent_path, address);
 
 	if (passkey)
 		free(passkey);

--========GMX308691193144858563618
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--========GMX308691193144858563618
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--========GMX308691193144858563618--
