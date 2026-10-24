Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792841101;
	b=KRtWZRHcn5x31EPb15aTXBx8sTa7pnYtOp+V3u42vYvLK2WMAual5tVMGtwRQ7oke4IR
	 I/QIeBEPe8OuqGPI1g3t7Px/fhn80l6oJ/iYWJLGbAL9AiB7JCzpFGXT1EV6ZGCA90bzT
	 lwuqiuyg6qxE21iP4y+ZX0iRtrEFPbxayXhzth5CFqGJSw9JyUQ7NruoSyf1kCoE4U3h9
	 H/RY46euRkdyIyLhBSE2O8AJ8pEe3uFc45xc2PpKhs3/Z8P14LkvLuMa2FtBZUfRlzVjE
	 Mxs6GKBx4BGH/6AqpvxmCGNZg/HRL1eerhIaTLkbw4Et3PKWwYz7RhOEwz5zHNpDr4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792841101;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UyIS5HrPAfwsrXJYXiNzhXcKwNQ0JKe7IvE+jZe2qjY=;
	b=Rac7/fP41f0Kb17BFz+eVVBu7k6ILHkfFORbrcKm+uCeKqbc9irH6eYWkSYVZUFY0TJ+
	 Ha65zi4y6f8Gd2wXFI0ZEUvnZyMtJQGw57Tay30zSU2IZwSdUk9C6x56P9oq7f9F9iHQR
	 WfOJlSmZLGT/QkNaLBApY8vPfT+DAfiZjBzS/VkaFdjMff1GAXRER85vH1xePNcIsqNs4
	 VfjZLm/7pr5hbwSFoXCHN8jia6JiC1TuBAnLFEcrwZhx7aibpRea+uA7/1+Kh5DC2BSm+
	 n91BP3ai3QmATdlDfsKSOaqY1AWtaiZFbGIapcp7d21TiFAaIPG4fW+MKLxfoCv+ZUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fGiiHYKW;
	arc=none smtp.remote-ip=74.125.224.47
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4CF606A31D
	for <linux-bluetooth@vger.kernel.org>; Sat, 24 Oct 2026 11:25:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF4CF606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fGiiHYKW
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-67583c777abso1787716d50.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 24 Oct 2026 04:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792841100; x=1793445900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UyIS5HrPAfwsrXJYXiNzhXcKwNQ0JKe7IvE+jZe2qjY=;
        b=fGiiHYKWxphjU1XlWxDPW+oPdglZEczhN8/zPhNkFl2k8iH3+kVmlEADQDRMea+n7/
         BESAv8DtC2Msgqfhjb0b/rf7wnvyckTNCw4jeMAEqmP2vGblx2B+jSPLvEnUBM/kn/ES
         73hq+83vIC+dzRPk4e31vIPEUZfBL6RmWZvSoe/69fyrp900TXrxFgm+/r3UipaLwSM2
         O8rQY6Kn7naZ006oyntv5J2nnUPNhOfx+isWO0lNlwqv1WFTlKjHmH8nUYXswMXx5UOi
         egiSmXcIJAxs1FGfSoom6S7JPSID0tBIrfB/EcsAvAApYSIn4a/3wp/2nB0W8k/QX/v+
         38vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792841100; x=1793445900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UyIS5HrPAfwsrXJYXiNzhXcKwNQ0JKe7IvE+jZe2qjY=;
        b=zmZhEiuFl1Y005C0CQMCQPtCgWXvB10jXMYRG454mvCYBpZ4BJCvc6vD79BOoBAtMT
         8KKxd089dzkBgcmS+etmJwXfGkd/WsKxi9OxDrfpOZUssACWSflbSGeIxSyp/bJLPW7X
         KXguOKAk5Wo8yB5M3L6veQfTK8L1EGNOtpEvCewwMqiFxniNHkvWaL9Af8Oa2nfHaSe3
         X91I2S/QubcXhNHMLjpU5HG17qI5ZZB0oT97/L9iZ+zhgRc82wLlbHPUDfDY9hy28y3s
         6veC2M+D9TKS3F+WdUlJSbQi7eM/jhTsJio6SDBUg+ro2sL3LhyKm8lKf0goYe8TIHpj
         iIkA==
X-Gm-Message-State: AFq9FYLEg7vCbEN0q+ZY3UbLrqqqixxTE8A4cHBox6uHZGoNVK/Gorw2
	ZURleev/2b7RHH26eFbbVZd9xdxN1za48GZX9uy1biz16Ft+AR4xRMjHvbga6w389+U=
