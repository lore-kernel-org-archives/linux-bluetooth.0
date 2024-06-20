Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C90B1AB52F
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Jun 2024 11:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718882554; cv=none; b=u3QeDvq9cfKvJSJ1rLY8t7gCwAeO1XRs3IwPGEDqVtdIDN9pcjiyD2KL14WhKIYVJ/1CTXOtj8PC7Adsg8WxEsEycY6RVSrPVCQ3kwcweQ44+zwDxDdIJZpaz3KFmQ0+YgFb1B0foKZTWEVWDW5uVM8vEDZEomJh7291Y/bFcOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718882554; c=relaxed/simple;
	bh=KSQNhnxXqD6pAnmu5zV/YHUhdPhy1hnd+Kowcs0L8fY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TaLXzKLmMwy+jpAlpKl3iNvSlUmutVQ8Z+w1KeWtPVQu2gYb0IyK4Mq5CLBLmiNngP9oKqqLsoDbJ78oHpa245ItYWpo8q6HfG7zXB9qhXDOWDT56EkxdF2D6GM717G8jSAv34rPERRl9mW3sQBi7f10VR/QtRLSwe/H6IqnD9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ii88TDq7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ii88TDq7"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45K9v6O0029160
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Jun 2024 11:22:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=VPoWkE2nE3TYdkTedv1Uk81sDA+J6llFhLXF0ODh0ec=; b=Ii
	88TDq7zORejmPWUKGmB/n6qz9wk1sKLEiXM+d/UFsnxdU+gOx7CXL7TRg51Ks3XM
	c3o9iZBYBaPYru35d7A2ADsob7oNhRqZ/Q3DNsjy2XaaGPE5xIpfWVbZe1Z2/wT0
	4enfcDA3USIK1bpxr1Cc+vD1gPlQpVUWciCqSRHFzyIU4aw+1kjMKaj60Aw+7C9+
	g2gmVqUfoq+zWKw25Tp1+9UQuwTNnVH9hhqCCgmzkD3H8yWhhOX+PYbDw2px6JuR
	9FtnRbZFZglBcJzJfJhDfdY/qhA6gA6+CEYpMcSBBeP33Z/q/O0lzWI4Wb48K4wc
	OCWpdNO0QMUEq+758VUA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yvabp16xx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Jun 2024 11:22:30 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45KBMQl7004949
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Jun 2024 11:22:26 GMT
Received: from hu-prathm-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 20 Jun 2024 04:22:24 -0700
From: <quic_prathm@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <quic_anubhavg@quicinc.com>
Subject: [PATCH v1] [PTS] Included peripheral mode for fixing of few PTS Test Cases
Date: Thu, 20 Jun 2024 16:52:09 +0530
Message-ID: <20240620112209.12287-1-quic_prathm@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wrahzQ2K2ure87ZJgILhz1lnAIURlnl_
X-Proofpoint-ORIG-GUID: wrahzQ2K2ure87ZJgILhz1lnAIURlnl_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_07,2024-06-20_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 phishscore=0 mlxscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406200078

From: Prathibha Madugonde <quic_prathm@quicinc.com>

Fix for below Test Cases:
GAP/SEC/SEM/BV-56-C
GAP/SEC/SEM/BV-57-C
GAP/SEC/SEM/BV-58-C
GAP/SEC/SEM/BV-59-C
GAP/SEC/SEM/BV-60-C
GAP/SEC/SEM/BV-61-C

For all above test cases, PTS tool is adding Battery Level Characteristics in the GAP service. And PTS is expecting to write value to Battery Level Characteristics.
When IUT and PTS are connected from bluetoothctl tool, GAP service and its characterisitics are not showing in the bluetoothctl terminal.
Therefore need to use other existing tools, here we used btgatt-client tool.
For GAP/SEC/SEM/BV-56-C , GAP/SEC/SEM/BV-57-C, GAP/SEC/SEM/BV-58-C test cases the IUT should be in peripheral mode(advertise and accept connection) and GATT client role as per GAP.TS.p44.
Added peripheral mode in the btgatt-client tool for PASSING those test cases.

Signed-off-by: Prathibha Madugonde <quic_prathm@quicinc.com>
---
 tools/btgatt-client.c | 97 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 91 insertions(+), 6 deletions(-)

diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index b47914da3..2b732e454 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -36,6 +36,8 @@
 #include "src/shared/gatt-helpers.h"
 
 #define ATT_CID 4
+#define CENTRAL_MODE   1
+#define PERIPHERAL_MODE   2
 
 #define PRLOG(...) \
 	printf(__VA_ARGS__); print_prompt();
@@ -1633,6 +1635,68 @@ static void signal_cb(int signum, void *user_data)
 	}
 }
 
