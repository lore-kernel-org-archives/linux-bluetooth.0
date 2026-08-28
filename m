Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3035F4483B9
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Aug 2026 11:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787917883; cv=none; b=KsJtb9ToxNYTaVUxN9Z2xxlIaidFk9iOLiGXUHlMD/mMNVaOAoel6ekZwXDHfiEEh0sdc1Wy+6qmg7qUONBBqqg2C4fEEeebHb6aodZu1KBV0hnMAYcOilg/ixYRRo1abNz/GzTZEpajNCKEdO5tCcgscOJL2UvQ2hIwCBhi/Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787917883; c=relaxed/simple;
	bh=vRgsGDikDAmtBOgDezy1lHMTgYJ5EkUp8AZFF7KfRlE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=G6HBDcAg1MimQgQ/i6HqcBBg0UIYxKNgOUZjwZLgk0x5zWcDSRIKLoJtMMmsOg7mraVLN8J3BgJPeMpq/RNEDOFhRiEKy7g6KXWb0GdoxUj5Yv8oTYUye9l4JVWq9yvjw6CnR6VUDrRZaqv3PCSfYZoVNbXObHjkTPLZKthTH0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BuXvnkoW; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BuXvnkoW"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84f38f3b36eso897199b3a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Aug 2026 04:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787917878; x=1788522678; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vRgsGDikDAmtBOgDezy1lHMTgYJ5EkUp8AZFF7KfRlE=;
        b=BuXvnkoWB/mxb3WMz5agAUsRydpTq4QCCNDDpb85YFuraBp3JR10baP+ZBHtF4jl7M
         G7fcaVCCrl1ehSNTsFo5jDpwRHadMiEbAdWfd00G0yI/1DRadyeVYxa5Hx/NfYGPbRJx
         VTLXjcVSEIEbKgT957HHGf2buBK9s7U5Jsga3zd6ZYzA1tPzj0/VCPARBL1F9ZWx95Xt
         OA9Arht5PiEZEgcUL36oRAEoixY0s0tZWzgDnlEcJNW55OZzRPo/aTjhFLx9jVdP+B/2
         IQ+RQPVWdHV+ZPOGaoG9i7Z9d2ytLG64Xc+VaenbIELYVlvBeKhjr/PUhyeFxjzEvoud
         eAkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787917878; x=1788522678;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vRgsGDikDAmtBOgDezy1lHMTgYJ5EkUp8AZFF7KfRlE=;
        b=gM70Tq3OEx+Y46kSlBhCfUUhw/yJ7jjfBFPBYI/zWvJ2XxHjryesfyuivfvSNnJtlr
         A79r4fpCsZSBbcISsMAM83JCZGnDrWepdqZDU9EGDZbhEJwNvCmgA7uAkghAAcQogEX9
         vZ6wdcfeJkVgtMs6/dJazcJHadDfJ2v4GiM2duLdAoEgWRDAjwk1OrlB6eTpvSWNO4mZ
         20/MDvQWC/f5QdY+Bsc1h9i46oHRlj/InKpWXqTBdiXhKrNMWZz5kWVVtwzctnDinV9k
         4/j3e4w4l7bz1ah5/fagQsmDtvgVkLSxJraAj+9nO+iCg3bkBQHhmoeZkdmvzo5f5oM6
         EsJg==
X-Gm-Message-State: AFuF++lP2X4SXOVlY2O7SHyQXfSBVsVTMHxfNmzmZJT1Um+MVaMgTDnk
	i7ZoOUbMGOCfVi3WF3qk57tEntEh0Hs+boCk3kBJEYum4KHburQrOO5+cMwx9w==
X-Gm-Gg: AR+sD112xxhiCWRcLWT+Y8/Wi1FI0uH91pdmiC11B8WjaTd9Yl/yxBg4GF1qU/s3cZK
	eoqb0oXoKbtkRlH/JydJfs1HOHcxNwo9AYqKxq/DARRdNrsZzlEjXGXq7vkEqZifaEl4YLlQ1Hr
	myjQLOhJeDNbq0papTcnZsHK9wah0Y85GLMi+iusPwFUw61zwtAMK58bekA0sf8p5U5IqyWxnpt
	d33T7xFH4eMSSde5QVkPNDP9pecYTl9Wf7Y4krNLk5hxutu/Zg9JVcWIa8PXouMmZEw4x6ycSTe
	Z6pN5KgQt4sjTJ6RwSAtxWGyySolIxweWBN55t4y4K0doZkFF4titydEduHfgs7eVWklz5wQBQw
	iapuIRZ7vepbVzPv367JiXPfWjYUsL/VVLrSoqZoIpMn/AGoyy6enGEOMO43xc36I8co7vR4WoR
	QQWg3x8YaC0NOrIvKwlIrPrtCMG4RheFKyN+vRQ2t/yvbT6cvKzfHpBGUyqnH4LEAR
X-Received: by 2002:a05:6a21:3315:b0:3c2:dcdd:a85a with SMTP id adf61e73a8af0-3d268be8edbmr13165772637.13.1787917877827;
        Fri, 28 Aug 2026 04:51:17 -0700 (PDT)
Received: from [172.17.0.2] ([57.154.6.100])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f95a847sm4494198eec.17.2026.08.28.04.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 04:51:17 -0700 (PDT)
Message-ID: <6a917635.b12cec6a.13c737.048b@mx.google.com>
Date: Fri, 28 Aug 2026 04:51:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5638388612255821442=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ravindra@intel.com
Subject: RE: [v1] Bluetooth: btintel_pcie: fix PM flow for S0ix, S3 and S4
In-Reply-To: <20260828095159.2370857-1-ravindra@intel.com>
References: <20260828095159.2370857-1-ravindra@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5638388612255821442==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btintel_pcie.h:536
error: drivers/bluetooth/btintel_pcie.h: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============5638388612255821442==--
