Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB28F25A2BB
	for <linux-bluetooth@vger.kernel.org>; Sun, 14 Sep 2025 12:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757851675; cv=pass; b=DsRl3chSxjVCpvBTp83gwFSzipAc7I5bs4HgG/Wh2oagGwk5QKToSeostd3CwZMkPyho7CINZUvZ0hOc07tY+cYFKJrTT2kmq2Oan5CZAhUuyo0jx47gaDxYNjb70bbIePBgjfASKMY22AMS1JbYe0TBz+i5hUfqY3uJpy38vyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757851675; c=relaxed/simple;
	bh=nDsEMF/glmYKF66+zOKDGAWQhA+o9OQlLitPjx5vyr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M7Th26A6LOpJ1tVAAyKF/DS1WzVeIG/OTV+MNHY/sTMgSPdYdz4cJkGhwXH4RYlDYfeKNI9YCHZ1njZ/I3p6mSV35/ODOd4n0HuMpkZ4I4vDvywUw8sp4yh84iYjtv/fGcGN9Bumd1E3BqI/9h6AQKpC+SOjhUEMoI5T5VhHcxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=p0aGUVmO; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="p0aGUVmO"
Received: from monolith.lan (unknown [193.138.7.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4cPn3g6LznzyY9;
	Sun, 14 Sep 2025 15:07:43 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1757851664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gLa25zg9lun4rV3/Suq32R+O9XgxDnVzpnL7xYQyO9M=;
	b=p0aGUVmO3mn4yhd7KkyxHmvJVndc53KpBepPKQKBoCM3/qoTAcCqM7ySDqh2e60Ki1UuwU
	6LeAbOpgtRd8vq8B0166jXLCd7O4RdHKdaqWiavMcm8CROt/+bSNN9jLpaWu+/Fps3BkoO
	ORFAKOhkbdpSYrFkl9LJLCyCq49sJrI=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1757851664; a=rsa-sha256; cv=none;
	b=Fg/XIFYVfjsVpWshMtXOSYjlcPQBsh5u7El2cuJyd47ZIClq2LaNRnHiEyhR9y7kGu+Jmj
	05fQxXxXV5HuPKYiD/nsCkf0ljA8KSkxfAvv4aCZ7IITlCPC3AM33IxqwXDZIphoWJK62C
	2xjEqVWPtWnVBM5uypo4cnW8+UNzMds=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1757851664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gLa25zg9lun4rV3/Suq32R+O9XgxDnVzpnL7xYQyO9M=;
	b=nxaUrJ4g51N8ADesqbeoMJL5eU4t9/oCtVik/xP6Jq0hqvRW9d0TcsHPW0uN61BggFo2XF
	Q3OFt2dxkMG2sOQGSIIT0VOPlmQzBmU6lfUzeNAGpWl6v1xfaGWtTHIdeIfjB4OoPgEEZp
	nmA9Dgnw/5ia9C0gRuu9BZpLCUoECsM=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 2/2] avdtp: wait for L2CAP Disconnect Rsp before CLOSING->IDLE
Date: Sun, 14 Sep 2025 15:07:41 +0300
Message-ID: <87beb3f61310a7b8ab915aba56f4792e7e1031e1.1757851523.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <467c9a64b1ed7e311728f07f4065de92c33622eb.1757851523.git.pav@iki.fi>
References: <467c9a64b1ed7e311728f07f4065de92c33622eb.1757851523.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Delay CLOSING->IDLE until remote acknowledges L2CAP channel closure.

It is not explicitly stated in AVDTP v1.3 Sec. 6.13, but some devices
refuse commands sent immediately after L2CAP Disconnect Req, so wait
until Rsp.

Fails:

> ACL Data RX: Handle 6 flags 0x02 dlen 6
      Channel: 64 len 2 [PSM 25 mode Basic (0x00)] {chan 0}
      AVDTP: Close (0x08) Response Accept (0x02) type 0x00 label 0 nosp 0
< ACL Data TX: Handle 6 flags 0x00 dlen 12
      L2CAP: Disconnection Request (0x06) ident 16 len 4
        Destination CID: 65
        Source CID: 65
< ACL Data TX: Handle 6 flags 0x00 dlen 22
      Channel: 64 len 18 [PSM 25 mode Basic (0x00)] {chan 0}
      AVDTP: Set Configuration (0x03) Command (0x00) type 0x00 label 1 nosp 0
        ACP SEID: 7
        INT SEID: 1
        Service Category: Media Transport (0x01)
        Service Category: Media Codec (0x07)
          Media Type: Audio (0x00)
          Media Codec: MPEG-2,4 AAC (0x02)
            Object Type: MPEG-4 AAC LC (0x40)
            Frequency: 44100 (0x100)
            Channels: 2 (0x04)
            Bitrate: 220000bps
            VBR: No
        Service Category: Delay Reporting (0x08)
> ACL Data RX: Handle 6 flags 0x02 dlen 12
      L2CAP: Disconnection Response (0x07) ident 16 len 4
        Destination CID: 65
        Source CID: 65
> ACL Data RX: Handle 6 flags 0x02 dlen 8
      Channel: 64 len 4 [PSM 25 mode Basic (0x00)] {chan 0}
      AVDTP: Set Configuration (0x03) Response Reject (0x03) type 0x00 label 1 nosp 0
        Service Category: Reserved (0x29)
        Error code: UNSUPPORTED_CONFIGURATION (0x29)

Works:

> ACL Data RX: Handle 4 flags 0x02 dlen 6
      Channel: 64 len 2 [PSM 25 mode Basic (0x00)] {chan 0}
      AVDTP: Close (0x08) Response Accept (0x02) type 0x00 label 12 nosp 0
< ACL Data TX: Handle 4 flags 0x00 dlen 12
      L2CAP: Disconnection Request (0x06) ident 16 len 4
        Destination CID: 65
        Source CID: 65
> ACL Data RX: Handle 4 flags 0x02 dlen 12
      L2CAP: Disconnection Response (0x07) ident 16 len 4
        Destination CID: 65
        Source CID: 65
< ACL Data TX: Handle 4 flags 0x00 dlen 22
      Channel: 64 len 18 [PSM 25 mode Basic (0x00)] {chan 0}
      AVDTP: Set Configuration (0x03) Command (0x00) type 0x00 label 13 nosp 0
        ACP SEID: 9
        INT SEID: 2
        Service Category: Media Transport (0x01)
        Service Category: Media Codec (0x07)
          Media Type: Audio (0x00)
          Media Codec: MPEG-2,4 AAC (0x02)
            Object Type: MPEG-4 AAC LC (0x40)
            Frequency: 44100 (0x100)
            Channels: 2 (0x04)
            Bitrate: 220000bps
            VBR: No
        Service Category: Delay Reporting (0x08)
> ACL Data RX: Handle 4 flags 0x02 dlen 6
      Channel: 64 len 2 [PSM 25 mode Basic (0x00)] {chan 0}
      AVDTP: Set Configuration (0x03) Response Accept (0x02) type 0x00 label 13 nosp 0

Fixes: https://github.com/bluez/bluez/issues/1471
Fixes: aa118e965b ("a2dp: Don't wait to reconfigure")
---
 profiles/audio/avdtp.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 30648251f..3613dff2d 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -79,6 +79,7 @@
 #define ABORT_TIMEOUT 2
 #define DISCONNECT_TIMEOUT 1
 #define START_TIMEOUT 1
+#define TRANSPORT_L2CAP_CLOSE_TIMEOUT 2
 
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 
@@ -752,6 +753,8 @@ static void transport_cb(int cond, void *data)
 	struct avdtp_stream *stream = data;
 	struct avdtp_local_sep *sep = stream->lsep;
 
+	DBG("");
+
 	if (stream->close_int && sep->cfm && sep->cfm->close)
 		sep->cfm->close(stream->session, sep, stream, NULL,
 				sep->user_data);
@@ -765,6 +768,26 @@ static void transport_cb(int cond, void *data)
 		avdtp_stream_set_state(stream, AVDTP_STATE_IDLE);
 }
 
