Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE8A38C42B
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Apr 2026 07:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775116584; cv=none; b=aP0puteob9Sv6w6wwTPfCHESkjen38VDHZEJsFUGiLq8x2YFOXySvJYnLHwFwUInJipALAAfSshG6fi5Kvm+KsXMdbfTIz2ZELl5W+BYVOmApV9joN20C+3z+s44N/4ZzHEG+iLq8bJ9/uBImCHPihAxHHCmHp6nGfm9Q62ZA8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775116584; c=relaxed/simple;
	bh=acFIl4ni407JlLFAGdkmDAddl+nIfvX+ii2Nl8SzAao=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nRDo9mML1wHPp1fc8lNzVv8Tc0keNtPZkd33k3UeAtHFLNHV0ZBSQ5djjSwNbdnRH75b+7LaZ0R5XgUT/axhVBix20IKTK25A/5O5sBR7HM6Gn3yjcPwekW2/xw6CEMmHDu1FRhIMXr8To3PWZq/HWtxzFLiyBxRgOeQ1sWuXVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jS01waBu; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jS01waBu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=e8
	gb4xD/Gnf2SL5F/fg4KivZBoQ1XC2kHvWHucwznag=; b=jS01waBu2qYU7dhEJ+
	Di9QtLizOEj1Baa2FuHXNHjMjUAeGFUo2odvcO1lBKaS2B/LzCUqUog2MyrDSbXQ
	4XEH1JMqvnkcS6sADyH6Q/1N/Hx1Yhngi+PTrKZwnQ0E0ulOioYfxinWwq6vMkwz
	sbN6JtJS0sIC2Y3zLY3mOY0r4=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3fwseIc5pOMOXCg--.33327S2;
	Thu, 02 Apr 2026 15:56:15 +0800 (CST)
From: zhangchen200426@163.com
To: linux-bluetooth@vger.kernel.org
Cc: Zhang Chen <zhangchen01@kylinos.cn>
Subject: [PATCH] [BlueZ,v1,1/1] avdtp: ignore Discover cmd when host sends before
Date: Thu,  2 Apr 2026 15:56:10 +0800
Message-Id: <20260402075610.1724091-1-zhangchen200426@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3fwseIc5pOMOXCg--.33327S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuFWktw4xJrWkCw4DGF1kGrg_yoW7tr4UpF
	yjqFs7WFyxXws3AFWxZrZ7uF4UXFZYqrZ5Xr13Z34Y9rs3uw18Jr9Yya4UK343Kr4rZw4j
	va1UtF9Yqr95Cr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Um1v-UUUUU=
X-CM-SenderInfo: x2kd0whfkh0jaqqujli6rwjhhfrp/xtbC5x9d+WnOIR9JJQAA3p

From: Zhang Chen <zhangchen01@kylinos.cn>

Theoretically, the party that initiates the connection should send the DISCOVER
command. However, some devices, even though they are the connected party, still
send the DISCOVER command. In such cases, there is a probability of connection
failure.

Fails:

< ACL Data TX: Handle 10 flags 0x00 dlen 6
      Channel: 71 len 2 [PSM 25 mode Basic (0x00)] {chan 1}
      AVDTP: Discover (0x01) Command (0x00) type 0x00 label 4 nosp 0
> ACL Data RX: Handle 10 flags 0x02 dlen 8
      Channel: 64 len 4 [PSM 25 mode Basic (0x00)] {chan 1}
      AVDTP: Discover (0x01) Response Accept (0x02) type 0x00 label 4 nosp 0
        ACP SEID: 1
          Media Type: Audio (0x00)
          SEP Type: SRC (0x00)
          In use: No
< ACL Data TX: Handle 10 flags 0x00 dlen 18
      Channel: 71 len 14 [PSM 25 mode Basic (0x00)] {chan 1}
      AVDTP: Set Configuration (0x03) Command (0x00) type 0x00 label 5 nosp 0
        ACP SEID: 1
        INT SEID: 37
        Service Category: Media Transport (0x01)
        Service Category: Media Codec (0x07)
          Media Type: Audio (0x00)
          Media Codec: SBC (0x00)
            Frequency: 44100 (0x20)
            Channel Mode: Joint Stereo (0x01)
            Block Length: 16 (0x10)
            Subbands: 8 (0x04)
            Allocation Method: Loudness (0x01)
            Minimum Bitpool: 2
            Maximum Bitpool: 53
> ACL Data RX: Handle 10 flags 0x02 dlen 6
      Channel: 64 len 2 [PSM 25 mode Basic (0x00)] {chan 1}
      AVDTP: Set Configuration (0x03) Response Accept (0x02) type 0x00 label 5 >
> ACL Data RX: Handle 10 flags 0x02 dlen 6
      Channel: 64 len 2 [PSM 25 mode Basic (0x00)] {chan 1}
      AVDTP: Discover (0x01) Command (0x00) type 0x00 label 0 nosp 0
< ACL Data TX: Handle 10 flags 0x00 dlen 10
      Channel: 71 len 6 [PSM 25 mode Basic (0x00)] {chan 1}
      AVDTP: Discover (0x01) Response Accept (0x02) type 0x00 label 0 nosp 0
        ACP SEID: 25
          Media Type: Audio (0x00)
          SEP Type: SNK (0x01)
          In use: No
        ACP SEID: 38
          Media Type: Audio (0x00)
          SEP Type: SRC (0x00)
          In use: No
