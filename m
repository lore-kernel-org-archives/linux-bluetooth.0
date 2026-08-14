Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E8A471272
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 17:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786727724; cv=none; b=DrrcGGH6Av4sYcMN7JqRbGH62kPhvCviGU30gz1wViYP3y16irS3DBFJRxBhLgt4ymWkqNtPI88WTIFc4YPiZGn4FAEoyfz6+u3fG0VEQw6vfnEn2atyq7dyLoFsDN3sO2vmZ+CKVeJifJnsQpNgreObKUKPbPYXZK2M6EKH8+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786727724; c=relaxed/simple;
	bh=rAIZLVjKGNG+y5bKDCvSwEHs2PLOnmVm1kYSBVKJnHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iqoCmjkhdAfyu2uWzexr+0RkmS/aCSsbSyVBz5InhcrVdSwz44tr/4KiAYWrwDlxLV9UDbDfWQ09+JMimAYJSwF4KYXfJPSxSg1thfAbcOIZsE0PZXL5awGtyC7nWnWLqbgao47rUqf5Cuv3s/z6NweRCtMtEzt1Xv/wS31WTpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZtRLp+n5; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZtRLp+n5"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2d049069377so14252505ad.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 10:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786727721; x=1787332521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J7NzHtDJgIE4Qs9o6UwfjLslH9XWPzhykTS9dM7bn5w=;
        b=ZtRLp+n5AG/W44OC8RVpPIerN475tbNRmjazG6DcRkw7VtwnP8f/F+tpAGIlcszPA9
         yCWuo9nhsw+hHfgz+EtMcDi8d3a05Igjs7L/FUhcLypjPQnUWUo9tbrf8EhyvczJNRKt
         1k7ET9S9d4dToYHJQ2Zy1kiYCiKi7/etZEEsPvY5VQ5XJ5skNL8hquQ31sNuDYuwCEqS
         hYJb0GTrNsrcpta74/YT02jCU1J/AOo1ldzmcVMqbVpK4LMEgG8jFJ+OU/HTo+ZHr3KZ
         8mItPxKAyAmt7a+5p5jnYcO+5OkgGzKU1Cash/QLje5N4gauqPdhXWjsTVLKzlXxFYj5
         ZUeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786727721; x=1787332521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=J7NzHtDJgIE4Qs9o6UwfjLslH9XWPzhykTS9dM7bn5w=;
        b=MbKH9cxg+QufY1ifpc02LA4DF1Knae1T6d1ECyD+MPRyhRtfPL1QvbWtM+CYhIZB+Y
         +rXuBjq3CBQvIIduGWbgHPiKE6KHTMFsM2cMQWB0Rom2POjeE86BicVI2NdS1wOqWVPW
         fWZthEoXVTCq0mJY7sIL5EVn7QiWhT9B6BbJIjO+SE50txB+desoYwob4ewgL84hVSXX
         gfXbjCrEnMEQuSZJj9fys1igCX28FyOm7NrSGKiJUX6J9l3cfsq+hXGTLCNY+1CZ+3sM
         RSYqTRvptjuc2vpd49tNXl7UtnjwtfjTh4BMwLchZViIqRpLOO9S5idW1OBcCWcNmbbz
         FZbg==
X-Gm-Message-State: AOJu0Yw/adQv7NNbj2s9mKoVDbvdvX6WudtIybJpz6/7Y5q+jPo+mr9Z
	JumkDVdUo8BnnHU60nxicNfFclb6IeuL8l7MPc2wA49KSIUohUoZdX6OC6X4JETe
X-Gm-Gg: AR+sD12mIs49o4lQjWQnX8woiXZ9LR2NOCmcQEIeEVmCD6E9/rD3nNwsEg01VdhxsK4
	yt/UgJuOuHJBJLHDa26ek6v7ebfME6ojvvbcFSs34jr/Bf0YuEQ+lb1c/3iZ8j9+E+Ty0hXwdrE
	Q0pR9gh2Fum8gFbIKu76b7HhfReyBPx83jGrYaePRg4xDarX6R3uh4bbJBOVYm751u8KPSnyQ3s
	FyoasD1V6YtBfWxG57tQowgRWSP1v/PpqTcXjhzQxrO0GdOtc9tMi5OrbLyz9jKUsl174fLLike
	n5xm3nR2BmmsMcK301BsIAZe7P2Wt2BsU9Php65AcWQOIK+/OTVYuT1mX93bw/XJ/v2wffa03vm
	oOs1rKg3HjEXRuf2sr26onQ+UnFbaq5TX5OWuKXphWX700LYYBbLuS0te2ash0V2KJcvgfQmwoX
	u/taL/MBCMM7paat5oAyK8CfmdufcDbHlNbV0vGVFnC++iTcewwFV87XNZyoH6msTH6EFwryT0o
	4+JBRXSkk5iOs5ZN8Z3Z87IAhpVyt3ZBN3w5G9pp6oAfaRxDTGkTsf3/kCmO8Pp9mrQ0/oz4a93
	S9LHT6r6ZILOghB3/LNP7mXR0AWnerZVTa56JVMScumUS45g8seodlpPpfnYMSBsPPt7Ohefx0G
	xrSWNjkl53aSAv1Zabf38iLxfOwbmTnZ2F11pHHwf30pK62R9Thfui68XYLU=
X-Received: by 2002:a17:902:f603:b0:2d3:78c2:1f19 with SMTP id d9443c01a7336-2d3b0c5798cmr89161055ad.9.1786727720384;
        Fri, 14 Aug 2026 10:15:20 -0700 (PDT)
Received: from localhost.localdomain ([101.251.7.10])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320ea2f787fsm6182234eec.20.2026.08.14.10.15.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 14 Aug 2026 10:15:20 -0700 (PDT)
From: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org,
	ali@iusegentoo.com,
	raghuram.hegde@intel.com,
	kiraank@gmail.com,
	kiran.k@intel.com,
	ravishankar.srivatsa@intel.com,
	amit.k.bag@intel.com
Subject: [PATCH v2 2/3] Bluetooth: btintel: bound firmware ID by TLV length
Date: Fri, 14 Aug 2026 23:00:02 +0545
Message-ID: <20260814171503.42684-3-acharyalaxman8848@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260814171503.42684-1-acharyalaxman8848@gmail.com>
References: <20260814171503.42684-1-acharyalaxman8848@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The firmware ID is treated as a NUL-terminated string even though the
TLV length is its only boundary. If the value does not contain a NUL
terminator, snprintf() can read beyond the received response.

Limit the conversion to the advertised TLV value length.

Fixes: 164c62f958f8 ("Bluetooth: btintel: Add firmware ID to firmware name")
Reviewed-by: Ali Ahmet Memis <ali@iusegentoo.com>
Assisted-by: Codex:gpt-5 sparse
Signed-off-by: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
---
 drivers/bluetooth/btintel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 26435e41f1ce..c204e9a1cd0f 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -701,7 +701,7 @@ int btintel_parse_version_tlv(struct hci_dev *hdev,
 			break;
 		case INTEL_TLV_FW_ID:
 			snprintf(version->fw_id, sizeof(version->fw_id),
-				 "%s", tlv->val);
+				 "%.*s", tlv->len, tlv->val);
 			break;
 		default:
 			/* Ignore rest of information */
-- 
2.51.2