+static int l2cap_le_att_listen_and_accept(bdaddr_t *src, int sec,
+							uint8_t src_type)
+{
+	int sk, nsk;
+	struct sockaddr_l2 srcaddr, addr;
+	socklen_t optlen;
+	struct bt_security btsec;
+	char ba[18];
+
+	sk = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP);
+	if (sk < 0) {
+		perror("Failed to create L2CAP socket");
+		return -1;
+	}
+
+	/* Set up source address */
+	memset(&srcaddr, 0, sizeof(srcaddr));
+	srcaddr.l2_family = AF_BLUETOOTH;
+	srcaddr.l2_cid = htobs(ATT_CID);
+	srcaddr.l2_bdaddr_type = src_type;
+	bacpy(&srcaddr.l2_bdaddr, src);
+
+	if (bind(sk, (struct sockaddr *) &srcaddr, sizeof(srcaddr)) < 0) {
+		perror("Failed to bind L2CAP socket");
+		goto fail;
+	}
+
+	/* Set the security level */
+	memset(&btsec, 0, sizeof(btsec));
+	btsec.level = sec;
+	if (setsockopt(sk, SOL_BLUETOOTH, BT_SECURITY, &btsec,
+							sizeof(btsec)) != 0) {
+		fprintf(stderr, "Failed to set L2CAP security level\n");
+		goto fail;
+	}
+
+	if (listen(sk, 10) < 0) {
+		perror("Listening on socket failed");
+		goto fail;
+	}
+
+	printf("Started listening on ATT channel. Waiting for connections\n");
+
+	memset(&addr, 0, sizeof(addr));
+	optlen = sizeof(addr);
+	nsk = accept(sk, (struct sockaddr *) &addr, &optlen);
+	if (nsk < 0) {
+		perror("Accept failed");
+		goto fail;
+	}
+
+	ba2str(&addr.l2_bdaddr, ba);
+	printf("Connect from %s\n", ba);
+	close(sk);
+
+	return nsk;
+
+fail:
+	close(sk);
+	return -1;
+}
+
 static int l2cap_le_att_connect(bdaddr_t *src, bdaddr_t *dst, uint8_t dst_type,
 									int sec)
 {
@@ -1709,6 +1773,7 @@ static void usage(void)
 	printf("Options:\n"
 		"\t-i, --index <id>\t\tSpecify adapter index, e.g. hci0\n"
 		"\t-d, --dest <addr>\t\tSpecify the destination address\n"
+		"\t-p, --peripheral mode\t\t\tStar Listening on Att Channel\n"
 		"\t-t, --type [random|public] \tSpecify the LE address type\n"
 		"\t-m, --mtu <mtu> \t\tThe ATT MTU to use\n"
 		"\t-s, --security-level <sec> \tSet security level (low|medium|"
@@ -1720,6 +1785,7 @@ static void usage(void)
 static struct option main_options[] = {
 	{ "index",		1, 0, 'i' },
 	{ "dest",		1, 0, 'd' },
+	{ "peripheral",		1, 0, 'p' },
 	{ "type",		1, 0, 't' },
 	{ "mtu",		1, 0, 'm' },
 	{ "security-level",	1, 0, 's' },
@@ -1738,9 +1804,10 @@ int main(int argc, char *argv[])
 	bdaddr_t src_addr, dst_addr;
 	int dev_id = -1;
 	int fd;
+	int peri_cent = CENTRAL_MODE;
 	struct client *cli;
 
-	while ((opt = getopt_long(argc, argv, "+hvs:m:t:d:i:",
+	while ((opt = getopt_long(argc, argv, "+hvs:m:t:d:p:i:",
 						main_options, NULL)) != -1) {
 		switch (opt) {
 		case 'h':
@@ -1809,6 +1876,17 @@ int main(int argc, char *argv[])
 			}
 
 			break;
+		case 'p':
+			if (strcmp(optarg, "peripheral") == 0)
+				 peri_cent = PERIPHERAL_MODE;
+			else if (strcmp(optarg, "central") == 0)
+				peri_cent = CENTRAL_MODE;
+			else {
+				fprintf(stderr,
+					"Allowed Modes: peripheral, central\n");
+				return EXIT_FAILURE;
+			}
+            break;
 		default:
 			fprintf(stderr, "Invalid option: %c\n", opt);
 			return EXIT_FAILURE;
@@ -1836,14 +1914,21 @@ int main(int argc, char *argv[])
 		return EXIT_FAILURE;
 	}
 
-	if (!dst_addr_given) {
-		fprintf(stderr, "Destination address required!\n");
-		return EXIT_FAILURE;
-	}
+    if(peri_cent == CENTRAL_MODE)
+    {
+        if (!dst_addr_given) {
+            fprintf(stderr, "Destination address required!\n");
+            return EXIT_FAILURE;
+        }
+
+    }
 
 	mainloop_init();
 
-	fd = l2cap_le_att_connect(&src_addr, &dst_addr, dst_type, sec);
+    if(peri_cent == CENTRAL_MODE)
+        fd = l2cap_le_att_connect(&src_addr, &dst_addr, dst_type, sec);
+    else
+        fd = l2cap_le_att_listen_and_accept(&src_addr, sec, BDADDR_LE_PUBLIC);
 	if (fd < 0)
 		return EXIT_FAILURE;
 
-- 
2.17.1

