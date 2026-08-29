Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44DA2E764D
	for <linux-bluetooth@vger.kernel.org>; Sat, 29 Aug 2026 10:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788000641; cv=none; b=U6H09WQg1q8KpNmI5RXfS5mCwo6h4TnxNdr6P94kSfhrHK98okLxb1bS3WvETX2D1mDg/eZYqWZqTkAfya3s7F0G3FypsiHDDKYb9wIZ2D31/HHaDCp6pbAzDFywHTvGSqNQpOkMgtsUB+Pa3fEh+F949+dIu/CBjNUlZqSn6Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788000641; c=relaxed/simple;
	bh=b93YUtOXBFD1G5XeEOQHydBuN2hPmpryx12G709Zuf8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ORdlCM7bUrBCYRz+ul9Dmbk1KqbJzndudGi7nZn2Er5SQRPKz24ReTMtv/ZTWXQsRDlaiEA26DUenGlxQgOSdmeiPEj2BKFXKb3/kDEAAzjeDnW94m383jPJ/gWEfTgeVAZ6s7G/XMT5C79Jw7tUR4XSGuxpQxeMVo/wfK27WC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePY/DfqU; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePY/DfqU"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-52f83889a93so18101541cf.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 29 Aug 2026 03:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788000638; x=1788605438; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=m9eZkVtBmWM12K3iXNaI4ZME+LzmSuhrzGoPIzGxzpI=;
        b=ePY/DfqUqqXJd+nNkQyLOLww60MRbVyUrXrCFcqvNANiDU2SmpVgp3oAq3J7tji0tx
         CBR2KzZFDcSGiJ4ERwGnuMJnAo5zZI3A1ORtyo0YWy/u5gPbJEOS+jkO1uBsdKrfbIku
         ifgsvlERd5VpdoQzVapc9euQKKwHfcpm/w0edn8QkDwvI6YJdAofP89oVGo7prT73T/3
         35e8XKk1IKS0fMRI5rfuS5kqBFaLfoosAgc5aIeiFOhLTpcMKppTbt/ln2Kstme9cs5b
         3JJVJTzOTvNZNIHWDM4Qzh/XRosl/AhpUIwjSlsD7oyLK6M8IFg2wD2SixTm1j6YmMcp
         rCQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788000638; x=1788605438;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=m9eZkVtBmWM12K3iXNaI4ZME+LzmSuhrzGoPIzGxzpI=;
        b=tXq/ciHgQuP0RyXooDkGlbjDXXVYRoiUuhWdKac5on2dfjGIVfhQbCd5Fjarmwr7FD
         qvSZ8CoKOVRMhFAssQkZo1sNhKPJnx1IaZOGx4aVi1kb1eH+nZYHYT690jEWJ9TVJzgL
         lESVzCBx57kCcvsC5UrBTaI7nMmfvE5KTES5ZidDAG+K0upiwp63pymiVWhlBUdFlXR+
         tQL6Fgqd/A/DVZS74sCbNviwIxIZWbPjNl3BBNiUCmLMz/G8nJ1bMcIYaKpjBVkwAdry
         Jj0VZV+/Zxhi9fiovf5wiy8R3UqJFBORYADcVmn4gXDFWsl7DlAKhOwt0otRjH0efAbZ
         LXkA==
X-Gm-Message-State: AFuF++nyFxowevYQhimA3sVxn/r8ERJ5IDYccYpa/Y64GXtGKKeUG7my
	4trhSXErbIbecyOqE0Hv9GC73FzdB0eeRrFW2ZJT8xQCNJTKKTmuB2GszmVDDg==
X-Gm-Gg: AR+sD11wklim9OfIZpGkKYhlbI6GULgXNQYhowBzFwUtSZ1AMtaX5B/4qKvD7Bu5tNd
	QBs7Yatt3SYEmw5ccAuAfv2UHhU6GOpRYY7o7sGRcQanyKf/Sxbx6rX2x/BkWApGxljQrjZm1Ft
	NWGahCIYHg0t1AKlTd+nIVtYk9382mX6br+Bgr/9vZrpPbPeqO+49JgCkHyc/C5jPkIDdoUaC+X
	AjWBEzeI95zn29MM51nakznqR/lrY5cvGV0XLdJaJFhPh2rutZccJINBkyeHt3RLwkK/QvCmYof
	gtmmURWLiqPafNpikCNaRLMqpsDeeCj58tEOpfnwK3lRBTvCqNBUL2QbpkiUnR6drxC/RXnswFx
	Em+3p5gDxSUOS2VG3upnPZeK8LXIH7uSMShDvc6d/1VGuJ5WP7dDWzITdtEiMLxmFCZ/iiLkMLy
	LarC9P8se9nq8TkFsa+neyBzRxVNkm7eBKRSndJ4L8sF+m/hsaaDqFZEU7ocViQvOFZPA=
X-Received: by 2002:a05:622a:58c9:b0:52e:8ef:5960 with SMTP id d75a77b69052e-52fb965cdf5mr179821401cf.33.1788000638563;
        Sat, 29 Aug 2026 03:50:38 -0700 (PDT)
Received: from [172.17.0.2] ([145.132.99.99])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90ceaf94d8dsm21127996d6.1.2026.08.29.03.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 03:50:38 -0700 (PDT)
Message-ID: <6a92b97e.9c49f9ea.26385.c448@mx.google.com>
Date: Sat, 29 Aug 2026 03:50:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4543706383621626115=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, paul@crapouillou.net
Subject: RE: Bluetooth: hci_bcm: Default to 4 Mbps
In-Reply-To: <20260829100205.113655-1-paul@crapouillou.net>
References: <20260829100205.113655-1-paul@crapouillou.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4543706383621626115==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1153580

---Test result---

Test Summary:
CheckPatch                    PASS      0.98 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       PASS      0.45 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      25.20 seconds
CheckAllWarning               PASS      28.30 seconds
CheckSparse                   PASS      27.21 seconds
BuildKernel32                 PASS      24.78 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      459.99 seconds
IncrementalBuild              PASS      23.99 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/663

---
Regards,
Linux Bluetooth


--===============4543706383621626115==--
