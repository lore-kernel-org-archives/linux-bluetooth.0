Return-Path: <cyrus@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Add -v and -d options to l2ping
Message-Id: <20090107021925.0B49537A5CE@localhost>
Date: Tue,  6 Jan 2009 18:19:25 -0800 (PST)
From: npelly@google.com (Nick Pelly)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--- a/tools/l2ping.c	2008-08-29 15:42:24.000000000 -0700
+++ b/tools/l2ping.c	2009-01-06 17:26:29.000000000 -0800
@@ -51,6 +51,7 @@
 static int count   = -1;
 static int timeout = 10;
 static int reverse = 0;
+static int verify = 0;
 
 /* Stats */
 static int sent_pkt = 0;
@@ -73,7 +74,8 @@
 	struct sigaction sa;
 	struct sockaddr_l2 addr;
 	socklen_t optlen;
-	unsigned char *buf;
+	unsigned char *send_buf;
+	unsigned char *recv_buf;
 	char str[18];
 	int i, sk, lost;
 	uint8_t id;
@@ -82,8 +84,9 @@
 	sa.sa_handler = stat;
 	sigaction(SIGINT, &sa, NULL);
 
-	buf = malloc(L2CAP_CMD_HDR_SIZE + size);
-	if (!buf) {
+	send_buf = malloc(L2CAP_CMD_HDR_SIZE + size);
+	recv_buf = malloc(L2CAP_CMD_HDR_SIZE + size);
+	if (!send_buf || !recv_buf) {
 		perror("Can't allocate buffer");
 		exit(1);
 	}
@@ -92,8 +95,7 @@
 	sk = socket(PF_BLUETOOTH, SOCK_RAW, BTPROTO_L2CAP);
 	if (sk < 0) {
 		perror("Can't create socket");
-		free(buf);
-		exit(1);
+		goto error;
 	}
 
 	/* Bind to local address */
@@ -103,9 +105,7 @@
 
 	if (bind(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
 		perror("Can't bind socket");
-		close(sk);
-		free(buf);
-		exit(1);
+		goto error;
 	}
 
 	/* Connect to remote device */
@@ -115,9 +115,7 @@
 
 	if (connect(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
 		perror("Can't connect");
-		close(sk);
-		free(buf);
-		exit(1);
+		goto error;
 	}
 
 	/* Get local address */
@@ -126,39 +124,38 @@
 
 	if (getsockname(sk, (struct sockaddr *) &addr, &optlen) < 0) {
 		perror("Can't get local address");
-		close(sk);
-		free(buf);
-		exit(1);
+		goto error;
 	}
 
 	ba2str(&addr.l2_bdaddr, str);
 	printf("Ping: %s from %s (data size %d) ...\n", svr, str, size);
 
-	/* Initialize buffer */
+	/* Initialize send buffer */
 	for (i = 0; i < size; i++)
-		buf[L2CAP_CMD_HDR_SIZE + i] = (i % 40) + 'A';
+		send_buf[L2CAP_CMD_HDR_SIZE + i] = (i % 40) + 'A';
 
 	id = ident;
 
 	while (count == -1 || count-- > 0) {
 		struct timeval tv_send, tv_recv, tv_diff;
-		l2cap_cmd_hdr *cmd = (l2cap_cmd_hdr *) buf;
+		l2cap_cmd_hdr *send_cmd = (l2cap_cmd_hdr *) send_buf;
+		l2cap_cmd_hdr *recv_cmd = (l2cap_cmd_hdr *) recv_buf;
 
 		/* Build command header */
-		cmd->ident = id;
-		cmd->len   = htobs(size);
+		send_cmd->ident = id;
+		send_cmd->len   = htobs(size);
 
 		if (reverse)
-			cmd->code = L2CAP_ECHO_RSP;
+			send_cmd->code = L2CAP_ECHO_RSP;
 		else
-			cmd->code = L2CAP_ECHO_REQ;
+			send_cmd->code = L2CAP_ECHO_REQ;
 
 		gettimeofday(&tv_send, NULL);
 
 		/* Send Echo Command */
-		if (send(sk, buf, L2CAP_CMD_HDR_SIZE + size, 0) <= 0) {
+		if (send(sk, send_buf, L2CAP_CMD_HDR_SIZE + size, 0) <= 0) {
 			perror("Send failed");
-			exit(1);
+			goto error;
 		}
 
 		/* Wait for Echo Response */
@@ -172,7 +169,7 @@
 
 			if ((err = poll(pf, 1, timeout * 1000)) < 0) {
 				perror("Poll failed");
-				exit(1);
+				goto error;
 			}
 
 			if (!err) {
@@ -180,29 +177,29 @@
 				break;
 			}
 
-			if ((err = recv(sk, buf, L2CAP_CMD_HDR_SIZE + size, 0)) < 0) {
+			if ((err = recv(sk, recv_buf, L2CAP_CMD_HDR_SIZE + size, 0)) < 0) {
 				perror("Recv failed");
-				exit(1);
+				goto error;
 			}
 
 			if (!err){
 				printf("Disconnected\n");
-				exit(1);
+				goto error;
 			}
 
-			cmd->len = btohs(cmd->len);
+			recv_cmd->len = btohs(recv_cmd->len);
 
 			/* Check for our id */
-			if (cmd->ident != id)
+			if (recv_cmd->ident != id)
 				continue;
 
 			/* Check type */
-			if (!reverse && cmd->code == L2CAP_ECHO_RSP)
+			if (!reverse && recv_cmd->code == L2CAP_ECHO_RSP)
 				break;
 
-			if (cmd->code == L2CAP_COMMAND_REJ) {
+			if (recv_cmd->code == L2CAP_COMMAND_REJ) {
 				printf("Peer doesn't support Echo packets\n");
-				exit(1);
+				goto error;
 			}
 
 		}
@@ -214,7 +211,24 @@
 			gettimeofday(&tv_recv, NULL);
 			timersub(&tv_recv, &tv_send, &tv_diff);
 
-			printf("%d bytes from %s id %d time %.2fms\n", cmd->len, svr, id - ident, tv2fl(tv_diff));
+			if (verify) {
+				/* Check payload length */
+				if (recv_cmd->len != size) {
+					fprintf(stderr, "Received %d bytes, expected %d\n",
+						   recv_cmd->len, size);
+					goto error;
+				}
+
+				/* Check payload */
+				if (memcmp(&send_buf[L2CAP_CMD_HDR_SIZE],
+						   &recv_buf[L2CAP_CMD_HDR_SIZE], size)) {
+					fprintf(stderr, "Response payload different.\n");
+					goto error;
+				}
+			}
+
+			printf("%d bytes from %s id %d time %.2fms\n", recv_cmd->len, svr,
+				   id - ident, tv2fl(tv_diff));
 
 			if (delay)
 				sleep(delay);
@@ -226,13 +240,25 @@
 			id = ident;
 	}
 	stat(0);
+	return;
+
+error:
+	close(sk);
+	free(send_buf);
+	free(recv_buf);
+	exit(1);
 }
 
 static void usage(void)
 {
 	printf("l2ping - L2CAP ping\n");
 	printf("Usage:\n");
-	printf("\tl2ping [-i device] [-s size] [-c count] [-t timeout] [-f] [-r] <bdaddr>\n");
+	printf("\tl2ping [-i device] [-s size] [-c count] [-t timeout] [-d delay] [-f] [-r] [-v] <bdaddr>\n");
+	printf("\t-f  Flood ping (delay = 0)\n");
+	printf("\t-r  Reverse ping\n");
+	printf("\t-v  Verify the request and response payload are identical.\n");
+	printf("\t    This is not required by the Bluetooth spec, but will work\n");
+	printf("\t    with most remote stacks, including bluez.\n");
 }
 
 int main(int argc, char *argv[])
@@ -242,7 +268,7 @@
 	/* Default options */
 	bacpy(&bdaddr, BDADDR_ANY);
 
-	while ((opt=getopt(argc,argv,"i:s:c:t:fr")) != EOF) {
+	while ((opt=getopt(argc,argv,"i:d:s:c:t:frv")) != EOF) {
 		switch(opt) {
 		case 'i':
 			if (!strncasecmp(optarg, "hci", 3))
@@ -251,6 +277,10 @@
 				str2ba(optarg, &bdaddr);
 			break;
 
+		case 'd':
+			delay = atoi(optarg);
+			break;
+
 		case 'f':
 			/* Kinda flood ping */
 			delay = 0;
@@ -261,6 +291,10 @@
 			reverse = 1;
 			break;
 
+		case 'v':
+			verify = 1;
+			break;
+
 		case 'c':
 			count = atoi(optarg);
 			break;
