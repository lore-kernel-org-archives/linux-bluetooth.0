Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84A212FB1B
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Mar 2024 17:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709830883; cv=none; b=ZKqgyVoZ1pTjEunPfNxZBv3CBBcUk6fg4ACHpLnQraDiJ0W4JBnmAkVwXwqKm1G/n23/OwqISNlvp1dZauJNRVYg19P9igS/VhwTBwN5swEm28Y96tHwDSpw5cduuoJsEEqBfNx1wsh8Srz4H/zQW5bRg9kZcWQs/JPswTc3x4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709830883; c=relaxed/simple;
	bh=c+NlduEjfnrY8McVuZO7mzDt9vay/BpwXukPtTKHnHU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=FeTOw2BqVS6XWMVWNf6jbBX2hrrwdbe1JpmOK+iseZdVeNYYiUrq0c4WPcuNxBqjk78l2AS63IHAqgHuDbLNUuRp4XDJcZrg5xprXw+L619SaedyvBJoYZOFx1SsvdPL6gdTynk1JXDK+2x1UvHJ1ka3GQEYAxfcmBtnnvpVnQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i6gqatgN; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6gqatgN"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-7da6e831972so312237241.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Mar 2024 09:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709830880; x=1710435680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=S+iaEkbFs+fuRGrSfzbBCROmd5Q9Wh++RXvfsXdU50E=;
        b=i6gqatgNNQ0q7Ks9YGwximW3AnaGzRqcJeruJPKoY9k+ykhLPyT7NqLZMHdSTV8rhu
         HYiFn7l7/+FU23ZS5qKoJipjBQFHN0G9ITeezd8vbLvE53Eo6S0wVNrTuX0jjnBm4AdA
         ANQW80YDYsO1G46MXyUUx1FrShEzFMRBg+m1Zw5VKxsAt6V4c7LkkCSe5PcnCBEllD5O
         58sre13biWnuWyDyDsGOf0sxIjtbplEJwbN7DMvHrisG9P5RKPmMET98WO8HKDEAx5fH
         tWeFJ4fB7s65Q25oveXKaqdF6jGNKrkuql4AEpTKf+P2XFjgvWeSHeW8GT+vnqbFqMoi
         JGgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709830880; x=1710435680;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S+iaEkbFs+fuRGrSfzbBCROmd5Q9Wh++RXvfsXdU50E=;
        b=MZTXNqmlycJuTKafr15N2uqTEGSXZB+Ii4Jxc+xJOGZPKTpYU4bc5RIz6AKFIdzfw3
         /cgVd3Hn3HxaRVLj4fgp39aUZUetVwyeR4BkST2/CsRMuml387DHdfIVmq28MDUGxQN0
         M5bOgn077WjfMaZu6ABdnzAKgIyRB2R+4yB/9HnT7j9+r/88QBveSIMrT2EGrw/ThBNI
         noHnhF0/SJK44zdJ6nC20QIe9vszxehz5jYhsCI+Fa1b3aOnCrqtvE+5tWcxXRSsYCQJ
         aUyl0ccrmLemLb3knJlXiTj+/SQt2HJK+d5JDKaMtyDXdW660fBr+DcVq20OwQDSLvPx
         W/0A==
X-Gm-Message-State: AOJu0Yzcv9MrL2vQ/HJ39riB6UL4BjYkLWW3tDHQdZTDk00C7tzCyrDR
	IXLGY8CtcSu3uHdoQ+HJ6RNIOFGdJ++DVX6ZasarbxzDjyUF5LfeUnT1mdwr
X-Google-Smtp-Source: AGHT+IFqJ67yK3cfDi2/GB9BhRCaSRhP8/SLJ64z+BwZlF1mUOiAjrvWv+7H1Ilu4YafI62p9YkLmQ==
X-Received: by 2002:a05:6122:3a0f:b0:4ca:615e:1b6b with SMTP id fp15-20020a0561223a0f00b004ca615e1b6bmr8792785vkb.1.1709830879911;
        Thu, 07 Mar 2024 09:01:19 -0800 (PST)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id w193-20020a1ff8ca000000b004c788a8b71asm2054525vkh.13.2024.03.07.09.01.18
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 09:01:19 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] bluetooth: Add BT_ISO_SYNC_TIMEOUT
Date: Thu,  7 Mar 2024 12:01:18 -0500
Message-ID: <20240307170118.4096656-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This defines BT_ISO_SYNC_TIMEOUT(20 sec) which shall be considered the
default sync_timeout and make all instance previously hardcoding a
value to use it.
---
 lib/bluetooth.h      | 2 ++
 profiles/audio/bap.c | 6 +++---
 src/shared/bass.c    | 4 ++--
 tools/iso-tester.c   | 4 ++--
 4 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index ba08c70e61b8..75dc960c83a2 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -150,6 +150,8 @@ struct bt_voice {
 #define BT_ISO_QOS_BIG_UNSET	0xff
 #define BT_ISO_QOS_BIS_UNSET	0xff
 
+#define BT_ISO_SYNC_TIMEOUT	0x07d0 /* 20 secs */
+
 #define BT_ISO_QOS_GROUP_UNSET	0xff
 #define BT_ISO_QOS_STREAM_UNSET	0xff
 
diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 1b8a47c52116..1034202cb8a0 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -138,7 +138,7 @@ static struct bt_iso_qos bap_sink_pa_qos = {
 	.bcast = {
 		.options		= 0x00,
 		.skip			= 0x0000,
-		.sync_timeout	= 0x4000,
+		.sync_timeout		= BT_ISO_SYNC_TIMEOUT,
 		.sync_cte_type	= 0x00,
 		/* TODO: The following parameters are not needed for PA Sync.
 		 * They will be removed when the kernel checks will be removed.
@@ -148,8 +148,8 @@ static struct bt_iso_qos bap_sink_pa_qos = {
 		.encryption		= 0x00,
 		.bcode			= {0x00},
 		.mse			= 0x00,
-		.timeout		= 0x4000,
-		.sync_factor	= 0x07,
+		.timeout		= BT_ISO_SYNC_TIMEOUT,
+		.sync_factor		= 0x07,
 		.packing		= 0x00,
 		.framing		= 0x00,
 		.in = {
diff --git a/src/shared/bass.c b/src/shared/bass.c
index 3f5bf307cfdf..c30537dee744 100644
--- a/src/shared/bass.c
+++ b/src/shared/bass.c
@@ -111,10 +111,10 @@ static struct bt_iso_qos default_qos = {
 		.bcode			= {0x00},
 		.options		= 0x00,
 		.skip			= 0x0000,
-		.sync_timeout		= 0x4000,
+		.sync_timeout		= BT_ISO_SYNC_TIMEOUT,
 		.sync_cte_type		= 0x00,
 		.mse			= 0x00,
-		.timeout		= 0x4000,
+		.timeout		= BT_ISO_SYNC_TIMEOUT,
 	}
 };
 
diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index d1f0be180c33..1864b9e9d9a2 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -264,10 +264,10 @@
 		.bcode = _bcode, \
 		.options = 0x00, \
 		.skip = 0x0000, \
-		.sync_timeout = 0x4000, \
+		.sync_timeout = BT_ISO_SYNC_TIMEOUT, \
 		.sync_cte_type = 0x00, \
 		.mse = 0x00, \
-		.timeout = 0x4000, \
+		.timeout = BT_ISO_SYNC_TIMEOUT, \
 	}, \
 }
 
-- 
2.43.0

