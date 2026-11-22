Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795343604;
	b=0ZmwQXhUA1vB9NClqoKePCgIQ8LhE2C1dozkAJbxBTYlE7faPXBOMc85G6CVvCOVPhpz
	 NOHPt7cO/KKUwkzZZrdZnFtXoPKPiKs+zwz4VQ4BJ4l3CnfwCy7RB0nCMyWFEl4Dr9QR8
	 0k7lDe3/Pabn3ktipG82wLSm8xMj7z+PedeidnxjaVWF3Bk+s3sxX4WXZ5ErTex6mlhX2
	 zfS4YhzmXJFHTFtzFB54A8lgxpBT8zwyOTQHr0WsT9Ctx6o6GP2X1mEfjmBfIV+ZIOc6L
	 leWCrIycs/RIxCyG0mBw0SJ+m2nWR0afba33zK1EvyhJ5APt1GRUMpRaU0mZ9mgfviQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795343604;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ANa8A2QqEJ0mqL11VcPldTrhjm5NdI6ZOz+YqyRlPic=;
	b=TSjs0bOxo0AjL8PRcy3dkmT83ur8DNoZ8vDL5KpO1SDNuqzD2nbN9XCroMQgff9FSFaT
	 hjGfeAVxQzeUOHj88koWUF8y90w72/OEExpuTy9NDvZY9knSdQNdOM3D+4coEnJgw420w
	 aDhKy4L4nLdt46jV3UbYCQ6EKDw4OeOGFqYqrgcLmFjGVzrkrkre9VhSVYFcVwR4Zn81t
	 Oc5drqYSmvZV/4lnGiN8fV4VR4MrjkSTIOkNoRXcvl7Fo9HoYccgrzfvvSGK/yZJompKv
	 TsemlP9ZxdIvVnEE3rXfIblYf7MEu00A2g92g6cWQP+wYAzXDR9sIAgdLW1LGvl7BgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=Yufr2xPt;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4933606A320
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 10:33:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4933606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=Yufr2xPt
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a214c5c4c0so21029725e9.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 02:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795343602; x=1795948402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ANa8A2QqEJ0mqL11VcPldTrhjm5NdI6ZOz+YqyRlPic=;
        b=Yufr2xPtJnvbV68V0pnQQB6lkwJyn+3cT1PVlotVlG6hHT3aW9x+fv3UrAPSCmxSzs
         sc3V6W2Ot+twm+YO1oT8d4OExCQ/ULdge3rUE6/oENyRiy4i4VdggFfn/hyi5vz19WUt
         l7Bf2/+DoKu80UcqYxAuusxMdu0oLLEk3sQIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795343602; x=1795948402;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ANa8A2QqEJ0mqL11VcPldTrhjm5NdI6ZOz+YqyRlPic=;
        b=AUWu/NioEpNdVqcKNA8L7UZ+fZdK0yp98Yc+9xpHooTs08/y3K7j4xP7EX25oLyQ96
         +uos7hq/ejKmnoV6eB2KYsohV/jWl99mR20/dMWaDw4LtoOwrA+57Qaa4gXgtq+M95St
         gVI62FARJxeN0bX3dHUwb7bWErBlpsa3fBZ1/tw2qx6TJNbqCWArpdlEQ8Y/S4BKcsva
         T7+9H0Jbco/fhrG32KSmu88uYiFDtkFVB6EI+ch/ks0zYHtzHbIXE7hsarZ+91pLX1s9
         f7flp8f5ojMZarYMiglpWf0lZOexw2rUQU0H0WYdWJJTBaHABiWy3Gi5iCNaFqv8SFJt
         rVZQ==
X-Gm-Message-State: APuU4Z9IfP7qg6XER0E/g1oAcwfXCD31Nba8dCk1iobyzrNN+pWl88Mi
	UpBUu9AcwXEcfkDdnJ3sPHF7Qd0VY9wAeCHmpz9oZUM+Fqsl+bNsU5rjk7qQg7T734mMb9uUQF7
	6f+DT
X-Gm-Gg: AZFdTZfUh2g/ga3lGvoKO9C2dRn3QkR9d4tu+OJpej6k7GNTL1cdSZ/LkDkJV6bX/Xl
	PBmikesn/qQ8O9ykMbOnVvmCUsIC71ZgplTLvVirFyY5bWxE+lVOviwtfdcTGg0xovxrd7JhRFe
	SkUSG4sO5rouZRNmeJksmgcHdB1vsQrDaadLbolqDYR9ceAgxDUISYQxYHCAN6pogLWbjtFDJMe
	nVfNtWxACrIy+ir+gYNKyfTWQQGEeOjPhmLQT6Al15cUmtDSEL5M9Afcw5Ci2KZiL9eBa0vu/GH
	7WhOhJ7/CgfARHx+Rp7I36G88Xdr0TBj72rGH8FB2zVpk7SvE9RtxPp4EVCF11/qeIYZj+2K2Wr
	HUvAS1nwoK0y4F7qhnCFPOzM33hzuPyL+F7Ea6Vgir4EI+LO/RrESvu9UUaRnRzJBxIgNewmdNe
	NRzBviJdU26TANcSGeGAZYj2J2Tle+By792Dv74o+Ti9Jzwf2No9rSIMzeGPMW+arb06Twfc1Zh
	v0fjqNV3BFDBweWxWJGci5V7QhG9HFO5QImHQ/SsIhEr/mvmHj8L+gVl5ZLdh9AxbjfoRRBBF6R
	N2r+R0Y40jwmmu5iVRmHiovh2uRWJ8yvvsGUamLkN+q3rJJ9+Q==
X-Received: by 2002:a05:600c:5246:b0:4bb:60ba:49e0 with SMTP id 5b1f17b1804b1-4bb88930707mr191016785e9.26.1795343601748;
        Sun, 22 Nov 2026 02:33:21 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:f8cf:a1d9:90ed:c978])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8849247asm247379925e9.7.2026.11.22.02.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 02:33:21 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ] advertising: Refresh only advertisements that depend on discoverable
Date: Sun, 22 Nov 2026 11:31:24 +0100
Message-ID: <20261122103136.620031-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
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

A change of the discoverable setting sets every advertisement again,
although only a peripheral one without its own Flags depends on it.
Some controllers can disturb a running BIG when the advertising set
of its broadcast source is restarted (an NXP one skips every third BIG
event after it).

Steps to reproduce:
1. Start a broadcast source whose announcement is a registered
   advertisement (LEAdvertisingManager1, Type "broadcast").
2. bluetoothctl discoverable on
3. The advertising set of the broadcast is disabled and enabled again
   (btmon), under the BIG.

Fixes: 91d4b17160b8 ("advertising: Configure discoverable flag based on adapter settings")
Assisted-by: Claude:claude-opus-5-5
---
 src/advertising.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/advertising.c b/src/advertising.c
index b68ff28f5..d07068c6c 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -2180,6 +2180,10 @@ static void manager_refresh(void *data, void *user_data)
 {
 	struct btd_adv_client *client = data;
 
+	/* Only a peripheral without its own Flags depends on discoverable */
+	if (client->type != AD_TYPE_PERIPHERAL || bt_ad_has_flags(client->data))
+		return;
+
 	refresh_advertisement(client, NULL);
 }
 

base-commit: 1adfe662efeff12997df9ddd0960dbd0de9c8ea7
-- 
2.43.0

