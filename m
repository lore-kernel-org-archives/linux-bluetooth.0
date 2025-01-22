Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4D51DFE1
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jan 2025 12:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737549052; cv=none; b=Mf32OxudWNbuBLLQzQtCLT+L6BsXTkknfAbKUNtw5orWCCSz9eV3dEbWwNieku5TdFyTM1HHu/T+ykWzuPGHJFt2CwkxCZKo9ISBthBwS9k3EHAWrPr3gSTZ1mYJc7bShLODMIFc0BvhqBw0kgRVAPBz9otbcqWeE2Ow2HZNbEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737549052; c=relaxed/simple;
	bh=LCHWDlDEYrmT2GZXi8o0HWD4u9xRwNLlaYZk2g588oQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=DGzl1cPCAcx6Ofe39lbQFBo/VlCRDBLOmY1q91HizacCFy15f/GOKTz539O22uEUR7o/qmcZxPs1mVS6fVSK/YPrsVsVRmo7xXfadUF1/RnPiQB84fcBf8E7CHQ01DOZA7FVHy3yn4Y7E55ZUlDqMpbxQdn7M520WK0Yl2YYXCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jnswHV7Y; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnswHV7Y"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4679d366adeso7669771cf.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jan 2025 04:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737549049; x=1738153849; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qzGn7q4M9B5dDCtY7n5+1ZWxCV/5qmcPArDBh3C3YxA=;
        b=jnswHV7YnkNwDHzDQk5+VgIeGsa136FOvm7LiNj2iE+GHlptozdncYUxUHNDbfc4hr
         UFvIj9eKJmtFGgMYUszY41toVrdEvX1T54HPi/RuydDBp7tjxqKfn42BVQiZqDn6PO+d
         qHIVsw44isx5LyFQBMTD+0ViKN1ysLzZvTgvKNleizgeXrQeXgK4U10cHB4f1+XnjjHz
         /sSlyZ51Odqyr3MvbH9tbZ0dBb+tfBr2E4ZFNBOJo026nUIG4WVAtXN+PNv/1sfjqKgp
         Lkna9A+p8uZeXYZBe/8EBKEYfmTt3/hsPC4yd2WT9j6z025OLSf3PALA9rdmqi693SRO
         2Abw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737549049; x=1738153849;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qzGn7q4M9B5dDCtY7n5+1ZWxCV/5qmcPArDBh3C3YxA=;
        b=cKQ5Zf20j4fQweIW96RaRmUEcuJoCqrDfs6JQy4LEv/qGvWyWcMvhEheigL0GyVAMQ
         yf/dMCk0r7hPc0qielwrJ5YHMhIoBeGaIw6mQPXzQI1HCN1UKNWbRCiQzA9Dq74v+I4a
         cFlohW03/UFfQveN0AllKebnnYALXTIEwyTmn3qrNeXenGN01J4wNhCZp8xaOtKPSEux
         4CkBhPB8lhX84EM3L7WyyynaSmrRHE3NjmMiKVSHDaOFCzpSktYf+y7nofVHxemR+BuV
         KQy/xT9Fa3iY8pcfQsweEgkRUuVj5Jt7oPoURFWSDCr1jwbOFuNL6r0V3ry02F3heOcP
         dKbg==
X-Gm-Message-State: AOJu0YxzHbHRlezLSKPsWsidb3QBpt3t5S4E/pKE8ke8ujyhdC2gv32t
	uISSj5ygj2BilqdgJgQrmeg6Gll7Qt6wTst8R+bAWpz4qty1XqkVD0k+Og==
X-Gm-Gg: ASbGnctO8MvhABKI1xjX6MrDMesT24enz5PY95zvPOdHid/DG+sIDNPtT8BtPcrfMy3
	F5yOpLKcIdbdagFZnTgtaltjQ95DYCKaYdpe/dGOo8hkABQsARonDXUe5FFqlzY+GLw2+W2liR5
	v1yN1vvt9ZR73ehB9BTIUiZTKbH/JPP9YXP0tGZTRNaq2wL+KZLLZjWPInDSuOKuEB47UAhjZAs
	yja4YAKcz79pXxOaVwz9lf/jWIYd+uvTdK5rsqY0EvYH7nr6NEen/oOwDD8qbtsi6Gtm8eaNA==
X-Google-Smtp-Source: AGHT+IHFfSXTu+ju3AW6rrOtCQA4ljnZtVtYbtFBi0VEUTOS4jkmXsst/Cg7lTYJQARJM/KyjlaxGw==
X-Received: by 2002:ac8:5d04:0:b0:467:60da:12ad with SMTP id d75a77b69052e-46e12d891d7mr298682531cf.5.1737549049412;
        Wed, 22 Jan 2025 04:30:49 -0800 (PST)
Received: from [172.17.0.2] ([20.55.47.26])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46e1030e930sm63251401cf.38.2025.01.22.04.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 04:30:49 -0800 (PST)
Message-ID: <6790e4f9.050a0220.31825b.8ffb@mx.google.com>
Date: Wed, 22 Jan 2025 04:30:49 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1474131149465965488=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: device: Better "Connect" debug
In-Reply-To: <20250122113256.1107629-2-hadess@hadess.net>
References: <20250122113256.1107629-2-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1474131149465965488==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=927506

---Test result---

Test Summary:
CheckPatch                    PENDING   0.22 seconds
GitLint                       PENDING   0.20 seconds
BuildEll                      PASS      20.35 seconds
BluezMake                     PASS      1541.57 seconds
MakeCheck                     PASS      13.32 seconds
MakeDistcheck                 PASS      159.16 seconds
CheckValgrind                 PASS      214.70 seconds
CheckSmatch                   PASS      270.60 seconds
bluezmakeextell               PASS      98.24 seconds
IncrementalBuild              PENDING   0.25 seconds
ScanBuild                     PASS      858.86 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1474131149465965488==--
