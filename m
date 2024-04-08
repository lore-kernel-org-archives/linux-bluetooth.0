Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54DD148854
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Apr 2024 22:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712614455; cv=none; b=WqDds9doja9Au2IWs34TC4tKQ+co7cRlEPn4RND2ZrJR65EakK3JCyOtGs0J9dR7jRrrCkwbMGmXS0igJZnyjw1X7tnoYrv84nE+lw0KT5kIsaslz9Ve4yERmP6fPOc3Py9r/6RtAgMhpkbpmJgURt2yvcc4f8qOoNJwdyo49Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712614455; c=relaxed/simple;
	bh=V4d/0p72Qy+1FbjeF+2lCNfgl2T60vtlOWdxWZ+v7O8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=mktYytfiiejtqG/YCUHHcU9JtKnzbqxe4mxWeHXz1MZrEA0cVI6BTXJFPSEZv6TXcWxyPfWeuLdve0EwMU6rGHvOpNoyiOVK9GuKftd8SqdrZks82KYk/AWLlcHaC2Pzg/hbZKIhOT0GVe5qh/rAgmasxgbwXNWYWQxCwhHjBrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PFk/RQjK; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFk/RQjK"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e3f17c64daso13955655ad.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Apr 2024 15:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712614453; x=1713219253; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=V4d/0p72Qy+1FbjeF+2lCNfgl2T60vtlOWdxWZ+v7O8=;
        b=PFk/RQjK4W/NIG2A9WhpRbwCCOu34m7SI1fLOOiEBSrSn4JLZODKWFx8M9nhP35Cb4
         E1ICfkCx8XObOEkbzLko1T1oOdF0hOc/o01xsybmB2Ch0anjSEITtXDax/YXF5EdDNkk
         gNICtE01x+KONjS3QMYmdHde9EE30OaGQyx0v6eSP7m6gc8nSrdW7iMV9ckKRGJtYkmD
         f29lOdl+Nj6+3GcRuiyBCRPY2gumkV4dZGUIBZExPGvGgx1u9uITohBgoJqn9MHb2SUi
         3riGOmTrQxOCqngqxnt9DzKk/P8qZSllLhiIpbm00FNBVuUhT4d87QX48n1lmCMMtIm3
         /g2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712614453; x=1713219253;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V4d/0p72Qy+1FbjeF+2lCNfgl2T60vtlOWdxWZ+v7O8=;
        b=qS2C6X+HhIvNjTbej7knbZlPsBHf4jlo0i3nv6vsF2RbsYcgqCA53+mlmuPKry1OgU
         y9xS/TzW00ZzNR3cfq0Gnt9avfr430305+faipTvXGZivyFtbOU5kzeP2VdUPSLIxf53
         icVV1dQziq8dZzCa1ukD1zJ1+Cq/tXZQFy7B3EVs0EMCZ5+CRtZrOxuxOKw0PlPC72gE
         TREM17m4bqml1ySLVNz5ncRCawSh/cNsRVAX6GAz0BNToQEQdOs8ywAbB00B3zmtLkk6
         V/1tyy70EDTFsWUPtBNTJ/Y8F4A1zHwBTdD9yfYzfcSaoU+NuPhdhy8FlQE5JRixGXD5
         48bA==
X-Gm-Message-State: AOJu0Yy97JK20q4MOjzAoC1MIVHjdhbVy0xXjAMsDJ7hbV1bMmhnxTO7
	CUtfBYFUTP7O8rWDAjf+N2TbThrr/BD7/FyApziU9anQudK29vkdRNNR2E31
X-Google-Smtp-Source: AGHT+IHJ3ujxTp6oV2dplVPVvUHofx1pLPN2hYk9nzCQH6/1Xy5bCFgI/jbkCSpMKxaU3PcXEgGZIg==
X-Received: by 2002:a17:902:d4c7:b0:1e3:e64e:e62c with SMTP id o7-20020a170902d4c700b001e3e64ee62cmr5696711plg.18.1712614452725;
        Mon, 08 Apr 2024 15:14:12 -0700 (PDT)
Received: from [172.17.0.2] ([13.88.99.131])
        by smtp.gmail.com with ESMTPSA id p16-20020a170902e75000b001e3c77db2aesm6985141plf.88.2024.04.08.15.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 15:14:12 -0700 (PDT)
Message-ID: <66146c34.170a0220.260ff.1d4c@mx.google.com>
Date: Mon, 08 Apr 2024 15:14:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0813027410966362241=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] shared/gatt-db: Fix gatt_db_service_insert_characteristic
In-Reply-To: <20240408214236.3758202-1-luiz.dentz@gmail.com>
References: <20240408214236.3758202-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0813027410966362241==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: monitor/att.c:506
error: monitor/att.c: patch does not apply
error: patch failed: src/gatt-database.c:3352
error: src/gatt-database.c: patch does not apply
error: patch failed: src/settings.c:125
error: src/settings.c: patch does not apply
error: patch failed: src/shared/gatt-client.c:735
error: src/shared/gatt-client.c: patch does not apply
error: patch failed: src/shared/gatt-db.c:825
error: src/shared/gatt-db.c: patch does not apply
error: patch failed: src/shared/gatt-db.h:63
error: src/shared/gatt-db.h: patch does not apply
error: patch failed: unit/test-gatt.c:1237
error: unit/test-gatt.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============0813027410966362241==--
