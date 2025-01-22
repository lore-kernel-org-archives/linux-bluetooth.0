Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA471B3948
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jan 2025 21:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737580494; cv=none; b=HJxv59cQ72V+kpUJFNeG6ESemSSSqujrRoA5RloRnsoOxodwDKFVLpv8RGj1XfXW/UNl0M1P77Uc21SXxdhPjZ8TlRxLD+jC8hgDl6bu5025b75fzeKqQcMWMBNiIqUZTmdsCE52jQliTruy6aTMnuNm/fIHaDXn4JAvXgPx4Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737580494; c=relaxed/simple;
	bh=VD5WBCaAvYBltFs4uApZvdiMzVBRBaMtBOkQn5htyXU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=O5voegxaTGvkghmT1bLkMxRkgw2cQj7OAGaNsbTlViUuESczhGBX+zZk3+n/v62yFl9H4evD9+1gkq8f5fzl/beFZ1mzh3bZ9ieXrxItUV+gZlW5EZRZalxjZ0Mk+b7zxdt7TvGVAY8cTN8xCAtL1FDeYfQDpFr7z431oJsvQiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNYl6Gfk; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNYl6Gfk"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4b60c221587so99718137.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jan 2025 13:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737580490; x=1738185290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mle2vJLSWOxqOwACBdyVMrt7z6vuFa6PTjz+K1bLwXA=;
        b=jNYl6GfklGY6RXiWfo4HYPG03G0cy/LBtSR42E2DsTOqFzxjDFRqbwe0N2cquayuXx
         q5ejTFvdV4EaAWV0QApLWmeBShzyw/CrarTFKPWjWZ5mldBWb7pPxQRXIg/oRCfolDSu
         G+3xcGvB3+fay6TvaQH8SjdcdhdcUIYLuosPxgzKiJq0vLc4hxfXvRotLjGnK40Dsjot
         IpwzGWIIjEsChzzPXL5hImVnKZRWy97MASkqhU4kJchESfX46p+Y9lXgAc0DINiTQ1hS
         GL9aO1r2sWuinwkkjJBwNnff1LKFI+HsPKj6LTkZrUaZI2ZbJZNU7E0e1zcNbxKP+oXJ
         oG1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737580490; x=1738185290;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mle2vJLSWOxqOwACBdyVMrt7z6vuFa6PTjz+K1bLwXA=;
        b=HIpIYSzUtzmpnk9qQ/DgPQ0fFtZp08VXenCrlJ00wfxuWIuTfDl5wZI7Mqr4OcDlf9
         ojbB2wtfS1h73bN7Q+pPyb21DBrB9TAyMsIR2CqpYXNoHSzyXEvMNrAd6GVagLuCXGhQ
         4V6pzH7+Y0ypt0+ny4yXBbk6X4M5UWdq/2IvJbc/J4jugesvVZLSDiaqe4jdLTzhbQmr
         hK2uB5wdlTB6wYndm/WQTn/+gE3ueQFxdPrSnvHXKRLx31Lq36xjDmTvhyKvT2Cwy1jj
         ECqOc8nrek7ON0a27T2LNM4u6zN+R5sF4lhCHiyx0zq4bVkTQeV6z1uruJOeLEhKq+/8
         ARZQ==
X-Gm-Message-State: AOJu0YzRf6cQsoF+JoyZJLG0kl6+NVHPpVdqhAXoRlHqMrdFhgM2h4p5
	/s8UHiu1JxCc+e7QdmzVCfT/YPlJyUXZWZVZX6wSx1CVkrEPzxwkcVjeZ9gB
X-Gm-Gg: ASbGncu58sRad3N0sEqsS5kETxK3zpMHagHWNYcnxOLNAebG4l0x0JBoZhYXJG9/MxP
	KTYJCarR3wQ80vwRfGvpj2hQmijxUHsZbXV5jhOfg6Otn0GWJb1idx7N+rkUPwrFPvJW+MTdMoi
	G8R299bcC89WdZjW9UEtI+ia0EPhYw9t51TdUvsixH62x7qmWqxgBWo7k1WSXoYlABjVGresXED
	GgTuWVDhMSrLTJEgGMLkYsBDTDvExUe/jkqcXSo3R/oe03OjpsSKFg6S1MpDJsu98nkkM8UFDx8
	WIODC4wN7h/VmbO86WHVmS+PgVjriGhKuGPPpe8mIA==
X-Google-Smtp-Source: AGHT+IFdtgUTTYE0tKhKAmuwLj1rq7cGqExhbHlSgg53IpXfH41bllE7Mw0F0+vVw1SboJqIdzCekA==
X-Received: by 2002:a05:6102:94f:b0:4b2:5d65:2c7d with SMTP id ada2fe7eead31-4b690bb6352mr19429672137.8.1737580490574;
        Wed, 22 Jan 2025 13:14:50 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b68a21dae2sm2840665137.13.2025.01.22.13.14.47
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 13:14:49 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/2] org.bluez.MediaTransport: Allow Volume property to follow profile range
Date: Wed, 22 Jan 2025 16:14:45 -0500
Message-ID: <20250122211446.142626-1-luiz.dentz@gmail.com>
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

