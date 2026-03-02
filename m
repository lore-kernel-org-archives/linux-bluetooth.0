Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396F7430BB9
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Mar 2026 03:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772423188; cv=none; b=l8BNQqtsErq+oQGRuk/NgI4PF/X5+gwuPsNz2T+c4sf8mqMuA2xpNsn5OKgPYxct5CugyXncraR1tNqfACH97cp53NaM2FqrfhUQrwZVFVzGFDcW6JinNXU4YqSCoZs+etJWmYiwnOSGkgNAqpIBgKLJYdHvBlXx0OcLhTQMoK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772423188; c=relaxed/simple;
	bh=GXZS2Q/pTVpOtbO0ZXoOR7gShzxat/Fffik+ipyqhnI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=sHQ3sPNSsXEKxG9A3qe6Jiinq7st0uOsJLKQoVveGM7CmOOuI/xWE/xMs22+mDlq7iUfamd9Bseye/Fp1Nz7mxgDf7ex8zJR8HsWVkNHslpYd7s6Yc4YLKfQPcXiQ8SsEb7iQtgU/ZT5Jhy0ltG/OB1EGavZM4Tlg0GoRugDJjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UUSQUYGb; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UUSQUYGb"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7d1872504cbso1614599a34.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 01 Mar 2026 19:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772423186; x=1773027986; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GXZS2Q/pTVpOtbO0ZXoOR7gShzxat/Fffik+ipyqhnI=;
        b=UUSQUYGbvslk1aOvjaV1JHRv2/qPI7FUjjm3+eLvfJnqZMMQm1p4eFfW5o9ICQ6/m6
         N0mCLqNVPtwwZk1GcZhZDSY5itelPsWvJ1kMVXNdj8LWj6SCuMZWi2C+JZGXvUZGGlPh
         NMRuFXKW/13X5DyAMd2O/WRo+KudaB+bsRbGd40Bpe7+tYLVRO0mCE/YRQAJ5F8obEvY
         VY3a88q9TSknLMo5ScAmbniOdVmevaalnIJ+RL9kWKkjzbOG/vBBSIU9H6rxxuDLGB6I
         hbkELArpTEdzrWqV+7Ql563iZQSWeY1LR4O6fV2xFo/PdNRO+AwrxQ0uX4rtaZtCNwEp
         X0Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772423186; x=1773027986;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GXZS2Q/pTVpOtbO0ZXoOR7gShzxat/Fffik+ipyqhnI=;
        b=qy/YrCIRCmqm0jZ1xqc1i6/fEw6YH5Q1yrRS0e8OWHN/OaGCR3ODTsGogxTS95SQhj
         XWzhdTGnHRVf8Ir7P/mUF58EwpUCGFLvdb1/sat/joqjBhcv5yGM1WUvfAk95jQJpmau
         7nqyGhNCJuW5g9GsSciw93aeOMf/vzABocw/d6CkRHWiPvHxk8pqMuvJ7anneFp50/BM
         r39yvDY54a0DoB4Qqj3bm0mYKpHWAS/xU6Mii22axjeyp2Vr3f6FoDR76piIrsj20zEn
         DhnVoM1NZUTlm5VLOeMIoN8AcJOGPrHp07xglu8eeppArTpqbg/FshuT84ffj3rLg8I1
         jOOA==
X-Gm-Message-State: AOJu0YzlvyekvmSTVl3IUU9LsZD86FAJXxK8Hy6iBf8Z59ZZ8IbgxfZ2
	FdYCfjxfKASJ8EXs5PLu4jxABSyoyVI7dzbbEexBxhkA4gsDF260Jbndbrarbg==
X-Gm-Gg: ATEYQzy81CBMlB0ZFWs0HtVlGy/oZlZ3xSpIoIuU/wOs3XgCqjgm2ySG79PiSCx2F25
	XcuHGes4PFt8oZObqnptthJEeWA3y3U/JFrBuPSoQg+qPFqs+BOItHdJYTEEGCVs6/Eg1SA2lJa
	dZWQz8W9LgL/cgoRni87QSpj/WL/pjOog3jY4as0T/B+n0dUrvqyI8Ds+UbBo+53pak1qkkfj4d
	t7C8w6rwMdOQeeg585VvqTK+XB9M417osPImqTxbNe0S9AfQexNjrOpVOgi72xw/2xdgwnbTN6v
	5JU5RQtphUQLEghzWhwUcgnijhBb/x2REOrNHZVJlvYMPrP4pkuZx/MaR81yFBES45XIkFn7nu+
	ECeeEeJKXBoRCXlIVYrbWaWX3S53g89wabRJL4hkVZVyt4ioElQaQGBzB3ZKPS6F+eSFOMqreJt
	tJ0a6fArFDjAOItKCgzSutqlTae2NIHCM=
X-Received: by 2002:a05:6830:6d56:b0:7d4:ba6d:e33b with SMTP id 46e09a7af769-7d591ec6874mr6829292a34.14.1772423185904;
        Sun, 01 Mar 2026 19:46:25 -0800 (PST)
Received: from [172.17.0.2] ([172.212.163.225])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d586653d8csm10763679a34.22.2026.03.01.19.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 19:46:25 -0800 (PST)
Message-ID: <69a50811.050a0220.2a65df.5626@mx.google.com>
Date: Sun, 01 Mar 2026 19:46:25 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6968468718248050859=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kaihsin.chung@synaptics.corp-partner.google.com
Subject: RE: Bluetooth: Add Vendor Chip Support
In-Reply-To: <CACrSQ4GigJ-41te+504D+dTRgC+46uwtjBQDuv4pY4LZ4Krpzg@mail.gmail.com>
References: <CACrSQ4GigJ-41te+504D+dTRgC+46uwtjBQDuv4pY4LZ4Krpzg@mail.gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6968468718248050859==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============6968468718248050859==--
