Return-Path: <cyrus@holtmann.org>
From: Jiri Slaby <jirislaby@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Maxim Krasnyansky <maxk@qualcomm.com>, bluez-devel@lists.sourceforge.net,
        Jiri Slaby <jirislaby@gmail.com>
Subject: [PATCH] HIDD: add psm offset possibilty
Date: Wed, 26 Mar 2008 15:50:23 +0100
Message-Id: <1206543023-10767-1-git-send-email-jirislaby@gmail.com>
List-ID: <bluez-devel.lists.sourceforge.net>

This feature allows using cell phones as remote controllers, because it
usually denies to bind psms lower than 0x1000.

--- bluez-utils-3.29/hidd/main.c.orig	2008-03-26 15:26:15.000000000 +0100
+++ bluez-utils-3.29/hidd/main.c	2008-03-26 15:26:14.000000000 +0100
@@ -694,6 +694,7 @@
 	uint32_t flags = 0;
 	uint8_t subclass = 0x00;
 	char addr[18];
+	unsigned int psm_offset = 0;
 	int log_option = LOG_NDELAY | LOG_PID;
 	int opt, ctl, csk, isk;
 	int mode = SHOW, detach = 1, nosdp = 0, nocheck = 0, bootonly = 0;
@@ -701,7 +702,7 @@
 
 	bacpy(&bdaddr, BDADDR_ANY);
 
-	while ((opt = getopt_long(argc, argv, "+i:nt:b:MEDZBHldsc:k:Ku:h", main_options, NULL)) != -1) {
+	while ((opt = getopt_long(argc, argv, "+i:nt:b:MEDZBHldsc:k:Ku:ho:", main_options, NULL)) != -1) {
 		switch(opt) {
 		case 'i':
 			if (!strncasecmp(optarg, "hci", 3))
@@ -768,6 +769,12 @@
 		case 'h':
 			usage();
 			exit(0);
+		case 'o':
+			if (!strncasecmp(optarg, "0x", 2))
+				psm_offset = strtol(optarg, NULL, 16);
+			else
+				psm_offset = atoi(optarg);
+			break;
 		default:
 			exit(0);
 		}
@@ -783,14 +790,16 @@
 
 	switch (mode) {
 	case SERVER:
-		csk = l2cap_listen(&bdaddr, L2CAP_PSM_HIDP_CTRL, lm, 10);
+		csk = l2cap_listen(&bdaddr, psm_offset + L2CAP_PSM_HIDP_CTRL,
+				lm, 10);
 		if (csk < 0) {
 			perror("Can't listen on HID control channel");
 			close(ctl);
 			exit(1);
 		}
 
-		isk = l2cap_listen(&bdaddr, L2CAP_PSM_HIDP_INTR, lm, 10);
+		isk = l2cap_listen(&bdaddr, psm_offset + L2CAP_PSM_HIDP_INTR,
+				lm, 10);
 		if (isk < 0) {
 			perror("Can't listen on HID interrupt channel");
 			close(ctl);
