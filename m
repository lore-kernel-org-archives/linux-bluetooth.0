Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70DB16191B
	for <linux-bluetooth@vger.kernel.org>; Sat,  7 Sep 2024 21:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725744793; cv=none; b=RH1Jp2ueQoxiM3CMPj4UziB7frHWoF5hzhC3H0BQwu6D4HoMHbn3mp7ALRxxBCfqVwRDGFfm4+w27utkDVXblvXRzKhBBa1Usm1Tng0wJn/X3HfAy16HqOKg5gaHQSiqvUrAPVMF+yrf8n1K48KITPnfVKHeXXNuN2Fj59egNGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725744793; c=relaxed/simple;
	bh=11ZNqQamjklm4VKeCSJoTyd0mrm/OkVBxeTPW8/NyW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lHeR6551wMsexc0WLOfpHrUnwNfzBZ2Vr7szfRTxdIy5N0JDI1TPeBVxB4DruCXtEQIVeWa6gaOPD1t3xApan/dFq5VApx/C5zzk92zN27Rfaudjk+Cx89xjUWD9OO2XjvHuIiwEC4T+uL3mLdx+P3QLuNJ9u2FC5LyLO6+LBb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xs/Gb+XK; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xs/Gb+XK"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-718d6ad6050so1420657b3a.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 07 Sep 2024 14:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725744791; x=1726349591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HKDzOON4zmsI81A7x43VC/PXOetjrXQr15l7PLGc5kw=;
        b=Xs/Gb+XKw82ZDxoymSH7922DrYI5Ov48/v42dbEDbbhK95MnhMxRue0VobQx/QGZNT
         8MFgnA2efvDYcMud62m7uN+03Sfc4W9QtItL+Lo0ekWxaNjOgsAUOCyIp6kBfpTW+rH+
         14YILcG0LQw9kA8mxC67s44HZReGytoCrfUOZA4WysR/FZn7tPeDOlXmH7KWsMf0thwJ
         ceJvsgJSTBuewcFsc4QGdG0YaLQKXS0AAxND8YI7EVpR214YOxto346JuAe6CcNBrtbj
         XEH9V2OjIlmsY8+nyl/THB8IY1x0vP4HiB3dIUB+VHqbLGNUd0WWCcvFE4ojk0WZUFMa
         Ym+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725744791; x=1726349591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HKDzOON4zmsI81A7x43VC/PXOetjrXQr15l7PLGc5kw=;
        b=Zmg69wzV0Fap2URi+qvq4J5F4sV/5v6MmlXy65WXxKD5XseXdZNRUHmr+Ky/OZDHVg
         RbgG8rrJdGdjBrYkdmZluDxw9iNBVooX/osgyiwx/8m83qJmoX99ThHx5M6rXy8xko9W
         teXZBPTFqEvq/EVUfj+6R5R6gFM8boot5iI56gZTePGEOdtAEQX064l20rFSrQnIGAwL
         MyK9IPngkHdQjEv0cDCXV1bMXPX0mv3S+gts0RlrhndOmBx1NaJXfiUZQ5EKfKltVIqt
         bWcXau8dRhcs2yO76cbnfdgYYW3uBkhrdVEBRKKJq9naD0DLrsRLsR+eIxXPkgKCwnMo
         8Agg==
X-Gm-Message-State: AOJu0YyI994gWXrDb02WJgnCn+fyKqvmR43rvHTioMKbmDbugYzr79dt
	D1GEB8dMXsutMnahpkot24ItdDISXE2hXIGm5ACkQrCV1zzG1Zgrt5HwKA==
X-Google-Smtp-Source: AGHT+IHoavz1uURpxbrAuzulh+NzyBsBGRGAgOLSHOfd2g6aZJ5ECEq8fAaT9Ux0Nwu91zkJdiYZDg==
X-Received: by 2002:a05:6a21:7702:b0:1cf:27aa:3785 with SMTP id adf61e73a8af0-1cf27aa3916mr6029769637.6.1725744790750;
        Sat, 07 Sep 2024 14:33:10 -0700 (PDT)
Received: from vibhavp-an515-58.lan ([2401:4900:1c62:13d2:d7f9:63c9:9aab:1368])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d8241be950sm1229781a12.44.2024.09.07.14.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2024 14:33:10 -0700 (PDT)
From: Vibhav Pant <vibhavp@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Vibhav Pant <vibhavp@gmail.com>
Subject: [PATCH BlueZ 2/2] org.bluez.Device: Add documentation for GetServiceRecords()
Date: Sun,  8 Sep 2024 03:03:01 +0530
Message-ID: <20240907213301.14000-3-vibhavp@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240907213301.14000-1-vibhavp@gmail.com>
References: <20240907213301.14000-1-vibhavp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 doc/org.bluez.Device.rst | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/doc/org.bluez.Device.rst b/doc/org.bluez.Device.rst
index f94fc2129..f8d4a68a6 100644
--- a/doc/org.bluez.Device.rst
+++ b/doc/org.bluez.Device.rst
@@ -135,6 +135,25 @@ void CancelPairing()
 	:org.bluez.Error.DoesNotExist:
 	:org.bluez.Error.Failed:
 
+array{array{byte}} GetServiceRecords() [experimental]
+`````````````````````````````````````````````````````
+
+	Returns all currently known BR/EDR service records for the device. Each
+	individual byte array represents a raw SDP record, as defined by the
+	Bluetooth Service Discovery Protocol specification.
+
+	This method is intended to be only used by compatibility layers like
+	Wine, that need to provide access to raw SDP records to support foreign
+	Bluetooth APIs. General applications should instead use the Profile API
+	for services-related functionality.
+
+	Possible errors:
+
+	:org.bluez.Error.Failed:
+	:org.bluez.Error.NotReady:
+	:org.bluez.Error.NotConnected:
+	:org.bluez.Error.DoesNotExist:
+
 Properties
 ----------
 
-- 
2.46.0

