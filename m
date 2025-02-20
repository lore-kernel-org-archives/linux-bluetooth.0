Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA241E9907
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Feb 2025 07:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740036166; cv=none; b=SCSlRZdq2HY8pGmzl2CGtKpJeMZjTko3i0qdnKAEcV1Fs9Fc5eyi3p24Hs4k0nqbOkDYHkzSAYpqzJryA6+RlHud4Ib5vEgjRE7OyJUdydHWaFRw1PTl1ekpnWf7tf80ZU165iZFTyoDrUblnrhi8vXpuiQkZMCh/X78W2+9D0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740036166; c=relaxed/simple;
	bh=Z98/CUiwRsJ+LUORJ1OUEAgC2g8ZpQGCFDJnKEJUl2Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Tijsffd7HQBviTMNkK0VcgKJ1L0yMTC+LECpxFdi2dVvRukWYisdDqRWXk/prjOMtYEprw+l6WW0cGyeg2q4UjlGHDlw5kqvQgr5qF7Hf8SRuiFAhXgRYZppXlHKAmqOiGIfcKy1ag4ArYYK6iacSvWWgLbvmj6Ce2jqbFFEUyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QmbhWQ4e; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QmbhWQ4e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740036161;
	bh=Z98/CUiwRsJ+LUORJ1OUEAgC2g8ZpQGCFDJnKEJUl2Q=;
	h=From:To:Subject:Date:From;
	b=QmbhWQ4eXnu6kttkLNDXH1/98NyOUSu76UXrdTOt0PFZgPV7+1hD8TacpMcWv4ZTN
	 DXOZTFGPWFyAm69aCVg4XNjI9kYh0YS7FPGx0uBaTciKEaW5gF89wbqHnHJ1IjL5rt
	 I/fy+tPscztZ/I1EmNHetzF6cDvn1008CTT+wYM3zKXC7vabnLpmd9sUbX+mGraj3Y
	 DEJmTu9uBx/N2xsj96MV5cJ38SFIausQlqnfdaXVzF9JMWpDp6Am/myzgkB9lJGm33
	 OnHnWSD4zFdubi2bsarGbAHmHyHhlmq2q9kxkfR6/pHd3oBv3d2G8hCBGDNr7Bjv5t
	 A6rVeI+Nwo9/Q==
Received: from fdanis-XPS-13-9370.. (2A02-8428-aF44-1001-98FD-0e9A-Da79-5443.rev.sfr.net [IPv6:2a02:8428:af44:1001:98fd:e9a:da79:5443])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A827F17E1560
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Feb 2025 08:22:41 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] tools/avtest: Add AAC configuration
Date: Thu, 20 Feb 2025 08:22:35 +0100
Message-ID: <20250220072235.189814-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The tests A2DP/SNK/AVP/BI-01-C, A2DP/SNK/AVP/BI-02-C,
A2DP/SNK/AVP/BI-05-C and  A2DP/SNK/AVP/BI-07-C expect the IUT to
provide an AAC configuration.

This can be used by adding '--aac' to the avtest command, e.g. for
A2DP/SNK/AVP/BI-01-C test:
 tools/avtest --aac --reject setconf --reject-code 214
---
 tools/avtest.c | 49 +++++++++++++++++++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 12 deletions(-)

