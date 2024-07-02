Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6513A158A3D
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jul 2024 10:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719917028; cv=none; b=IXDNN3fGwJTjIVexnxUeyzScUD3rFKCjZUMRV6psm4RpC3Ls+tYOsOez/wWvGzw+oPjm9bU3QImOtf+6bVQTXvzI+42yXKc9mk5bbDfug3525/kuQOXUTIjRdhDtbT35UcWlzA2MBls5LcFJkL127HgGQlZbvkGLJAREAwvrxM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719917028; c=relaxed/simple;
	bh=KDxJbI+dbNnTcs45mgI9ltvsNHagfyw6Dqeq3KJcdBc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=LSDKvd+r8sqzVpE1r86nt2SMXvkm45HSKWsGio4FFJkFPG4X+e/qWjwojjxuMVJbE0E1P1CjNIXTpTdXHIS7A5zE2zqBl0Yhhs75JIT5OcgIQMhejDdEpml4NVxPJ7t/8HPuYsu0x2M7yc6Pw+WeO+lrfyoRuM7waUrvSDD10vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZGmDnnO; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZGmDnnO"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-446416dccd5so19287651cf.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jul 2024 03:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719917026; x=1720521826; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xfU49vQ4VzCeQoF7MlVxVRvPJ8rsVTh01AeWXABLntk=;
        b=kZGmDnnOQ2UkXCjxutUnGPhxEObIVNg+O+7h+njpnYj1bnqg9a2tWX9yNDzZLDRuwq
         Rg5SKCTrqid88Xu6PVYFlObq/5namawU4gGlgiY/8bNGuT1FcVTO5NWQWHZh8lZ8ok7q
         LZIIxaxnbyUmE2heBgJ0Zcbc2WSJsqkDmmzMJYmwlF4bg8jaZBqHAVijtHUU6jrvFSkq
         MqEw+AMXTPsn+ybvEMKu1ANsyum7h8XsNUJ9Q4lwxo2H7+WTWJOs9NSN7apU+3cBMskv
         HNKwMAJpWR0URN9cIlT24HWaKTCNdnKpVhw+7JdOa0XhEZrFz9BclYzmRLHeYP7Ww7y2
         Bihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719917026; x=1720521826;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xfU49vQ4VzCeQoF7MlVxVRvPJ8rsVTh01AeWXABLntk=;
        b=JShvG0xopHc7OLkJoX94e5nPTrDI2RHd/dAS0e8mB5qlECHdm6AeHKmGVr8HWZcSh4
         HouHg6pW+z2Bp/p+wnFpaOURC88yWuqbmXlsrS//6cOblpIos5ceA9dDUfMGHFONBLhx
         7CW74NhE6vK5eIF1u7O63Cre3/6X7y1XhaJ+QleOcxvgmc9v4O6N5Z9BESNZzd7B2ynz
         B+ZmtAKGNe++8BRpkN8P6Ei3LEhJ/xyA6WFxnPVf+hBnnFPrVrhWi4LBPc9Fw3TfDfKn
         jFne9j1rF7ZhvUwzeDShWrh+RJFXw9bNoPdw71mwMP0AdYQrqCGto7ER0/e/1B+cn+54
         OzQA==
X-Gm-Message-State: AOJu0YwSPkHdcptgGUsE5jf4nKz35qPwiCVhQF09nPiHnyF39qSMIGnu
	MoF5tzwIqQGcqpf7gbghchhh7u/PaBamxF95lpjczutKf3MBBRJd1XDCTw==
X-Google-Smtp-Source: AGHT+IHXl62T1BrCJ5yIzx1yBxROv7UBML6F5ixdZAQkVqCwW2Q/mIGwcCI93XXBdbj8nw+z1qY2zw==
X-Received: by 2002:ac8:5907:0:b0:440:ab4a:a67 with SMTP id d75a77b69052e-44662bbe0c7mr121005141cf.0.1719917026189;
        Tue, 02 Jul 2024 03:43:46 -0700 (PDT)
Received: from [172.17.0.2] ([20.102.46.241])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4465143ee51sm39782321cf.48.2024.07.02.03.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 03:43:46 -0700 (PDT)
Message-ID: <6683d9e2.c80a0220.155b.ff65@mx.google.com>
Date: Tue, 02 Jul 2024 03:43:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4399140383480315805=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, r.smirnov@omp.ru
Subject: RE: [BlueZ,v2] shared/csip: add NULL checks to foreach_csis_service()
In-Reply-To: <20240702090120.33631-1-r.smirnov@omp.ru>
References: <20240702090120.33631-1-r.smirnov@omp.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4399140383480315805==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=867455

---Test result---

Test Summary:
CheckPatch                    PASS      0.45 seconds
GitLint                       PASS      0.32 seconds
BuildEll                      PASS      24.60 seconds
BluezMake                     PASS      1759.30 seconds
MakeCheck                     PASS      13.23 seconds
MakeDistcheck                 PASS      179.15 seconds
CheckValgrind                 PASS      253.45 seconds
CheckSmatch                   PASS      360.66 seconds
bluezmakeextell               PASS      120.64 seconds
IncrementalBuild              PASS      1528.80 seconds
ScanBuild                     PASS      1016.14 seconds



---
Regards,
Linux Bluetooth


--===============4399140383480315805==--
