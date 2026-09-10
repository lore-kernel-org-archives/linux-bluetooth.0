Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58FD370AEB
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 19:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789066914; cv=none; b=o5NsWq8Sq9gsZYddwrtjLT/HERK0L0e0Vrt7B2/ME8izOp/3wKVEyLXxsYG3/dOsDC8MRc6MLP+O2ni9YBwUuo10vTWW1dhr6WZntj2ZqdTJ1LkwdsyH10pIx2/oO9WlT4wWPWPfl6AKuSogwlsjkSzCyKnyipO9gsXyvRbphIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789066914; c=relaxed/simple;
	bh=4sQK23tqrKyjQHJ3wjpAUI+I8H53d9ZGRpFv+IQKmXE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=iyR+AGS/8O8k3W4NslR0fqEbbQee8OGn+NgqX/dYMDZgC0MAKXHgm9ztTPQCtWjun6tHopc0eqZhQzlBA66ItPLOnqgT5P117zzSw+x7kkaZZrDqYtgB8Fqczd83IPCzI1ABDWBrFgbwtllsjWcZNPfqxtgWdz56Bg0gc/7LQuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GLqERE+w; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLqERE+w"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-78a338fe106so940349137.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 12:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789066911; x=1789671711; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cRs9IMsjVYx3KcuYhFXNCcuNP0qarzYWZ+68p637wNs=;
        b=GLqERE+wCSDtlKA06Rj9inDYI4LNUYGDMzX5DaMYtsynPEuEmvYGz+zUQqxJ3fdc2O
         /ovqLYJoYveYAug9X/k0DQrqAZxJBPRgNzDXbL32WRfcP1eWZpCBr1Zk5GMzLFL6qjuQ
         4EQ8a0iOikwUCWlATQWPRJqxxjZBR9TxXdicvYStKLDeeKCtHje4fFdz1w3JcInw/PjH
         peWJY0WVSohg3uxhpHA2rIpt3jNhEO2nM9tQzAdCUbT1ZunbiTf7YI7pq1W39wQiC9v8
         HdysF3dT13/+d+o45El4IyW9pHk3cV955Mwhgz3wxjVaEoxH/LlOaS0q5bZVmd3cTlCf
         9/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789066911; x=1789671711;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cRs9IMsjVYx3KcuYhFXNCcuNP0qarzYWZ+68p637wNs=;
        b=LUg3z8eMlkOkihGP6HKMJ963CMLSC7t6dsua/4NkdWbCg5vRbVSlgAHawgis8yYfQl
         qy7oQBsk7AMARqX8vfhjZcjIwSqDUZrkEnBLpskYwxjDosyFzJawwViR3Pz5KTSRfhje
         8gpYFF2xyIqLqJZ/LdYkF8hknXA5TZRcTp2OIrcVTHta1zPLfxniv05LyyPjhQbQdVZJ
         s8SitFefTZSH5pyg9bHqxQ27Cz0bAFNNNKHRRKv9bZVOYL2rtu43Uw5DdhwjRX68ijlx
         QglIsQ8ZUhxxNsGwRuFpX9vmlheVPZUQCjxanwmYIZXFrHUAovdm1A80GJgItBRiAG1V
         Op3A==
X-Gm-Message-State: AFuF++nJZuAgeu3Ls23RxpfyE5FU8u5c3q/BqeWG5Lt0LSVJBI4B4R91
	N+9Xadt56ZauXZg3FlHUckBFsaCDUjvrkrGj9PFzovi0UFFbpn+lHeXmH2yOCA==
X-Gm-Gg: AYBFou2nfRR8eBu4N1iechJHU76Ftjto2llKSMAqMaKxQUsr3EBTo6jTHh7H++OnWo8
	fQiGip70NxohfGkB7XInxk6D/O7/HI0MuZMqu3UwoJpfOztoMCMnlX7ZRlL+0Ue4qVTNTTGE6ik
	TKm/+/ZVik4AWlbH+CXz/5xygHYl/z9X5nlV98Kijp8FU4Cb3sAvw2LBWBIUtReOnfkfW3uMuqf
	AzpGP4LVfAVchpA6wgZgnWZwpf5vDO0t2zT7IyoUIkF9REfBgXon0xygYDgMueziGiwZTTzfRYW
	a675eYfvK/xUpsQ1fj1ac1GWzIwM0udJ/AJKvy5Iuf1rJb82R04ECJcU6zR19Yk7qBwyb4IeIFi
	0jPDCdeTWZ+Jhcu3Or005iY369urjnlTO88rrPNGuOi7C50DlP+xfz5XhMiKsI3aqznc+SK5n5E
	fGYmBS3n8ruIBPnC6tGwnoUt5byc5JbG8TJHaTiX9z+ajLSZkFKrNVBa3MnHrr4QeXTVYsaZWMg
	B8m9aqs5rHUKpXM
X-Received: by 2002:a05:6102:4a9:b0:780:c9c:bfcd with SMTP id ada2fe7eead31-790dafc2f9cmr2599412137.17.1789066910613;
        Thu, 10 Sep 2026 12:01:50 -0700 (PDT)
Received: from [172.17.0.2] ([4.236.173.166])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f5e880csm2567426d6.49.2026.09.10.12.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 12:01:50 -0700 (PDT)
Message-ID: <6aa2fe9e.8bd82347.209d6f.7ab8@mx.google.com>
Date: Thu, 10 Sep 2026 12:01:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3669963032093880721=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, rudi@heitbaum.com
Subject: RE: Bluetooth: btsdio: Do not bind to non-removable BCM4359
In-Reply-To: <aous3PktDH5KVAZ5@0d3a7a881997>
References: <aous3PktDH5KVAZ5@0d3a7a881997>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3669963032093880721==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1150561/

---Test result---

Test Summary:
CheckPatch                    PASS      0.70 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.25 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      28.41 seconds
CheckAllWarning               PASS      32.59 seconds
CheckSparse                   PASS      35.38 seconds
BuildKernel32                 PASS      28.94 seconds
CheckKernelLLVM               PASS      32.63 seconds
TestRunnerSetup               PASS      791.04 seconds
IncrementalBuild              PASS      26.87 seconds



https://github.com/bluez/bluetooth-next/pull/742

---
Regards,
Linux Bluetooth


--===============3669963032093880721==--