diff --git a/tools/avtest.c b/tools/avtest.c
index 5ac3418aa..a52662d80 100644
--- a/tools/avtest.c
+++ b/tools/avtest.c
@@ -151,7 +151,7 @@ struct avctp_header {
 
 #define AVCTP_PACKET_SINGLE	0
 
-static const unsigned char media_transport[] = {
+static const unsigned char media_transport_sbc[] = {
 		0x01,	/* Media transport category */
 		0x00,
 		0x07,	/* Media codec category */
@@ -164,6 +164,24 @@ static const unsigned char media_transport[] = {
 		0x33,
 };
 
+static const unsigned char media_transport_aac[] = {
+		0x01,	/* Media transport category */
+		0x00,
+		0x07,	/* Media codec category */
+		0x08,
+		0x00,	/* Media type audio */
+		0x02,	/* Codec MPEG2,4 AAC */
+		0x80,	/* Codec MPEG-2 AAC LC */
+		0x01,	/* 44100 */
+		0x8C,	/* 48000, 1 and 2 channels */
+		0x84,	/* VBR supported, Max peak rate 320000 */
+		0xE2,
+		0x00
+};
+
+static const unsigned char *media_transport = media_transport_sbc;
+static size_t media_transport_size = sizeof(media_transport_sbc);
+
 static int media_sock = -1;
 
 static void dump_avctp_header(struct avctp_header *hdr)
@@ -254,30 +272,30 @@ static void process_avdtp(int srv_sk, int sk, unsigned char reject,
 				start->signal_id = AVDTP_GET_CAPABILITIES;
 				start->no_of_packets = 3;
 				memcpy(&buf[3], media_transport,
-						sizeof(media_transport));
+						media_transport_size);
 				len = write(sk, buf,
 						3 + sizeof(media_transport));
 
 				/* Continue packet */
 				hdr->packet_type = AVDTP_PKT_TYPE_CONTINUE;
 				memcpy(&buf[1], media_transport,
-						sizeof(media_transport));
+						media_transport_size);
 				len = write(sk, buf,
-						1 + sizeof(media_transport));
+						1 + media_transport_size);
 
 				/* End packet */
 				hdr->packet_type = AVDTP_PKT_TYPE_END;
 				memcpy(&buf[1], media_transport,
-						sizeof(media_transport));
+						media_transport_size);
 				len = write(sk, buf,
-						1 + sizeof(media_transport));
+						1 + media_transport_size);
 			} else {
 				hdr->message_type = AVDTP_MSG_TYPE_ACCEPT;
 				memcpy(&buf[2], media_transport,
-						sizeof(media_transport));
+						media_transport_size);
 				printf("Accepting get capabilities command\n");
 				len = write(sk, buf,
-						2 + sizeof(media_transport));
+						2 + media_transport_size);
 			}
 			break;
 
@@ -578,10 +596,10 @@ static void do_avdtp_send(int sk, const bdaddr_t *src, const bdaddr_t *dst,
 		hdr->signal_id = AVDTP_SET_CONFIGURATION;
 		buf[2] = 1 << 2; /* ACP SEID */
 		buf[3] = 1 << 2; /* INT SEID */
-		memcpy(&buf[4], media_transport, sizeof(media_transport));
+		memcpy(&buf[4], media_transport, media_transport_size);
 		if (invalid)
 			buf[5] = 0x01; /* LOSC != 0 */
-		len = write(sk, buf, 4 + sizeof(media_transport));
+		len = write(sk, buf, 4 + media_transport_size);
 		break;
 
 	case AVDTP_GET_CONFIGURATION:
@@ -717,7 +735,8 @@ static void usage(void)
 		"\t--preconf            Configure stream before actual command\n"
 		"\t--wait <N>           Wait N seconds before exiting\n"
 		"\t--fragment           Use minimum MTU and fragmented messages\n"
-		"\t--invalid <command>  Send invalid command\n");
+		"\t--invalid <command>  Send invalid command\n"
+		"\t--aac                MPEG2,4 AAC LC\n");
 }
 
 static struct option main_options[] = {
@@ -731,6 +750,7 @@ static struct option main_options[] = {
 	{ "fragment",   0, 0, 'F' },
 	{ "avctp",	0, 0, 'C' },
 	{ "wait",	1, 0, 'w' },
+	{ "aac",	0, 0, 'a' },
 	{ 0, 0, 0, 0 }
 };
 
@@ -774,7 +794,7 @@ int main(int argc, char *argv[])
 	bacpy(&src, BDADDR_ANY);
 	bacpy(&dst, BDADDR_ANY);
 
-	while ((opt = getopt_long(argc, argv, "+i:r:s:f:hcFCw:R:",
+	while ((opt = getopt_long(argc, argv, "+i:r:s:f:hcFCw:R:a",
 						main_options, NULL)) != EOF) {
 		switch (opt) {
 		case 'i':
@@ -818,6 +838,11 @@ int main(int argc, char *argv[])
 			reject_code = atoi(optarg);
 			break;
 
+		case 'a':
+			media_transport = media_transport_aac;
+			media_transport_size = sizeof(media_transport_aac);
+			break;
+
 		case 'h':
 		default:
 			usage();
-- 
2.43.0

