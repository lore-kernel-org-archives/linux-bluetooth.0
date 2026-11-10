Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794297797;
	b=gT0yuCj7/g4Cr+kNdx9mWev1W5rNXHiU08oTxVsYi98jImK50Z2Sax9fynNb27x+fke0
	 31p2F5NWPNvwC+pE3LYfJCjvVLwbhx6skQHe6yqFfPhUHW5UHDw2NUeEFHTBytx5n7uB6
	 73BbYlZckbYp4tNYzmal14lQqnQCuT+YybzUjDKkq0z04DEg+cEjEcfSYm2uiKDRZlZj2
	 k5vF7/6/FYL9vouDJRtYezD7UCCs1wsbNS5yjkjKSRtkMR+Zpv6adtXZYS03lB7S4TE/y
	 DJAwvbpkDoU853DNcGtQql29M5kKNKd0ByQXTp36ZUgufxP1GR8rM1LevJLQf5cvw8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794297797;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=EGzV9ycK1Cs4AM4ETqS+p2nRyGMMgDN2rtBtc1rjFAo=;
	b=j2u8oIWnGBvPFc8hqW1RwG+yRxp9y0xpR/24fL2RNxp/3szZM0VEQQPc5otMONTE4/Os
	 zM4xTY5xVKuqP8D4Y34Hw7bAhW1Un56bY9a96BhUEiINhNv6DjYMK25wJd4qUO5BYZPeE
	 6bbixPq29PTYR+RxE/bblkdbtYTqKbP5inWbOSzCeO+S5kUOh09Rz/RxuQevvnN8xGOsP
	 VVQz1mBR6jyk+Ivg43lm3Ofnv186unaiGn4oeyK4AjsHgpoUohhLhLvfo0ay6sCuDZv9n
	 L6DLtG/45ae49E610VfxKaN4Thffqjui8K3vNoTP43OWXL68nyxoE0S3T/oMn4UlHpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simpleble.org;
	spf=pass smtp.mailfrom=californiaopensource.com;
	dkim=pass header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=0ZI7LprJ;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED483606A31C
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 08:03:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED483606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=0ZI7LprJ
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-14394530ec6so2289030c88.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 00:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1794297796; x=1794902596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EGzV9ycK1Cs4AM4ETqS+p2nRyGMMgDN2rtBtc1rjFAo=;
        b=0ZI7LprJQBUzSlRWVRAkF98Wukw11xHNnv49v45loeFtWeX07kEDxw8Wb72a0v7Sr+
         MyPd4BeOwvIY1DXkjVhK3R8qBgRZi+x3PhY7auXWq6ngure9POA8SHhA4aNncT9XAa6q
         XGmqx2vwSq8ECHyID24SHSliXMRNWFxER37oKHI21+z1NKNovua38IHsq1Ek8eKOtno7
         5GK+8BpMhhzfigxeq/0DvEJ9uQC8qbGkHQHlOmiWNpfqLxHdMr4+Ccd5Hj+HTeOsyhnH
         phEFYp0SQFOsXxxbHOYAhb6icm5V4LReFixQSDKSw0qb3aWptkBevvKyPINkGRbIyvUL
         tqsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794297796; x=1794902596;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EGzV9ycK1Cs4AM4ETqS+p2nRyGMMgDN2rtBtc1rjFAo=;
        b=ze1jOM2qL5TDMy8oz2g3s2n+PShQQR/upMO4JsNg6lW50Tgr61PPuQ826iE0BckcJL
         YklRAO8LVdw8hcM5rZk9nD886fROp60kh2DnR50geHXKPpWYC+QvqRqOr/8toeSDHFlP
         K2hymmEungiVBcUY81eDl3b4VIZmbjEGlPvlkXU33k2/FJdIaUYXqpv3r+6zA5Z+WY53
         pf9ffq5YKoPrzmhlbDHNqXNTdag+iXzN5SiDBfzwxwfPCrZKDTZD9f2raWm8e0qc1FVv
         A35lcZzaz0NFmSC+Z/W/red6l8CDQD/mZX08WeKc/wxyNivu8JWP7efhsRgN1fypW3Bd
         1/Kw==
X-Gm-Message-State: APuU4Z8sy7CO2QbROAELuZs+N0YQGVDcGq1lrvZHD7SgrDIbfINB3epO
	ghPDm0n+wtdab6wVmcRJQ1vIaW8DZt4jYIH7dtY8fWE8buhUAoPaka8mrAHwBL+tSw9qPbS7blc
	SIW0rZdQ=