X-Gm-Gg: AYBFou0D8qTF+rWR2XJALRRgsaJjUTpagseV4b+g+6EO0BNjZ5PsP0AbPxVBbIMCTD/
	quu419vXGQMAyR1FnKJcxEDms+vPkLRAR1CDQkw43IvnRoUr+zodKqZyk8A+HVdZubRwsyppRBZ
	tEFxjoPVRniF8wuRR7vouxrFGLf3QP6lRsOjESPRB2EVwBXgJHPlws3PxxAgbqU0LCplf2RL9w3
	fLC0A50q7OuM/MdEWZxlad4P7ISrpwGRgonH14iSvQs0fubFU0jaPGSsna/ozcQXTogdRiG2qPh
	k/TF0GfKm2UX4sWM1yNXpVds5ChmIvLnh/XkggxYJEctoz/FLO9Bok/8lVd0xxUBo46F/J8jFvF
	8h0VLZWn9Mwdyjk7lNqR0g/LHs6oHxZIQF1Zg97xgM1jMi358HPRPeDDgTTwrp08H4gQbsOC3iZ
	Dvn9dWcviRZDAqnqiXd5N8XxqfIlKh4D3q+kAYeYrA42rrRbHEeN8Igw7Jd7jiqB5+OAU+nE7vG
	iJqyPUeuCZuFCteoSLQnH4wINEa7Kw0hHADkQNT99oluFg=
X-Received: by 2002:a05:690e:169b:b0:67a:48c4:6b0e with SMTP id 956f58d0204a3-67a48c476bbmr911988d50.15.1792841099825;
        Sat, 24 Oct 2026 04:24:59 -0700 (PDT)
Received: from WillzDenali.lan ([2600:1702:7a80:3c5e::dff])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67a4626cbb4sm855725d50.16.2026.10.24.04.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 04:24:59 -0700 (PDT)
From: Brandon Williams <turbine.bmw@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-kernel@vger.kernel.org,
	Brandon Williams <turbine.bmw@gmail.com>
Subject: [PATCH 2/2] Bluetooth: SMP: distribute the identity address when bonding
Date: Sat, 24 Oct 2026 07:24:35 -0400
Message-ID: <20261024112435.247650-3-turbine.bmw@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261024112435.247650-1-turbine.bmw@gmail.com>
References: <20261024112435.247650-1-turbine.bmw@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

build_pairing_cmd() only offers our Identity Information and Identity
Address Information when privacy is enabled. Without privacy the peer
never learns our identity address, and bonds without it.

Some peripherals need it. The Microsoft Surface Slim Pen 2 only
advertises to reconnect, after a button press, if the host it bonded
with distributed its identity, as Windows does. Paired by Linux, the pen
stays silent. Enabling privacy is no workaround: the host then scans and
connects from a resolvable private address, while the pen directs its
advertisements at the host's public address.

Offer the identity key whenever we bond over LE. Without privacy,
hdev->irk is all zeros, which "indicates that a device does not have a
valid resolvable private address" (Core Specification, Vol 3, Part H,
3.6.4), so the peer receives our public or static identity address and
no usable IRK; the previous patch makes Linux ignore such an IRK. The
peer still decides: the Pairing Response masks the distribution down to
what it accepts. Cross-transport key derivation over BR/EDR is
unchanged.

Tested on a Microsoft Surface Pro 11 (X1E80100, WCN7850): the Slim Pen 2
now accepts our identity key, and reconnects on a single click, double
click and press-and-hold after it has dropped the link. The Surface Pro
Flex Keyboard also accepts our identity key over its out-of-band pairing
and still reconnects.

Assisted-by: LLM
Signed-off-by: Brandon Williams <turbine.bmw@gmail.com>
---
 net/bluetooth/smp.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index fc75cf568471..8ce5f92d7ee5 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -636,7 +636,13 @@ static void build_pairing_cmd(struct l2cap_conn *conn,
 	u8 local_dist = 0, remote_dist = 0, oob_flag = SMP_OOB_NOT_PRESENT;
 
 	if (hci_dev_test_flag(hdev, HCI_BONDABLE)) {
-		local_dist = SMP_DIST_ENC_KEY | SMP_DIST_SIGN;
+		/* Always distribute our identity address when bonding, so the
+		 * peer can tell who it is bonded with. Without privacy the IRK
+		 * sent along with it is all zeros, which the specification
+		 * defines as having no resolvable private address. Some
+		 * peripherals only reconnect to hosts that did this.
+		 */
+		local_dist = SMP_DIST_ENC_KEY | SMP_DIST_SIGN | SMP_DIST_ID_KEY;
 		remote_dist = SMP_DIST_ENC_KEY | SMP_DIST_SIGN;
 		authreq |= SMP_AUTH_BONDING;
 	} else {
-- 
2.56.0

