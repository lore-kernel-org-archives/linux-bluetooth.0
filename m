Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118353839AC
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 18:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789064535; cv=none; b=IVRS/2w7ZqjKS0kg3X6ZjZZUo+NTpMkpOS1+cUmV/ZWnxNzAU/FVDS3ceekPdW3nQm8jOzi4Z28LsTFDxkj1y/NPgKCIpHxSmGwja1zNBJ0TEjR390QSZnVaAUEspw0HQTncnsUD8xX9B6P6tevobQ9KB15XLJJxtaOSHEDETjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789064535; c=relaxed/simple;
	bh=usDB6fGgvWDttgd8O8rHRMLmapSrYi+wB0+GvouHHCA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=F+5gp1OxQ+L5OEQyiautK+qSwo+JqRiDULAGB7adG1SCJDFY1JqoflVT9unB9pe7bosBmGHn6QfegnyhpwE3dA/uEAZD7G6ZAZ6DJHQdU9/VqRdD/M1BrJUyGs0Y0YCpV4wqFiiNBYr51jEEI6va8Iwm0mKi4DYNrFPd+q4IqaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GSOV/FJy; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GSOV/FJy"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4b29fa803so113820a12.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 11:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789064533; x=1789669333; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HqraE/79BH9jGsFi2X2YMOwD53sTdx0LlxO5SrODc0c=;
        b=GSOV/FJyag8ecsiRM8H/+wCwlamf+RQOH0bho9ibEvqpyen3QT4bsWzphjeBPfyG1B
         i3ZfPAQ8/qheEioQ86pKdsOsj+buGPFPJpF9N/9seJ7uhKYb4Hngwn+ZK75W94iXFIw8
         ktz/HIENIyCGz49JQAEnKQVtDfwVqz861N1aXxhDvDnrk1BgYYZ1itOVlCecMm5pICjC
         98tGGRzSm2el9mavjfECfRExedl7DwcJRLPuuRaXShpkBMy7qwUeA4l1xP7XYUb/Uc+/
         cFJIc93T70VRc4uZa5WZVEVri5ikbDfBVWQmu9yaIeJk8GyaLr8sV+gZsAQF45Rp1vdY
         ssZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789064533; x=1789669333;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HqraE/79BH9jGsFi2X2YMOwD53sTdx0LlxO5SrODc0c=;
        b=Atq511JI30sRfRxrGHeDzV4GKSFGLSr+YRrNI1Dsg2n4zHxaiswPGyVOcoZQgZyDFt
         EaNkZab7eFZoh+Ja0hW4EdbdM6NloSNiNMnw09FXuFjMKpS3EQddNWkyLQUQS+u4OcU3
         QYI1K0NsuPFx0jaKUpEwevnVncMzntH/LDiVH3FDPsdes8RmtP/QLaArHPL72ojLYcFT
         H07fb2LT+6C0gZRI9vvOM82ppW/lhNZonTOOnQJyHIsy/PlZ/hXFzTVghuZcJaXKkgNB
         4/4mR5fOixrlBXSdcqdnsYJWhKuDx0c/JyyhN9vZKjquAezYhVZJbNpMlrVkTlfV5Ltg
         CF3w==
X-Gm-Message-State: AFuF++nbqIql3KgJLn0n8VrCrMhgJEwZp0Em8FYa8VoX2e5njIDG8VsC
	5ar4G/Bbc+qxQHoT4bO7WDN8MNzaACnYVeoLArh4t4qXaONFdZ2QjTkaWgPAFw==
X-Gm-Gg: AYBFou0Ava1/LNtDJi3NBJMS9DlUrKA2jkcUrup5cEvZ+QbwN4WGTo3M9sHzY8ih4HB
	p7qJ2Ihcd+5rG8uYmkguQ3a4GLZdxHxB8wFT5KEqKzIErLIXNeVDbdBsnPPMpyKfidVPsLafYPD
	//XYj89myL9GYbWtsdbeZs1NR8i8vzDrtubmbItd7gdK/ooQ1sk7mhmFpKCGbalZd+3jbxMDOU7
	8NMiq0Y6gUgR+dlHItiqH/aEv8i+xgvSc/KFcVGVA2IXVD3R5BFXShEefJV/rINuwjOH+YScf6n
	Nu17WDMfbE9+G33CctspwX/mcrrvZKKjL/H2hWIEQN3vDpU6Iuy2SNsT1nbXPKYi+QrqbGKJq4E
	Cu9kvjEei4ZdygLgVMh13YYCbHgXNsZSnVc/Bcr7jamRI/EXjKQJ7qROe+HHVppejdDeV3cuhkI
	uqR0g0WK+LZTT6+sCAdQNIeq8ZOYXWzyk76F7PzyzJX673Sy1tLqC1aMbJdy5D77rX8K2sTDnPh
	8Dpig==
X-Received: by 2002:a05:6a21:699:b0:3c3:7179:a640 with SMTP id adf61e73a8af0-3daed0ff231mr281443637.3.1789064533190;
        Thu, 10 Sep 2026 11:22:13 -0700 (PDT)
Received: from [172.17.0.2] ([20.169.93.185])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3397c13dfb1sm17642233eec.2.2026.09.10.11.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 11:22:12 -0700 (PDT)
Message-ID: <6aa2f554.5fdb137c.2d781.4bb7@mx.google.com>
Date: Thu, 10 Sep 2026 11:22:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4774865183275830340=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: mgmt/device: report link security level to D-Bus clients
In-Reply-To: <20260821090908.1546451-2-frederic.danis@collabora.com>
References: <20260821090908.1546451-2-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4774865183275830340==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1149614/

---Test result---

Test Summary:
CheckPatch                    PASS      2.01 seconds
GitLint                       PASS      1.29 seconds
BuildEll                      PASS      16.26 seconds
BluezMake                     PASS      254.02 seconds
MakeCheck                     PASS      13.03 seconds
MakeDistcheck                 PASS      108.56 seconds
CheckValgrind                 PASS      182.47 seconds
CheckSmatch                   WARNING   190.51 seconds
bluezmakeextell               PASS      72.16 seconds
IncrementalBuild              PASS      308.47 seconds
ScanBuild                     PASS      729.57 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c:2004:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3924:52: warning: array of flexible structuresmonitor/bt.h:3912:40: warning: array of flexible structures


https://github.com/bluez/bluez/pull/2513

---
Regards,
Linux Bluetooth


--===============4774865183275830340==--
