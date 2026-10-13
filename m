Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4383853E2FE
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 15:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791905874; cv=none; b=EbHffQErGG1Z6llXDS6HNvSwOk9hixMpmQvAJKGeTj0zHVHDmwXJRnzOQq1tF7/zkx9VZlflsyEl1icCBHuUj656uiMqElDSsQDBxe86DySH3Jr6arqX9ap01Ljy7UHGctgz4YJ33+YrTTrTb6EhfHfpFLx7AwXwgVfejQ7QqEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791905874; c=relaxed/simple;
	bh=NIwYZjZPvy0TmjtsYKDT17ZCQe0+aGTBY4JwDjb52LI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p+P/F8lo39HCOKDr6C9dUqDG0bDcfJIunyn+VAODUMfgtHTlKs748dtHdKRCSmRYrKg5m1nNrW9tflPfRZoRnqBgKLdqYXXioNhAxqcfuLpf4OQVgv0iTZFUJzrY68/d8KIWPIgn01m1Kp/Q3WOOFanmnagbIRqrl8AfYw2XbWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=FY6L8HH4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Mu69H2MH; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="FY6L8HH4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Mu69H2MH"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8034D7A00DF
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 11:37:51 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 13 Oct 2026 11:37:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1791905871; x=1791992271; bh=KAy5EYWQvUXJMaCHiIhV4
	kOQGM3UZJpDDqp6EqM1D94=; b=FY6L8HH4zNbCOn89vyqPeTIGS6ItE3zAtG1fE
	SGUyfH800f1hN/xZxon2HCgpPYdt6WoUKcc21So4oGFFSJoRvZ0XGVEj/7fKXdGH
	l3Ey6sQlbfo+i2tmN/cgjv+5hyEKFNfY8PZcpVg6uQLNjV+KgniJ9AAm3WwqO6hH
	ICJHaEUf4sUXAQo6Vb1qk+AfTMQjAdYBgArI4smWvsLLT/ubniV88Eb8NC3rs7Z9
	/t2KSEdl0DfiWWfNOLDIJ5KWRwcKNWjk7R2lTIG+3jkhtioZAmaIv6KkknG5lNK4
	Fq72NTbwzCL913Cled4U6lRZkm9ba2ht0qhGydDXUMP64AaLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791905871; x=1791992271; bh=KAy5EYWQvUXJMaCHiIhV4kOQGM3UZJpDDqp
	6EqM1D94=; b=Mu69H2MHiA0/8ZDAmRn5uIQtthTIKpI2omyo7tOIRl7l2nOus1a
	2JmRwTqcvuqZzR0sYlPb2n3f488tDKSf4I18LgqE14fFapgeCtRqDbDYiqmhl4RA
	20OR885lxuGbJZULtlP9waUuY21VrPOwCFimgn+jJ7XwafHj4Ai9ODLjNA7KcoF4
	RoixCEBCo/J3HMh9xSFpdJBjCZ997UcFlljF8KGD6yYNH8bNnU8pwYQwkbUDO/S6
	eO9DBzwOTXbdZ2ZzMeR0jkDSalY5zuNtIWL05jf6wZpXBbkOFFcUzF079dO+/lw0
	EjqLyEoEJ8bA3tzUeBofyS67+q+OIZJdlgQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=fourdim.xyz a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791905871; d=fourdim.xyz;
	mf=PG9zc0Bmb3VyZGltLnh5ej4=;
	rt=PGxpbnV4LWJsdWV0b290aEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:fpYfUmVhRsXUwdY/0qdwOPmoLL+39H6af2oecn+B2QfiJRz
	hCPOaD687huJjHardMNcjW9l05Xx8BgP3y/xKXCsyT9yjyH1Yu3i1256Htwe7E4v
	oJ1AmbX6kRm4bS709wYAt+PuZWUsDpic7pTJT+8lzkKOHQf4BJ32TQrFPgDBN1Mi
	T0uAr6QTWKIHPLRjkWxVn5Ir9C1oYseqQKI3KO6VcvbkfRSEKdtHukD2vzKWF3u3
	DyOlDANWOC0/5tQfStXU/adryAWELU103UV8yRrVVrCpZKAxmfV86Sd1k7TpOJ0K
	W5pkcJYk1c/L8OtsnAoyXBM9pK8vsOnnSNdeasA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=9;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:uLqadq0tIoOUCvRxOgBwUwvVrb8a0IvtUQzcI44ZQM0=:NIwYZjZPvy0TmjtsYKDT17ZCQe0+aGTBY4JwDjb52LI=;
X-ME-Sender: <xms:T1DOau3qDvdjtLPnrJwd5Nq0kSViDjylKQmyfMKwawPdzrx2rResWw>
    <xme:T1DOaojsuGI9pZed_IxQyEaueaG3e4v_J86pf9tLPb2pFFGSf_9qbZM5YVncqb_SS
    K49dmR3gvW6902xW7zS5d25ijnwcBZXmteg721Y_S7AROy12hXcp1gXeA>
