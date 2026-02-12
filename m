Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7FA28D8DA
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Feb 2026 07:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770882088; cv=none; b=WKu3dsMSlQ3ksd5H8V3qzl7HUwTU29FFsCcKNafCsoGJbl9O4U+kEjto8QIVkmY8Q1J7dwHKboTmCu1uX4re8Ss1+mxrtLhdo3+fXoqjo55iCcubQoBrsnkKieaUQarjFTsYD+SnflPV9EUl8ejq6dduAUCMmcWjX1Bbl4I5Sq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770882088; c=relaxed/simple;
	bh=Bybq6YVBkqHEowrDi0KJ1icafdlKDBEW945WLREiWpA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TcEfEmrCpu7xit6VS1nsccUiMSnKTy7aQFBcuSi1x7vO1Dq9YzxdUQ8NFlyJaBdicK/WR9S2NReZ2CJXUwVtKVplgMnhw1YGuRcWZgzblRAvuIbVkoUiA3zVWHTQj8r4cVse6ryowkg/NZ2vox3mzv65OaYud2rnv0aafNRKBgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=codecoup.pl; spf=pass smtp.mailfrom=codecoup.pl; dkim=pass (2048-bit key) header.d=codecoup.pl header.i=@codecoup.pl header.b=hFdRZU53; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=codecoup.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codecoup.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup.pl header.i=@codecoup.pl header.b="hFdRZU53"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47edd6111b4so113778315e9.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Feb 2026 23:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup.pl; s=google; t=1770882085; x=1771486885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/dcSnhEINyICNkHx9eepePnYVOOlEAglwp8cHbM0S0Y=;
        b=hFdRZU53ovu9sdBUVPauU1F77o+Jawo+F1y+KUwpFhjQ5VJb9RfqEni/RQYCiNaRyr
         97yuBzwsZgxWMmsXve8zD0NCtBiproGkYBKGx0kaPz8Mn2hYbxI2F9jvb8fKBZfPbIli
         mUvq60AiC4YbzSfEJk8EHGWykTmwan12D0IeWyRIICuTZdAcBw3RNsocN7wKeZh1uEa/
         BwmfTLYYFIZnKlCvfdJmHhVzANFbb1LhxJKOauD82x0UpmKkOEEfdbuz0bN002EoDaKK
         SMVITj8qXk9oR8bIm03/wlqj9uRGq52/4NwHT4RKjh9n7Wa5DeSylqEqfgkTEdy2sGEe
         R8CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770882085; x=1771486885;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/dcSnhEINyICNkHx9eepePnYVOOlEAglwp8cHbM0S0Y=;
        b=MlMYC1SHKAfQRhbiMhuVCo2B11VIOVCm8herQeiCVvqp4C/7tmFXwMtsEQ8PDn3jc8
         8U5fhsjqC9kZjntzaiyG9YvJlaO91DoSvOf/UYzB/cjnpmXAXEoAwHO4g2DDUIQoCx4x
         UMjQaNUHA+NF6Hr83UyupVuQiRnSbcEz5qX9z/rt5Lut/s6Ny4vK7QIlPXPlwryrhPXP
         jLwJyFRM//gDYtXFM485slDBgMmYr1v2AlEOfASU58i9WLdTbpW8sKGH4DMWPhX7pwGa
         gAB/ch7OOnMKjU+BbjLHJ1i1cf2kB/+lRrlzKBgnYc/dgYWQCtbirOs4znIbQ2Up8AjI
         Nykg==
X-Gm-Message-State: AOJu0YyUHQkrJAxaIG/7+UVrsEvCYt3CUu8XNLk8xQW62uMzounx/vg2
	+IahR0M6BCauamm8Wn+o8XaN38Qypn9cEqpyeCtas6C5tFDSA68/DAxmTa/atnRMa6HUO76+BLa
	jHJW5d70=
X-Gm-Gg: AZuq6aIfWFh5MtSWqXE4cZ79t7z/SvtEmJ3bOi8eDhQcJIDNduQKhRLw0vqEFsyDS9d
	86s4gfUO8TK/dZHozcNgJv9lrZNdWK+UtZhxaaA6UZm75tusbn1+M/twEvaRYntjY/RGy+wU+VC
	GhpugGLDt53O8xFkYnz70xA6P5MRFRfg9CkqpWlMKMYCntAHG3ySz4HXqQdaeRswXvTFzEY/VdD
	Wrd6Hc5Q4q/0yOs/hKCrvlovGdGmAdqKxF6Zn7d9mgIHnFv9Cu4OKw2hSN9Y7tBP0lSTWp+190v
	PE+8s6v/LETRNoCqoYyaKt1uU0IQ+cp+ua2eENaTdLsyTEUSO3JBawQAvmTzQvWmqbP0eWxTjR/
	PnoLnpmLmtnTCF/xGdnEQ6lKutGcbkQb38Tfkw8mh4hYVIpSzTt4JHRzM5RzljmwaTtNfUmn3Up
	x0UsF61Vsnyy3ekKTzNGaKOftPIkPT
X-Received: by 2002:a05:600c:3147:b0:477:9ce2:a0d8 with SMTP id 5b1f17b1804b1-483656094dfmr23961805e9.0.1770882085434;
        Wed, 11 Feb 2026 23:41:25 -0800 (PST)
Received: from localhost ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d5d77f9sm190614435e9.3.2026.02.11.23.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 23:41:25 -0800 (PST)
From: Mariusz Skamra <mariusz.skamra@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: stable@vger.kernel.org,
	Mariusz Skamra <mariusz.skamra@codecoup.pl>
Subject: [PATCH] Bluetooth: Fix CIS host feature condition
Date: Thu, 12 Feb 2026 08:41:11 +0100
Message-ID: <20260212074111.316980-1-mariusz.skamra@codecoup.pl>
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

Signed-off-by: Mariusz Skamra <mariusz.skamra@codecoup.pl>
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