< ACL Data TX: Handle 10 flags 0x00 dlen 7
      Channel: 71 len 3 [PSM 25 mode Basic (0x00)] {chan 1}
      AVDTP: Open (0x06) Command (0x00) type 0x00 label 6 nosp 0
        ACP SEID: 1
> ACL Data RX: Handle 10 flags 0x02 dlen 6
      Channel: 64 len 2 [PSM 25 mode Basic (0x00)] {chan 1}
      AVDTP: Open (0x06) Response Accept (0x02) type 0x00 label 6 nosp 0
< ACL Data TX: Handle 10 flags 0x00 dlen 12
      L2CAP: Connection Request (0x02) ident 5 len 4
        PSM: 25 (0x0019)
        Source CID: 65
> ACL Data RX: Handle 10 flags 0x02 dlen 12
      L2CAP: Disconnection Request (0x06) ident 5 len 4
        Destination CID: 64
        Source CID: 71
< ACL Data TX: Handle 10 flags 0x00 dlen 12
      L2CAP: Disconnection Response (0x07) ident 5 len 4
        Destination CID: 64
        Source CID: 71
> ACL Data RX: Handle 10 flags 0x02 dlen 16
      L2CAP: Connection Response (0x03) ident 5 len 8
        Destination CID: 127
        Source CID: 65
        Result: Connection refused - PSM not supported (0x0002)
        Status: No further information available (0x0000)

Works:

< ACL Data TX: Handle 12 flags 0x00 dlen 6
      Channel: 77 len 2 [PSM 25 mode Basic (0x00)] {chan 0}
      AVDTP: Discover (0x01) Command (0x00) type 0x00 label 11 nosp 0
> ACL Data RX: Handle 12 flags 0x02 dlen 8
      Channel: 64 len 4 [PSM 25 mode Basic (0x00)] {chan 0}
      AVDTP: Discover (0x01) Response Accept (0x02) type 0x00 label 11 nosp 0
        ACP SEID: 1
          Media Type: Audio (0x00)
          SEP Type: SRC (0x00)
          In use: No
< ACL Data TX: Handle 12 flags 0x00 dlen 18
      Channel: 77 len 14 [PSM 25 mode Basic (0x00)] {chan 0}
      AVDTP: Set Configuration (0x03) Command (0x00) type 0x00 label 12 nosp 0
        ACP SEID: 1
        INT SEID: 13
        Service Category: Media Transport (0x01)
        Service Category: Media Codec (0x07)
          Media Type: Audio (0x00)
          Media Codec: SBC (0x00)
            Frequency: 44100 (0x20)
            Channel Mode: Joint Stereo (0x01)
            Block Length: 16 (0x10)
            Subbands: 8 (0x04)
            Allocation Method: Loudness (0x01)
            Minimum Bitpool: 2
            Maximum Bitpool: 53
> ACL Data RX: Handle 12 flags 0x02 dlen 6
      Channel: 64 len 2 [PSM 25 mode Basic (0x00)] {chan 0}
      AVDTP: Set Configuration (0x03) Response Accept (0x02) type 0x00 label 12>
> ACL Data RX: Handle 12 flags 0x02 dlen 6
      Channel: 64 len 2 [PSM 25 mode Basic (0x00)] {chan 0}
      AVDTP: Discover (0x01) Command (0x00) type 0x00 label 0 nosp 0
< ACL Data TX: Handle 12 flags 0x00 dlen 7
      Channel: 77 len 3 [PSM 25 mode Basic (0x00)] {chan 0}
      AVDTP: Open (0x06) Command (0x00) type 0x00 label 13 nosp 0
        ACP SEID: 1
> HCI Event: Number of Completed... (0x13) plen 5
        Num handles: 1
        Handle: 12
        Count: 1
> ACL Data RX: Handle 12 flags 0x02 dlen 6
      Channel: 64 len 2 [PSM 25 mode Basic (0x00)] {chan 0}
      AVDTP: Open (0x06) Response Accept (0x02) type 0x00 label 13 nosp 0

Signed-off-by: Zhang Chen <zhangchen01@kylinos.cn>
---
 profiles/audio/avdtp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index d475a545e..243c828bf 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -413,6 +413,8 @@ struct avdtp {
 
 	/* Attempt stream setup instead of disconnecting */
 	gboolean stream_setup;
+
+	gboolean discover_start;
 };
 
 static GSList *state_callbacks = NULL;
@@ -1418,6 +1420,11 @@ static gboolean avdtp_discover_cmd(struct avdtp *session, uint8_t transaction,
 	struct seid_info *seps, *p;
 	gboolean ret;
 
+	if (session->discover_start) {
+		DBG("DISCOVER_CMD has been sent before.");
+		return TRUE;
+	}
+
 	sep_count = queue_length(session->lseps);
 
 	if (sep_count == 0) {
@@ -2496,6 +2503,8 @@ struct avdtp *avdtp_new(GIOChannel *chan, struct btd_device *device,
 	 * with respect to the disconnect timer */
 	session->stream_setup = TRUE;
 
+	session->discover_start = FALSE;
+
 	session->dc_timeout = DISCONNECT_TIMEOUT;
 
 	avdtp_connect_cb(chan, NULL, session);
@@ -3484,6 +3493,7 @@ int avdtp_discover(struct avdtp *session, avdtp_discover_cb_t cb,
 	if (err == 0) {
 		session->discover->cb = cb;
 		session->discover->user_data = user_data;
+		session->discover_start = TRUE;
 	} else if (session->discover) {
 		g_free(session->discover);
 		session->discover = NULL;
-- 
2.25.1

