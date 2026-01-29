Received: from mail-ua1-f66.google.com (mail-ua1-f66.google.com [209.85.222.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1860F37647A
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jan 2026 23:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769728948; cv=none; b=TFolHujftp6F7JqtsNZBGBEyvlazB948CdJoczwCh4riZ5RtGGbU21EETX8JKftG92el8Y7lnwIONRJ39S+nVUhSx0KRYKpbe+uQDHybMhGQ3cPKrMzMxU5LUzBmCSPDt5fw/sO5i3+98hBObekh5ldApsJqR+Y+0tudEgOc95M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769728948; c=relaxed/simple;
	bh=FSenn7kpmLKI5do5DZrgMsSI3mkOJVOhZbF6iKb/+kM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y6Acfr/0a/cviCytt0m1EcluO/BgH3Yu2UHZnJij1mwgeQaldSspCk3rbTuYOPmGam/w9icXCzpcScao0FkQ3Q/Y38SXpkn03iLZ5oN3xioZ9ovwi9pG9iRLXZGeXaIIN0pW9Cn2bxiE10yKgwMfm7HoyArcEMLtAW+GqqPlok8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m0YfSQTp; arc=none smtp.client-ip=209.85.222.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0YfSQTp"
Received: by mail-ua1-f66.google.com with SMTP id a1e0cc1a2514c-94849af2400so457262241.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jan 2026 15:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769728946; x=1770333746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wBzKiOWJxuXPtIB6K9WcjvDCnDSArjkPW/xIPOMEfMs=;
        b=m0YfSQTpd8zMd8QAJd8DhhWFmLAZH3Enek9RSxIKNRV2Hr7ZvIceLzdo+Tf+OCDN4t
         rIX3oo6TCYMSde9h0+KghcNdhpVtUtU6tq6+Ngc3ytXhnn0giRw835ZDP61XvrEoRBgx
         pRShDgm0Wt1ZeYZFHtDUXkE1MXJxuP0EgaqrTqxTyBFWKHPU4iDexzgRflyfBGxt4if8
         Wv6lHwu5ktpD9YZd5PuOmynIYCnDS5K0xShQ1F6CaOPSJPUREz5uBh9xzjkOG1QUfNdI
         oZ4t2igPDCdRhXkszf1g+wnBXwBpMAytq1CaxiaTwMFukI7UYrNktbCY0KYyhk3OGMAt
         NgQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769728946; x=1770333746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wBzKiOWJxuXPtIB6K9WcjvDCnDSArjkPW/xIPOMEfMs=;
        b=W8sqsdgRwaWdsUoxjlkkYsmxMCCZN4eXcJBT1xMVjvBGA61jQjz2VtzbbTQ6THji9s
         jTQ1Q024qWyQisnxQXqdCaYtRGzfPAoVg/nl6EjhbfYTDLLy7oGEkEJBzOVq0BVDWm8y
         TLwzRhhp5wPjW8x3nb1NlKGD1i2GIWt/GswnFWFzV5c/eRni5RUsvWNeOth6JuwBgdDa
         HkmE6lU6LyWFyc4vpjXqWHvlUTz9QQOgkYUCQk8f08tM6HorfnSwJFQowCEamgXZkVJW
         ssS57FP57WCDChdSzOEjUgok/kVasCV8Sn5JyyqFQTXt7FQ2RjIQPQQKW+Q9tuAvCZPq
         CHvg==
X-Gm-Message-State: AOJu0YzrOdSpfAxvqYPoVpgThJWvV6fdcHl+uX/dtjt+xpstOwXDUQ+d
	OOhmPr1wQkg0VdVMNyj6Fca3i0m9NMx/2OzcYper+jio17LuCueR0z6rXRxluPLipSA=
X-Gm-Gg: AZuq6aLskCYJUaOk+gNbgB8dJHjaOn2N2jGRx4TX2fOnZyumC0tFm57s0sWAksiStIw
	0u7zPJ8z7O5b9l5uj+QMwD2nhU4KaRAFTGEHddwWla6vx0EV1hJ+tBmi+1e3s0xOGjvcKHIs7nt
	kPY4CRFPeaiMBoHGtuJnRtaiJhJFOlu+FDuyEFUMMsx1oMV5hZzuJTX8cURVabAKix5vdQyT0K1
	nH7Y123dZfzAqBBslej1GqChRafyyzMvUu8hFs/YIQsO86sI6lXOmlkOkQVl8pTo2w1jcGVsVLx
	/coCsbKZ/3cdnHT0ZU/k9N/Ny4RvCGdGUzilvYdikfCd/V5CC56vcNdFAJfWiGCQ4zE9g4E4cpo
	67pQWECsx9N716wjOOs8TTDNMgdoViV8mJhqnWdOcyaDA0lWtumWgy9UG3WnNzLlxi6x8rjE7Lu
	Ze4M5oiQNybXaFP+r6dFEW0yP1pFAEUBsRMcFpmvzpbJp9oJapVgMmuoQHK2JNe0iEHgbbAdMx+
	KxDcw==
X-Received: by 2002:a05:6102:3e89:b0:5db:cba0:941 with SMTP id ada2fe7eead31-5f8e26860f1mr368996137.38.1769728945803;
        Thu, 29 Jan 2026 15:22:25 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-948724cb7casm1535890241.9.2026.01.29.15.22.24
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 15:22:25 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 10/15] doc/bluetoothctl-le: Document arguments and add examples
Date: Thu, 29 Jan 2026 18:21:49 -0500
Message-ID: <20260129232201.1049568-10-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129232201.1049568-1-luiz.dentz@gmail.com>
References: <20260129232201.1049568-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add parameter documentation for show, connect and disconnect commands
explaining device address and object path parameters for LE operations.
Documents optional vs required device parameters for Low Energy
Bluetooth device management.
---
 doc/bluetoothctl-le.rst | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/doc/bluetoothctl-le.rst b/doc/bluetoothctl-le.rst
index 808d5786ee80..11f26d30ab6d 100644
--- a/doc/bluetoothctl-le.rst
+++ b/doc/bluetoothctl-le.rst
@@ -27,6 +27,8 @@ list
 List available le devices.
 
 :Usage: **> list**
+:Example Display all LE (Low Energy) devices that have been discovered:
+	| **> list**
 
 show
 ----
@@ -34,6 +36,11 @@ show
 Show le bearer information on a device.
 
 :Usage: **> show [dev]**
+:[dev]: Bluetooth device address (optional, shows all LE bearers if omitted)
+:Example Show all LE bearer information:
+	| **> show**
+:Example Show LE bearer info for device with specified address:
+	| **> show 00:11:22:33:44:55**
 
 connect
 -------
@@ -46,8 +53,10 @@ An active scan report is required before the connection can be
 established. If no advertising report is received before the timeout,
 a le-connection-abort-by-local error will be issued.
 
-:Usage: > connect <dev>
-:Example: > connect 1C:48:F9:9D:81:5C
+:Usage: **> connect <dev>**
+:<dev>: Bluetooth device address to connect to
+:Example Connect to another LE device:
+	| **> connect 00:11:22:33:44:55**
 
 disconnect
 ----------
@@ -57,8 +66,11 @@ Disconnect device over le.
 By default this command disconnects all profiles/services associated with the le
 connection, and then terminates the le link.
 
-:Usage: > disconnect <dev>
-:Example: > disconnect 1C:48:F9:9D:81:5C
+:Usage: **> disconnect <dev>**
+:<dev>: Bluetooth device address to disconnect from
+:Example Disconnect from another LE device:
+	| **> disconnect 00:11:22:33:44:55**
+
 
 RESOURCES
 =========
-- 
2.52.0

