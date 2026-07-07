Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AE834CFC7
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jul 2026 22:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783464280; cv=none; b=k0ksF5BZ4xyVeTUemZJWXECj3awfEDrvxRdiLn/dLwxfzzHBBbF2aVrmuSjcji5b9tlZRlRDmpu6dz3hHSp+hHdksOW7FelvuVHtUBwoyJXBGT+SnvOe8kIt3XroyUymAJZrD/S4lkbNqYB/76E1xWrMb0aSRmsKQ7vdGOG1vJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783464280; c=relaxed/simple;
	bh=YJTS9W573vqhpmG8m926OPyKXeYYpG3coU4btuLKVWQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=uu6zV7yhQdKt8GM+QECMW1e4eoVau09BxXK2P+p2mAl89wI0J/P3OlJDZK/ITZAWXHKSo3WIjoahzbRYHDM7l/un1v/1bR66rgtVohR5SfKh5U6CQLRC1dU+IGZbm0d4MPM4XeDAwxjQoqXqPBoQym5IG4de2eKgiHEIAaS0Feg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZtRC3GaI; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZtRC3GaI"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-92e4fd65b2bso1036785a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jul 2026 15:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783464278; x=1784069078; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1E4YhVSEdRbKUM+veFcHVlCcJuc1k2pRA7yR2of1w6I=;
        b=ZtRC3GaI9xyO/37z/WcrZ/XdyWd8Eddt4ga0slnDDcHExYIX0aEE3gYKMVf9bC3VAK
         QXq0YqgHDMob3IHpFDUU2IYe2d7xCZ1ZIGQsfdwN9wzh0gPJuIXXGvbgY+owaoqvWhuq
         K1qNcQGdOGhH2EgUUkekETwjJOo+HGwia+0ihFWeQx72rcH/SyaGMlUjHZJHCVshLQN7
         KzwHexoKAAD+m7KSp/6ge1/8r2PTFcq5FIyQR4wbjgqRWe2x1A3is0GiSBapTZxxcPtO
         0qY/iJ1yILvTjo8RrIjWMVosopQQX/WpePbLDx2U2JHYJYkac54dTbozUoKaNUu058xW
         25gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783464278; x=1784069078;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1E4YhVSEdRbKUM+veFcHVlCcJuc1k2pRA7yR2of1w6I=;
        b=bsWqgG/QqkAS6qfn84qCWOQmkocgk3rDB95fv0/JQrMHI9ECx/fzRLzp98C1Eo02r6
         vTBLpqOQn6GaaaM6QHJQknpFcubWEsWf3tZ6/PcabJg9x/q4eaaZs8KlBCt7gsnSgSOM
         Uwm6Qm9MAzi7wSfJb/4P264U3D/DJneGXzBLjaRBJvrRlc4TxM203qMQqxUu1L68mHY+
         hHmXBMsH1wLvw/Iat+VX6o0Yxs87fWdE3R3TzA/tDC8lnztVh4Ar+CShhzudvGdOd+AS
         ef3mVfm089/SIKnGbHd8mpOhYncuUFvOp5sc5xMmxraEarcPrho4r2NEZ4WyLwInxoZz
         nGKQ==
X-Gm-Message-State: AOJu0YzVt039cTpGJMnpIQeq4R9dOYY8aXllx07VNxhOtSjWNY6yoHEC
	Qp9tarORPM37BuJ7jZqtQue4nEgwUx32yp4jrmWYqEr2DVFwsWRzNHW+QbrShf8q
X-Gm-Gg: AfdE7clJ5OuE7odmUK/PV9OZ8knIJL2Odi46ADeZClkJ3Pkc/449j1vzVgBjhUkWecx
	1lQTIlabbpNw0WLgovEvqrCoHTLteHTkxDQCmDE66iVN3gd+bS1i6iFEfFyCwsVRCegaURUboe+
	eH7I+SLY4qKSmWm27iNSJJdxSY6H4sYFAmj8UVpoFkjDYpDuZXpfla7dDrekKs+c+2V+9NtBPMO
	WY9gEOPNYHyBB2ZCejMYpuCdQ3d4/7PJizbhikqhe+/qw3mxOna9k280TMWzqkCrULImgQ+Y7m9
	HPt12iTJ3zFjg4l1PFMen15e7oUVomnsDqx1Jdddos9fn10rFoRpT7X/UROAHsnhzh/ym0UfzYV
	czF4L4dpK2/pa9TLnX6kbiBlCj6o9VhDMfUSxk7AjK8Zmup4OZIYvVvXBZ9dB0qcrFLiY53riNU
	ssiFwGIf+RFNMWNynTnko=
X-Received: by 2002:a05:620a:4009:b0:92e:72a4:f282 with SMTP id af79cd13be357-92ebb5532ffmr850103285a.46.1783464278302;
        Tue, 07 Jul 2026 15:44:38 -0700 (PDT)
Received: from [172.17.0.2] ([20.127.238.82])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90c92634sm1274361285a.27.2026.07.07.15.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 15:44:37 -0700 (PDT)
Message-ID: <6a4d8155.e0a65cc7.1b4b2d.96a4@mx.google.com>
Date: Tue, 07 Jul 2026 15:44:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6187387772245398005=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, playximik29@gmail.com
Subject: RE: Bluetooth: btusb: Add support for 1357:c123 Realtek 8852BE device
In-Reply-To: <20260707221549.27269-1-playximik29@gmail.com>
References: <20260707221549.27269-1-playximik29@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6187387772245398005==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1123385

---Test result---

Test Summary:
CheckPatch                    PASS      0.71 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.19 seconds
BuildKernel                   PASS      26.76 seconds
CheckAllWarning               PASS      29.29 seconds
CheckSparse                   PASS      28.14 seconds
BuildKernel32                 PASS      26.02 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      502.79 seconds
IncrementalBuild              PASS      26.23 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/408

---
Regards,
Linux Bluetooth


--===============6187387772245398005==--