+static void close_stream_linger_finish(void *data)
+{
+	DBG("");
+
+	transport_cb(G_IO_HUP, data);
+}
+
+static void close_stream_linger(struct avdtp_stream *stream)
+{
+	/* Close and wait for L2CAP Disconnection Rsp via socket linger */
+	if (stream->io_id)
+		g_source_remove(stream->io_id);
+
+	stream->io_id = io_glib_shutdown_linger(stream->io, SHUT_RDWR,
+					TRANSPORT_L2CAP_CLOSE_TIMEOUT,
+					close_stream_linger_finish, stream);
+	if (!stream->io_id)
+		transport_cb(G_IO_HUP, stream);
+}
+
 static int get_send_buffer_size(int sk)
 {
 	int size;
@@ -2922,7 +2945,13 @@ static gboolean avdtp_close_resp(struct avdtp *session,
 {
 	avdtp_stream_set_state(stream, AVDTP_STATE_CLOSING);
 
-	close_stream(stream);
+	/* Delay CLOSING->IDLE until remote acknowledges L2CAP channel closure.
+	 *
+	 * It is not explicitly stated in AVDTP v1.3 Sec. 6.13, but some devices
+	 * refuse commands sent immediately after L2CAP Disconnect Req, so wait
+	 * until Rsp.
+	 */
+	close_stream_linger(stream);
 
 	return TRUE;
 }
-- 
2.51.0

