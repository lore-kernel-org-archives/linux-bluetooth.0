Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8895C15A843
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jan 2025 20:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737665659; cv=none; b=OR9ICNYPiTFQg2/I/nRrgJhkaY4hLjVHf1gDuX2tK18aqQJZa0kBjtgxDOFCmu2EA5x4tNlJtmw60P0ALcU3JdJexRrbMenwN/g/D2nSDgrzDZvQu2N8xKZa2l2SOFy2O8Bt8Dlo0uEOZYxCsDG9cCaacDw0x5mohlXChdKi/K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737665659; c=relaxed/simple;
	bh=VD5WBCaAvYBltFs4uApZvdiMzVBRBaMtBOkQn5htyXU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=p/mMlX/0xiINhs/2VIjevDDEqcRFg0z1PzalNvoXJRyGKREPbKzcvgHiOroeWLGZUGp4gHaGWrNocVcREznzBTVn/es0GQIlC9lpOs/f1bsWHO+LGw7n8NM09YrC3WuTf3klDw5GkalJlD99OxRZ28t7iIYDDc/142PvTSdFQfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RWGW+ZV8; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWGW+ZV8"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4b63d564e13so793697137.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jan 2025 12:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737665655; x=1738270455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mle2vJLSWOxqOwACBdyVMrt7z6vuFa6PTjz+K1bLwXA=;
        b=RWGW+ZV8K0Z5EEvqw8oaNNl2xJmcYVSyyYl9/7GerPdeNlZdnSvSMssS+yMxPx/UKR
         eowflPHVMgb1S4p+0AkVfNQTMYzPvCdC7NxF+4C8qm6dwsKwtkAEH0qv72UjG8P5cDzy
         FkyZopCP00HJXSapfXMmxHZxQhOCSqATzxYgZv0ox79LgV5HJ1I/V+2RQpokfVUu3cew
         VQxmjxuJ7e7Otioo+F2o3YJNzvB7E/vTXw1nMxGoY9+0zsTBXy9LTKZxhMKVAN4Af5dT
         8vr+cU3VcOr097x4HX8in7OdVJg5XHQ/EshcG6hqO2HhsNUdseeavs1bdgiBKlbSwWT8
         JuWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737665655; x=1738270455;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mle2vJLSWOxqOwACBdyVMrt7z6vuFa6PTjz+K1bLwXA=;
        b=M1yu1QVIdZOgbKtUBqhz0METLlbogJnTVP0j5adMZl2pGKtZpaOU3zNUQEdgJlED54
         LyqekuIhJcjGEowWf+lbGeaUQ5XaB3qsIK6R1V4sa/bscgHbXUX3F2H/0GwIzujuHoDe
         W+pLUsMNoavGXjvsW1MkdqiLsn/kOwPMqZ8ItqoI6k4q+CSM+0nF/4gjdHPA+snDARtq
         YYUAzQFPrLNsGAAWkkxlQs+oknMO4UrB2JmCO4A/JVKU2OO1znp7eJyIScI/Vf4W6sjK
         3krxie8///HB0KrCN3n/Z7RF8HEViMGdEsS6RtSe79g8wo0MfNvAxd/mu4T0KMUV2t0p
         VcJQ==
X-Gm-Message-State: AOJu0YzqwX6pkPG/7ZqtDZ4TfnqdU341a5GHaO1jVLTT3r5Bo3lsNPEj
	x7r+2cDaj7BFNmhnCKfwPcLlC0hYm2v2WEJRawmYiTk2wQkMAICk43HUCfsv
X-Gm-Gg: ASbGncsSCfoTcAIir7eucXS6KEbZpwj5ZVekc58Nqt84D5X2QBZp79x+8QT85xBz0vu
	xvcOwW1GTQHKB9JJH6Kg4bO5kUvJUN4wA8UQiWRMdrmM74nbrm6UljKVCI+F+b4lCTb9DdAgzLF
	HZ6XEA5sE5/JJdlF2rD0sIvg5Qq0N7SKk5BIHba6HTOACJ2s6kd0ptFDE3/H7zicwl8rckr71uJ
	ECD9RpC5SSwWURiK03XSPePJxAXjQ5taZzb65pvRkvl8FFUJz8qXj8ZzNx4G4FbbsixNnhd6b75
	bGMS9Yozw91BszAO06dfraoorCD371CfsJKg90DcI+PqxEB9BCYu
X-Google-Smtp-Source: AGHT+IGrKO58xqG7RBkuXv52w2gKDVw0tsraK7s47WPk6Vzh62rTzxoOPyYppRXEzW0p9UY7jGmS1A==
X-Received: by 2002:a05:6102:c04:b0:4b6:d108:cac0 with SMTP id ada2fe7eead31-4b6d108ce5dmr16500057137.3.1737665655179;
        Thu, 23 Jan 2025 12:54:15 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-864a9c3e360sm66240241.28.2025.01.23.12.54.12
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 12:54:13 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/2] org.bluez.MediaTransport: Allow Volume property to follow profile range
Date: Thu, 23 Jan 2025 15:54:10 -0500
Message-ID: <20250123205411.369041-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes the Volume property to follow the profile defined range.
---
 doc/org.bluez.MediaTransport.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/doc/org.bluez.MediaTransport.rst b/doc/org.bluez.MediaTransport.rst
index 78789bc8044a..a4894a413652 100644
--- a/doc/org.bluez.MediaTransport.rst
+++ b/doc/org.bluez.MediaTransport.rst
@@ -128,7 +128,8 @@ uint16 Volume [readwrite, optional]
 	Indicates volume level of the transport, this property is only writeable
 	when the transport was acquired by the sender.
 
-	Possible Values: 0-127
+	Possible Values: 0-127 (A2DP)
+			 0-255 (BAP)
 
 object Endpoint [readonly, optional, experimental]
 ``````````````````````````````````````````````````
-- 
2.48.1

