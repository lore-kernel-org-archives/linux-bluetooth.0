Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CB023D7DB
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Oct 2025 19:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759346049; cv=none; b=ORVbQMVVBrAQ2mrmE4CywWr8h9UJsADukf0mzrEsl+B73+6HvQzHCPsHW2Tt4/E5/rT5aeQu4sN2t9Gj8MBsPejiaOOj2IYFhU93TCfU7bA/Xnt1CG3XoXVr4WDDw6YPaXtQE9x/ufXFM/kDsdpaLidz+fclwZVHUA7XYR4UkXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759346049; c=relaxed/simple;
	bh=Vp8+nDxvW86pQu8RGuVwHY6xJ8y4xgUYXaw5TvhL5dk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=X32konWkSDJZLELWaeUnFqhN3NqKDumYNtIMr1cYCXG6cOSg8x6dB8SCU1KGFnCISKEpjU3M5E8Hgu3Tzdw93L2Kkida4161dqAnxa3IYpruH/LWFBZPonO8lhAZvVF7R4n3LAhWge2ecy8lQxLdkpPkGcoZJJL5lnG4zwfCZps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZcnYjc8e; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZcnYjc8e"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5a7b2a6b13bso194530137.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Oct 2025 12:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759346042; x=1759950842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=k4KmjXlprKlKWtD6bAGA48qdfhbb68+3/VncPBUfg2M=;
        b=ZcnYjc8eq4bMBvJu7tjYBJQYXaOng4pw3p7YWiYTdllZ1zousEGO95XXDYF3g5TENm
         ehEOdpTmzQWhQWR5TnY9Rh1ipBNM+nkInK4BcF1pSA+AxY47RUqJDduz36rb1cgbdWKh
         6YuHfDrGk+coRgvlgOzeVN/8dXIoIETeU8KiSuaDuvrrORjAIVrZLE/xfUsaeycILKjP
         tXydOXZ+tYIQjap+rCwT337TSUftMQeZmP5e0gZ8AyLbSWaWLOPZuZmkCRVv01F10rc5
         ZR9mUqlf7D7+tenJ+/45qTN4VEGxQDtp6fXs1GOon9YXYMmAn4+XhqE5e4f4qj+zgaip
         eC7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759346042; x=1759950842;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k4KmjXlprKlKWtD6bAGA48qdfhbb68+3/VncPBUfg2M=;
        b=Yk2utQW6P/PHnwiYGe0FLrK4MirZpum9ZeC2exn7x9fYuxkDUUZeyNM0yzP2TYaLYx
         VwEzv4PoYpT9Km+wE8pnlYmaiC8P15NU3uowOE5c4xnLHvlToDicJlQOVm+a064rTka5
         svq+yWPXQ0Mv2IeSIxvBUNecOdxq9rSOgCuby9sGQHA9bmjVmp0teRh16DkLqxEOSTWQ
         wJJTp90SdnH/Xv+1YzxMHpQu8MkQcHdJKkq7bSQYL0L/oNilReHOZm7e4TlvfkBmiSRT
         c74QnHhzDQHtFN+Bi1CLaExD3cIdeXbzt4dlwgOSPjwZbuEzHj3LlqIj/YirMe7BhO2c
         mp2A==
X-Gm-Message-State: AOJu0YztoNtw/Y2799RiE9I+qksqQKHMmw5HtlSBFTTSjom3rFdw2S3H
	sWaiM6JjFuasQv/0I1IjJiQ4x1zj2+Rg6sUdj47/qKyRYJMXZf7OXmSXkUvixeEE
X-Gm-Gg: ASbGncsjXKPNrOvTrgz/QFNxfHQqrnNcRTxSVzSRH3+UJoDGXD/LgzYmMLb6vYH5aHM
	g4BwFpwEaueBt3DkI5m9YedmUieWk6OACrnu/CxBMKOoat9QkyggrT/nQY2kxWAJl54wFDhIPnK
	zQVawKtPU4jgty24yPcFSzxXQib+54heeISd0ONUfnOwYgIGbiyZl8uoUtp5VKfFPVBN6JVQizF
	L8y6Sqpj4eHQmDkY9dJi0oq1eKjhK0poe0NGqJuHm5UExLXru3b+vpbU69KjAs6s67cFM79Is1X
	AVlOcFDH0EYqwWPoSHnAJ1oLD6U4KD/pgbTaZYLEKd/DtWCa5BqVI2Xwy6D8guk2Z6Zxq3x3NMv
	kHu38QYurEahK4fvOrrn2Y2bgaVyo+tBQhbaHOrIo4t4PtDdmkcKKSV/BRpg9r/08rb6F8How7E
	1sXg9T0OyQQoAMDptWvKd/NdiC
X-Google-Smtp-Source: AGHT+IGfBReiDDe90kOeVc1VJG3DS4y978u8e5ws+xsYRA4R5mGqSN58bo3Gf72qT4glRmQhaY3Z7Q==
X-Received: by 2002:a05:6102:32cf:b0:522:826e:7bfe with SMTP id ada2fe7eead31-5d3fe4e4acdmr2479051137.5.1759346042213;
        Wed, 01 Oct 2025 12:14:02 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5d40c4eb7bcsm110004137.3.2025.10.01.12.14.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 12:14:01 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/2] shared/bass: Fix permissions not requiring encryption
Date: Wed,  1 Oct 2025 15:13:51 -0400
Message-ID: <20251001191352.77542-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Both Broadcast Audio Scan Control Point and Broadcast Receive State do
require encryption:

https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/24670-BASS-html5/out/en/index-en.html#UUID-dd95da9a-6ac0-3f45-7e34-13fa9e04d41c
---
 src/shared/bass.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/shared/bass.c b/src/shared/bass.c
index 4b4fe8adf762..19cc9531d617 100644
--- a/src/shared/bass.c
+++ b/src/shared/bass.c
@@ -1223,7 +1223,7 @@ static void bcast_recv_new(struct bt_bass_db *bdb, int i)
 	bt_uuid16_create(&uuid, BCAST_RECV_STATE_UUID);
 	bcast_recv_state->attr =
 		gatt_db_service_add_characteristic(bdb->service, &uuid,
-				BT_ATT_PERM_READ,
+				BT_ATT_PERM_READ | BT_ATT_PERM_READ_ENCRYPT,
 				BT_GATT_CHRC_PROP_READ |
 				BT_GATT_CHRC_PROP_NOTIFY,
 				bass_bcast_recv_state_read, NULL,
@@ -1252,7 +1252,7 @@ static void bass_new(struct bt_bass_db *bdb)
 	bdb->bcast_audio_scan_cp =
 		gatt_db_service_add_characteristic(bdb->service,
 				&uuid,
-				BT_ATT_PERM_WRITE,
+				BT_ATT_PERM_WRITE | BT_ATT_PERM_WRITE_ENCRYPT,
 				BT_GATT_CHRC_PROP_WRITE |
 				BT_GATT_CHRC_PROP_WRITE_WITHOUT_RESP,
 				NULL, bass_bcast_audio_scan_cp_write,
-- 
2.51.0