X-ME-Received: <xmr:T1DOakTuHF_8BfSl-MZ9S32EQZJTgMGF4bjPMLjvhrNVXTa3rANk8wxvYJeS5LeV6j4hffw>
X-ME-Proxy-Cause: dmFkZTEyQLwHYB1fr5KWP6S3+1D3YiBc0vco4vVq8H5IqpkRub7Urp+v0xE7Rd3mBkU00x
    ySp788eyQuMi9tjecK7OW3hJZ950Fx73VxS4HfXAUnOBVOtfEcaFw1vHd09c+VdpQThTuS
    pN64vU5w0RwqGKmCL2J7XUgdqU5j6Q+vI/1EDRYg1Qvn1qgH/9um3v9H7F/oa2qmvi+c0l
    ux+DCKjzJ8hgEiwG/QSCOHErkfqvz1fApCc3TdATIL1VvSX85zh77eb8dhEqKSLOoeQ3yu
    q/p6zwc7XI4Vbqkdtydb3Y+B6wOtfk6WiD65E/R+JGrRZiKqudDbmxkZLgfs1xsn+4hHAY
    Vk2M+h6KjBV+hkGinZh7jkfXz5/6cLlo+Xvlg2G+dSzQWpdZGgGNJtPhHdLLmGMo7JMFAY
    qvwR3KTZj06MnPFqoXguXl/0un9+ZeBBjXFWeQByiwIn7rZsGuTNj9dNkSDZMxnnKVRLmE
    y7t1Cnr5ZYUZtOHt+FMYf82Nh7CDJXUQTTMqUK42aTm434yC06bY4y1g22/18bTr02MALS
    Ycf7mEVwE0xCGwTm2dIfzAs7naXYr4f4SZn+De7e3faaM0s29GCePn5zEJU2RQ9POG8S61
    K7TERorF+OSDweSV0Mc6tSSV/goL20EwQch2dmDGDqg9T/RFTJajUi4s/BAw
X-ME-Proxy: <xmx:T1DOapgO3QRFn_FdMefdLFGE8RSRleA3i5H5zn8A5Afkr_ZCXEqSEg>
    <xmx:T1DOak5CvVtOWP_TsUfYTt5-fGVJewtSF7FdpdHqt6COfUkZz7LzBg>
    <xmx:T1DOamDQoOfn8XJl8sk0Q6QLiZt8QCLOzMW4u9Kl7tYfSc1FXtatHw>
    <xmx:T1DOarYCAuFlZKyFxXzy1ZETgreQLGvHP9EiRGBu2kW-BqzExZ_rKQ>
    <xmx:T1DOas5fLLv4J_x7jIsYD5GmlAxxJ7x49QCZvQMpv0hWUZdA4rsCloR3>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 11:37:50 -0400 (EDT)
From: Siwei Zhang <oss@fourdim.xyz>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Siwei Zhang <oss@fourdim.xyz>
Subject: [PATCH v4 1/6] Bluetooth: L2CAP: Reject mode changes on connected channels
Date: Tue, 13 Oct 2026 11:36:33 -0400
Message-ID: <20261013153720.2635387-1-oss@fourdim.xyz>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A peer can send a configuration response with an RFC
option for another mode to a connected channel, for
example to switch it from Streaming to ERTM mode.
l2cap_parse_conf_rsp() then changes chan->mode, but
l2cap_ertm_init() is not called again, so the ERTM
sequence lists are never allocated. The next
out-of-sequence I-frame makes l2cap_seq_list_clear()
write through the NULL srej_list.list.

Refuse the channel when a response tries to change
the mode of a connected channel.

Fixes: f2fcfcd67025 ("Bluetooth: Add configuration support for ERTM and Streaming mode")
Cc: stable@vger.kernel.org
Closes: https://sashiko.dev/#/patchset/20261007144717.3832330-1-oss%40fourdim.xyz
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
---
v2:
  - assemble the patch series
v1: https://lore.kernel.org/linux-bluetooth/20261008141714.95709-1-oss@fourdim.xyz/

 net/bluetooth/l2cap_core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 49a998804908..c730da87734b 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3876,7 +3876,11 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *chan, void *rsp, int len,
 		}
 	}
 
-	if (chan->mode == L2CAP_MODE_BASIC && chan->mode != rfc.mode)
+	/* A connected channel cannot change its mode, as the new mode would
+	 * not be initialized.
+	 */
+	if (chan->mode != rfc.mode &&
+	    (chan->mode == L2CAP_MODE_BASIC || chan->state == BT_CONNECTED))
 		return -ECONNREFUSED;
 
 	chan->mode = rfc.mode;
-- 
2.55.0