X-Gm-Gg: AYBFou33T358WXwGOdtIqlWxcEd8mn0FdIamtL/2FHLSzGQHK/4EGx3J8qNAI+oqtfC
	/uE2r5yt9Wa7S+7PySrnKBQ04Dd8NYVseNTStiDQzkO/mIAnHngC1KMMqhmSeeoX5eV9AZ7VsWn
	/Bv+ih6Be67hzIfraz+FtacsC3UcMcnUTZNq2fVQqEMEtaJpV+c4jpeZ0dkKUnsKIUPYtr2vlTv
	DX+XS7I5sb0obW+gkTWFxpBxHiRi1FP6be5MVKBBS/T/Uiww05+26JxwfMzqvO9iqxuN3zwV2Cv
	5O3UAmnYPOWos0OBAaK+rTQCjgctSyugzcLjtiT89g2LxiPwRp+qfE2b8krZ94PkF6yqOgeF5tV
	XAMiYvjkoejG9auM6+4wTplz0zm0eGe3AZ+62RE0elQ3O+sh5tNJRNBT6oGvwLPLx0wkLiocEQx
	VPGsrEMUkt3lDeZOR391zZBwuqwLC689Tn5lH8YoZwIjmrct3EMnDr+NrQE2xdMbwAsJdGBJ6oZ
	43Z4PNT1YFlqLKIjH0eqpDIAHB1nFYMJ8QtxcuPKpLcf+gUv3TjFQrm7UrR2wjW8hy0bxEuAoOj
	NMKsJoMPoJIA5H3SVMkfwY0+cZ37SH/lGm3H7bPfEXcRQZp2tD0scuin9lomIt/phk+fh86lH8y
	AB6MxWX+cmx87X4GuOhZZev4HzXbMtwb61YWKGmUCvu1dGSpUOa/ySlvSiHbVq1Vj9DYi1Fg=
X-Received: by 2002:a05:7022:6985:b0:182:6c6c:d876 with SMTP id a92af1059eb24-1b3b6037d0amr3381679c88.8.1794297795711;
        Tue, 10 Nov 2026 00:03:15 -0800 (PST)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b20c55sm4603897c88.8.2026.11.10.00.03.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Nov 2026 00:03:15 -0800 (PST)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH BlueZ] bearer: Fix Connect refused as in progress after a failed attempt
Date: Tue, 10 Nov 2026 00:03:11 -0800
Message-ID: <20261110080311.71913-1-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
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

Connect keeps the method call in bearer->connect before starting the
connection, and releases it when the connection completes or fails.
When the connection cannot even be started, as when the adapter is
powered off, the call is answered with an error right away but stays
in bearer->connect. Every later Connect on that bearer is then refused
with org.bluez.Error.InProgress, until the device connects some other
way.

Keep the call only once the connection has been started, as
Device1.Connect does.

Fixes: 4e21ebcaa5d0 ("bearer: Implement Connect/Disconnect methods")
Assisted-by: Claude:claude-opus-5.5
---
I reproduced this with a functional test on master and bluetooth-next
3f425f95ba39: host0 pairs with host1, disconnects, powers its adapter
off and calls Connect, which fails, then powers it on and calls Connect
again:

  Second Connect   master                       with the patch
  Device1 (LE)     connected                    connected
  Bearer.LE1       org.bluez.Error.InProgress   connected
  Bearer.BREDR1    org.bluez.Error.InProgress   connected

The test_bearer.py tests and the rest of the functional tests pass as
before. I can send the test as a patch for test_bearer.py if you want
it.

 src/bearer.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/src/bearer.c b/src/bearer.c
index e11a844d8..ebcdc2b4c 100644
--- a/src/bearer.c
+++ b/src/bearer.c
@@ -124,6 +124,7 @@ static DBusMessage *bearer_connect(DBusConnection *conn, DBusMessage *msg,
 {
 	struct btd_bearer *bearer = user_data;
 	struct btd_device *device = bearer->device;
+	DBusMessage *reply;
 	int err;
 
 	if (btd_device_bdaddr_type_connected(device, bearer->type)) {
@@ -145,13 +146,12 @@ static DBusMessage *bearer_connect(DBusConnection *conn, DBusMessage *msg,
 		return NULL;
 	}
 
-	if (msg)
-		bearer->connect = dbus_message_ref(msg);
-
-	if (bearer->type == BDADDR_BREDR)
-		return device_connect_profiles(device, BDADDR_BREDR,
-								msg, NULL);
-	else {
+	if (bearer->type == BDADDR_BREDR) {
+		reply = device_connect_profiles(device, BDADDR_BREDR, msg,
+									NULL);
+		if (reply)
+			return reply;
+	} else {
 		btd_device_set_temporary(device, false);
 		device_resume_auto_connect(device);
 		err = device_connect_le(device);
@@ -159,6 +159,9 @@ static DBusMessage *bearer_connect(DBusConnection *conn, DBusMessage *msg,
 			return btd_error_failed(msg, strerror(-err));
 	}
 
+	if (msg)
+		bearer->connect = dbus_message_ref(msg);
+
 	return NULL;
 }
 

base-commit: 77afa9ee44ed865ada65e1047f7fe4b0a7be375e
-- 
2.54.0 (Apple Git-157)

