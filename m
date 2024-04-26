Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC3513F43A
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Apr 2024 14:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714142911; cv=none; b=s5HoC/mxUxa9lMTSk0HEKVlddt0S0weu9amYUDhS+M1MY2p+lnrxpRjoSxCKGIOgPCDn65bYPSOI+dx6JaCxFdhXSmuBVo5dxyKfnmrY8/MU5uaJjcfKDBO6XgJ/sdw/iW7ID3RGRdKfPmVR65OBkqYEsFHm8MU6cv99ldwl5BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714142911; c=relaxed/simple;
	bh=S+XsmYmHzzPXQUYMX1RQe31aE+woODcB6XOmJu+nUTg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=lKLllu2chJZZBei99cHuex6nCAeBYgfBGp0DTK2buYlVpb313vUxXoKV5o7gPACYu5qvd80/78HObg7uICq++Z7+fb1Kds1W/Thin8hwOuBAx1G0RWfimSNdDtgnKXRJC71Qi51Wmf/hpCBCz5jMH9Ym16XADDx9lLETgxxkmuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WNwioPGR; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNwioPGR"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6ee0642f718so2497707b3a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Apr 2024 07:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714142909; x=1714747709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ExVxyt74QZ11YFsxdfImxv6XanLtvdVkDWzsalJ+prc=;
        b=WNwioPGRfV1KeHwsURiOmk5b3437Dzc+UJ+zY+TyvjZpw4EYCVzMBWPI/K5sm7x0H7
         kZzDt1etLw8RhHUaCHQIKmRKiTSSYymHgPFN/0ZZVCVmw9tDhHXl/KvMnn1xu43FxTYp
         HqymM/th2AQ+edLT2oBMi7fVAQ6lUA63Itbj5rEJedgLO0BEUGxRWKuarSVra72xwFtn
         tVdYUje9VKNX/DL8+fwkAeBnrQo+1SU4tkRAdUDxhBsIpUMhW+ZPYdcWoMiRYizIR9q7
         dImFx+eEDykxpX0PoLzGjlFweP3rr0LDYpoP17p3CTN/OHON5dKAR6/LXyGKTJLHB9k3
         XCNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714142909; x=1714747709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ExVxyt74QZ11YFsxdfImxv6XanLtvdVkDWzsalJ+prc=;
        b=FgnnbxU8BOGgHu4mfmMaNUeCy385VkURMhv39euy3QxtS2jG7IEumwGXkyhleV/lW7
         KJJveO0UMIOLc6yu85o3v06zY6oZl5MJAwNNa5i4iHsPTcYW8CrKcD8WrvBuefLA4mOC
         BOzEXknZ8DDDRmZjY37IDcc94qUkR+0oU598jkEjIqNeqxqw7oSW2CnIAvYLL1KNEHJD
         ZrUmuLOcLkTy2YZOzn7AyRYsvPTnAafumMxpiZ447ISD2YZOnQYkDnEoJhfa5P5bykrD
         0Hgln/jffEeTpWI32WObbn+6YO43J3TR1R+bNBgyoiPlUaWHfinM5qLtFGQNyx5YmFwf
         5NRg==
X-Gm-Message-State: AOJu0YywA0uVMlqfJZ8g3s9g14MX13p1qL688m4OVO2AekCXtCBwOapg
	7ttAn3sLFWcq5P97xJu74qo9ev8NVO5sUA+MN8/KxqXcP6IdceYLEhiHIA==
X-Google-Smtp-Source: AGHT+IHIDA/1EI2QILOF7Uzw7TOjJapF8KQpmsrpLrNF92egtXL/+5CxgbWX4zM/VyCL1rzyDZf0tQ==
X-Received: by 2002:a05:6a20:565b:b0:1a8:2cd1:e493 with SMTP id is27-20020a056a20565b00b001a82cd1e493mr3450219pzc.29.1714142908917;
        Fri, 26 Apr 2024 07:48:28 -0700 (PDT)
Received: from lvondent-mobl4.. ([107.146.107.67])
        by smtp.gmail.com with ESMTPSA id x23-20020a056a00189700b006edadf8058asm14914487pfh.23.2024.04.26.07.48.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 07:48:28 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/2] org.bluez.Gatt: Add org.bluez.Error.ImproperlyConfigured error to WriteValue
Date: Fri, 26 Apr 2024 10:48:25 -0400
Message-ID: <20240426144826.2608852-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Some attributes may require to generate
BT_ERROR_CCC_IMPROPERLY_CONFIGURED when its CCC is not properly
configured so this adds the possibility to generate it by replying with
org.bluez.Error.ImproperlyConfigured error to WriteValue.
---
 doc/org.bluez.GattCharacteristic.rst | 1 +
 doc/org.bluez.GattDescriptor.rst     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/doc/org.bluez.GattCharacteristic.rst b/doc/org.bluez.GattCharacteristic.rst
index cd5a0d0c788f..b7e4a7b69c9e 100644
--- a/doc/org.bluez.GattCharacteristic.rst
+++ b/doc/org.bluez.GattCharacteristic.rst
@@ -133,6 +133,7 @@ void WriteValue(array{byte} value, dict options)
 	:org.bluez.Error.InvalidValueLength:
 	:org.bluez.Error.NotAuthorized:
 	:org.bluez.Error.NotSupported:
+	:org.bluez.Error.ImproperlyConfigured:
 
 fd, uint16 AcquireWrite(dict options) [optional]
 ````````````````````````````````````````````````
diff --git a/doc/org.bluez.GattDescriptor.rst b/doc/org.bluez.GattDescriptor.rst
index 94cc8b26af29..f4497c6d5b15 100644
--- a/doc/org.bluez.GattDescriptor.rst
+++ b/doc/org.bluez.GattDescriptor.rst
@@ -115,6 +115,7 @@ void WriteValue(array{byte} value, dict flags)
 	:org.bluez.Error.InvalidValueLength:
 	:org.bluez.Error.NotAuthorized:
 	:org.bluez.Error.NotSupported:
+	:org.bluez.Error.ImproperlyConfigured:
 
 Properties
 ----------
-- 
2.44.0

