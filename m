Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A226B1D3199
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 Nov 2024 13:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730815089; cv=none; b=nWfl5L8KKB+Nq2fTcrHYV5NgLdeVR3qmBEC1wHOmcswruLyr8uK3b/F5YjPZl1RJmnH8o+o9XHnaoWSJB39ACjpyq6u0v2R/stHg4uxFhzGQR8ZEjctdwoBk/8QdJB1ASx8YRiQKsgVt/wsVumvkjIq0KmL/qVbMFExIR/aTGjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730815089; c=relaxed/simple;
	bh=j66DA2ZhU5Dfyb/UV2kzJvZWtuuEqF22h2JtZoKSUhc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=AV9K5GVcq6RC81Ok4kC2W4fRUQUDXWXSq9BShkxIVjjXygx/UVz7T3LUmlClk3I6IXpJ0GNUDBmbuOPB4YxdhUsEx5RbpnDJldKgTSH85/G0DcRv7x9TmkOqKd7qDvq5xWSxQnqX7nvxJ3BKI0HngqHzmqQ4ZTNw5xxC9+vhV1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XyGLRHxB; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XyGLRHxB"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5ebc1af8e91so2502384eaf.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 Nov 2024 05:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730815086; x=1731419886; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XRbZpYF9p/1NPuWA0DjphUsuMiW0qJvYAu0RzCN2HzM=;
        b=XyGLRHxBPh7H6JHUkoZL58YYcmfD9X904pMSHJVczU9ZOCKhtVm47n4O73fBz/VqxS
         Uyh2ZopnbkaIxWHby9TA8XC9BaZbkZpk9OQdX3ZkNirZzobIFL2mv88FvZFfiOPDC1rG
         C1smoaBC+RPcmSYyKzixgk9XbYu2NLebR4HmN5eRcfBsv8OeuNxyqC/mBFGCPW8h+yfl
         ABo6+pTNoUi85CB4wTkcruqfJWs8/HsUExqDFrzbjOaXngBIab5nVxlNpUudbiiLo4Ql
         GjDV+oPxkkoDbZOsll0wARfGAlQPVKuR6Kw8zHMkkIcLXvpvwR/duPBsuBoGTn1VMOub
         0iDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730815086; x=1731419886;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XRbZpYF9p/1NPuWA0DjphUsuMiW0qJvYAu0RzCN2HzM=;
        b=JKet9R6mqWuN5l3324wjdzwKoqRJzCmRq6580VhmmAAoKtRJnBIDO015nwQeVX3u9Y
         kPtRJbfcvhd60nbpJcMHXmcfcCkH/Z06nIDJLfRV6+CyKvX2N9Ha5CIrB7HFawcKx+4D
         KyA0o1iGmpZ7KRPiSiZsjhGfMufQF2y4W7QdR1Kq3VVjwmmFkdxPJnBIddLnXi/LwzE8
         kNvw3eFEtKMgm55M88dAN8Z13UjJxw7rCP/2aGWBnMu2V6/amFq1CP/LJfqfj3YoKTw3
         rfASZeGY4FO6fnQkHTRjrSdmKQrMfS2AxuxS8u78cpmNJor7M6BLRPe9kVYz3qqWKgZc
         BDuw==
X-Gm-Message-State: AOJu0Yxgrw14PX9MVl8Sk3PNH6e/BIF4/MpW21gWT1alVRt8P42L42n9
	9BN0wAoB9p2l9wagRPQ6WC3mZBwc4D+HjHC+/xSGq7hgS0X1WwYXtLA+uw==
X-Google-Smtp-Source: AGHT+IFwf19JhEa2OD/otcJOSjKcmbgdA109aqa+0fuBrlneVvX3J/NJ+0DlOx4nyP1pP7vaoKLfpg==
X-Received: by 2002:a05:6358:719:b0:1bc:2d21:ae79 with SMTP id e5c5f4694b2df-1c3f9f674f4mr1637193655d.20.1730815086319;
        Tue, 05 Nov 2024 05:58:06 -0800 (PST)
Received: from [172.17.0.2] ([20.88.15.112])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d353f9f991sm59365956d6.28.2024.11.05.05.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 05:58:05 -0800 (PST)
Message-ID: <672a246d.0c0a0220.2d89fd.3f1e@mx.google.com>
Date: Tue, 05 Nov 2024 05:58:05 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0435024012421439840=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_dgangire@quicinc.com
Subject: RE: [BlueZ,v4] obexd: Add system bus support for obexd
In-Reply-To: <20241105120417.475589-1-quic_dgangire@quicinc.com>
References: <20241105120417.475589-1-quic_dgangire@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0435024012421439840==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=906477

---Test result---

Test Summary:
CheckPatch                    PASS      0.48 seconds
GitLint                       PASS      0.27 seconds
BuildEll                      PASS      24.70 seconds
BluezMake                     PASS      1692.61 seconds
MakeCheck                     PASS      12.94 seconds
MakeDistcheck                 PASS      179.79 seconds
CheckValgrind                 PASS      254.73 seconds
CheckSmatch                   PASS      358.82 seconds
bluezmakeextell               PASS      120.85 seconds
IncrementalBuild              PASS      1575.99 seconds
ScanBuild                     WARNING   1036.33 seconds

Details
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
obexd/src/main.c:303:6: warning: Array access (from variable 'option_root') results in a null pointer dereference
        if (option_root[0] != '/') {
            ^~~~~~~~~~~~~~
1 warning generated.



---
Regards,
Linux Bluetooth


--===============0435024012421439840==--
