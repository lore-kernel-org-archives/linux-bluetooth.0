Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107821EB19B
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Feb 2026 13:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770904029; cv=none; b=JO90KWAzCnN9y7Tyg7be9kgLq5otNsmGs/3YMAXZXIe8087Cg/FRVOWeFqCD8yDOfN7QKABb0YYUg0/6cYpDEgIqk90YgqbKWS6/S39hYqUzK63i6wvdEmzwXNPp45zcQhzT2ClGPknk4jcHs6+Evr/orkHFlQhZqShCoNFK/iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770904029; c=relaxed/simple;
	bh=dUv4Z4RKWbg1YOudiByIx6u5p/gQcLg3pFtWHqvTLv0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a/ULr42683Tw+gh/D34uV4NIadlvJExo8uljIsZpLPT3BkLSVZr0ntWqwTIzZ3Q1+9caYovlUk8Ax1qVNuUUUu3UNQCH8gUbIw89r2QBiaz9n9voNcF2BmXZXZxGq5whQChPRIoBnMffFK/mmrz/bsGjtM7hq4s1bOAxa3K4Wdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=codecoup.pl; spf=pass smtp.mailfrom=codecoup.pl; dkim=pass (2048-bit key) header.d=codecoup.pl header.i=@codecoup.pl header.b=mGlNQfT6; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=codecoup.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codecoup.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup.pl header.i=@codecoup.pl header.b="mGlNQfT6"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4801eb2c0a5so76003615e9.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Feb 2026 05:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup.pl; s=google; t=1770904026; x=1771508826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u5IJc+vMufOcZ7BrhUT8ALQP9dDE3pvyqu+vStpetco=;
        b=mGlNQfT6ZddHbRCzNGSebbliRtFm9QPlKkmdXmz+AAzZrLPJ4na09KvxawP3NjBetc
         JQciPk5NHei4O6Ce2Md1VgEVa/UabqLUDhhCDTehVbkyulKTQBKQve8h/+zhm//v5vQ6
         CdWrJUsIIpLNk6ibLi01IwxvJy2GNNvVOTRfvVZE9hqQbCLNSUIfjCxmXoKwY/1ep+ld
         jfRsBLFaZsrDRZUZY69HRauTCZ2yOkQjFImSLgxVP1rQh6wiLT4kcPbbdebjhbaP5YXE
         WWgw/du2e46ACdGLYTmOU9Fx94tG0aBCF5ragfz2TORG4kCb9RVYo8D1G1cwjLO1rsok
         BHGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770904026; x=1771508826;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u5IJc+vMufOcZ7BrhUT8ALQP9dDE3pvyqu+vStpetco=;
        b=mMiDoBgbQ4Nfop8nmZ2rWvfs/ixdRzAD6sIBdnEjQjt7+o57Fv/jhSoEfbjrtSIC4a
         1oOhZKXlqkGPBbBlWm5KHNFp1KspE4qR6v2kN1yojX8zbyTDJZxH/0CcsBeS/dKiaUqZ
         TCPnd1CKHLOcdgMi12APw7c+YFwuwdDDrr3FznVNTXEzKtexgWrokbcJDSn+uAy86jRv
         Ysr9QKJzoDp1Pjq62RoviKbjH+8p9G9YseyM4PGc6ezlzjdPkxeK5Hw1wSHmV0bM58FJ
         H6iBoRdF3rD83SEUKR6JOinE50chCmp+lNvTQtMuLqeYAcNhkWb1gHnPVwTaiZbKIK7l
         VNEA==
X-Gm-Message-State: AOJu0YzfMEfekfJIWXlOeMIPDaFgU72s+2gAmaG2cpz99JIdzgrySL1o
	WUlAuQtQBTCD4v5NditRlKGbyRjRo1aFY0+8bzcuu/BmxqhxSrBw6dRAydzXgN6sZ0isanQEwBG
	fVW0fBhw=
X-Gm-Gg: AZuq6aIsy/EPbLSCUZYIYw8Qt7Docaz0UnktNrXTJ9s8OGxhO4pmv/JFedhSPE5k9hQ
	k7bKq3MG4USFPyos34RHFsgDb/pNlGdFexb5Q73+AH3r7WmKvVa5c5wqd0dYrqpcQehW4g7uRX3
	4PgjlKrALVParC5UgQkuV9HJdYOdKCKGhCK4wc+j4rz+AZaEXEeEu01BIL9slMwLmUpVBKH9gBm
	zosoNJHdXmCoJPPWT4LT++p+YIWTcYV9Z8mB39JSNpQyhMLgPz/UQMYTBs3rPb4zHjy6cg9kYj7
	EJSGYp1AkjPQaLS8RmS3rh4ELY699ol519dSx/94sk+oMBnL6AqygOB9rlesclHKzdiwUPYsWAM
	KktXGalfcOkjVIf/2YdpAzYxR+OEXkEIQNXJm7+KeT+Piq5/kULrFzr5y9bnst8IobSgCZKIF0n
	LcX8d66EvrGXudDXnM02AlOkeMJI6r
X-Received: by 2002:a05:600c:3e83:b0:480:6999:27ec with SMTP id 5b1f17b1804b1-483656c0a9cmr39466285e9.13.1770904026135;
        Thu, 12 Feb 2026 05:47:06 -0800 (PST)
Received: from localhost ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783e3cacesm12598158f8f.31.2026.02.12.05.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 05:47:05 -0800 (PST)
From: Mariusz Skamra <mariusz.skamra@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@codecoup.pl>,
	stable@vger.kernel.org,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH v2] Bluetooth: Fix CIS host feature condition
Date: Thu, 12 Feb 2026 14:46:46 +0100
Message-ID: <20260212134646.430396-1-mariusz.skamra@codecoup.pl>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fixes the condition for sending the LE Set Host Feature command.
The command is sent to indicate host support for Connected Isochronous
Streams in this case. It has been observed that the system could not
initialize BIS-only capable controllers because the controllers do not
support the command.

As per Core v6.2 | Vol 4, Part E, Table 3.1 the command shall be
supported if CIS Central or CIS Peripheral is supported; otherwise,
the command is optional.

Fixes: 709788b154ca ("Bluetooth: hci_core: Fix using {cis,bis}_capable for current settings")
Cc: stable@vger.kernel.org
Signed-off-by: Mariusz Skamra <mariusz.skamra@codecoup.pl>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 net/bluetooth/hci_sync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index f04a90bce4a9..0b0dc0965f5a 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -4592,7 +4592,7 @@ static int hci_le_set_host_features_sync(struct hci_dev *hdev)
 {
 	int err;
 
-	if (iso_capable(hdev)) {
+	if (cis_capable(hdev)) {
 		/* Connected Isochronous Channels (Host Support) */
 		err = hci_le_set_host_feature_sync(hdev, 32,
 						   (iso_enabled(hdev) ? 0x01 :
-- 
2.53.0

