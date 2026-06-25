Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7BB3CF699
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jun 2026 10:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782382581; cv=none; b=t6YQL+vUSKpaP+Su90V0NHGWBuALDmip0TU1fh2xOjoxI6bZYuGSzioDaepu7g8PiwMo6VJjz5BeOhjA3WJBg/cRzRl2prpejF3ReB1mZgTh2476NEh3Dq36lKgqUxTO6eM+30C0ZkfilMIFogJHja7P9PvE/S7AIy2yXMbjLs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782382581; c=relaxed/simple;
	bh=G7yM2OYrX4GfdsaIhwSxiyuPighG69ZvG1g4uIRccGs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=X3GlYR5E1PeujGLg9eXWbQcQiONfn0GXdMiO44l8Oum6FesKaLUX6yXUWpP06l/qQHsUZ0/S/SCyelZ+/uD+M42XaPTx4IjVx031q1lCZZWYK4CZP2U/+m45YRFqgYBq3iWQcm5raOVJqmOO/w9BB+gYEftlXCPFdU+MGWViWNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nDzh2hZJ; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDzh2hZJ"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-139a71baa35so5501679c88.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jun 2026 03:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782382579; x=1782987379; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=z9XYR4mGBZ+1KtOqpOUYIQ0iu39OEaM4PkxxNBKTqh4=;
        b=nDzh2hZJYyysSelk5fFbEo5wmw5eRKfSicQnVPbGTWRWe4pjiUo52V3cHGDYsCfYsF
         TeQAKoeIOf9TJeXYzHZ+xMhH7Rr2ZialxGGdf5GmSqimSrErzITWvOamVuZN0z7oV5eX
         wBkat8w3rUl0XYlNAZH47sZNkzcoVCSBnDlLAwnhDiu1Az+JjflzRIpMrvIYXxiwKD1P
         9StPolTzHx6NLL12juPaJLxrXBPpZoYjdwYyd+tqzngb7C/uVooztJxs+8b28ymFh+Sh
         wpGegP3MMWmdiM4vCtzyZnHzDifhXPzFEPw3kLXWbi7hS1hsvL1FklVBUMNjkJPNZJJE
         X7Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782382579; x=1782987379;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9XYR4mGBZ+1KtOqpOUYIQ0iu39OEaM4PkxxNBKTqh4=;
        b=qVFPbxH9yHtaFY/pFotNNUYePiyPav5NsbRqHOFrTa0w87AQiyzm8hae/vPjzaofBz
         UwFOaN+sTJs7Vg28E5KsCPCRj8u/hqpZKeYHqUmO7XnmHCkQCNHRERIdrGQ4qexicrJU
         magq4BrZ1G04huqkQh06XdaikoNCqQdVLNUL2m/jP2OAhJxspVaj4wmmzS5NpHUZW1xS
         j+nEPueWTccKAsgSdVMp/lJT3ReesYwPUdzeqktbe8VZxYuXlGKzUyGYxxZSj/mLF7/S
         UtfpSlnDFtOf2rT0tKqEYHHY5QipTuTrIysStbsxI3UK/+Vd2fZqJA1u2y3a3+6Pai6D
         dkww==
X-Gm-Message-State: AOJu0YzSRIqRyDOcM+QSmhVnTzmsbRb6qmpAnUv3IczOTD4/FPXKWCVN
	ccRTxBUvu3md/LYbGNJ8RrfjZofk+fcCILd46AuELqZP9BKFL7aWkAn7W1Itdw==
X-Gm-Gg: AfdE7clW6RDbn2JDyaRTsmZB1otCJ1etTPS6SmqPR5OPKaUrtKbGuWz8TH/4PVq+4WB
	r21srpfS2CSuHBrx9ahDioyPb4QTgaJXD+KUFLu3N05q3ngDNvWvfgZvmTProAiUfIsbcprGi3u
	7+i8fj6lsdx4E7NuOmF6u/aRXh3UO3tUjIcLgcspax1cAfD+GpGaZg+4lxgPiwITHPvtHyPLzlc
	hWSaqi6aX2eWh0IBP9ih+OqgsN73pUDKgN/8tXn0f6HiaNbBm5krFPB4KjIOoW9Zl2xmZHMkqv0
	P8uzfHQ7ZyPQYanaFbsXE9otmSR7LyVdKJ4+XUpj/1sxSyUsmTL9Km5yqcztHh/A9d2ZzcxPme8
	Uux91XXeXTLVDVNsA4LegVyKsEL6Cgu6vnd07vy6vBlOL5He/L7KmqIZ2TLDKsBba5R2icDgjjB
	8/SS8/QWqM9YfjWu/hsKDp
X-Received: by 2002:a05:7022:788:b0:139:cca6:54e1 with SMTP id a92af1059eb24-139db9edd46mr1748811c88.8.1782382579082;
        Thu, 25 Jun 2026 03:16:19 -0700 (PDT)
Received: from [172.17.0.2] ([128.24.160.228])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139d90e971dsm10494485c88.10.2026.06.25.03.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 03:16:18 -0700 (PDT)
Message-ID: <6a3cfff2.f399dad6.73579.f28d@mx.google.com>
Date: Thu, 25 Jun 2026 03:16:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2328976748369125495=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, monesss315@gmail.com
Subject: RE: [v2] Bluetooth: btusb: Add USB ID 13d3:3625 for MediaTek MT7922
In-Reply-To: <20260625083230.300651-1-monesss315@gmail.com>
References: <20260625083230.300651-1-monesss315@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2328976748369125495==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1116370

---Test result---

Test Summary:
CheckPatch                    PASS      1.08 seconds
VerifyFixes                   PASS      0.27 seconds
VerifySignedoff               PASS      0.21 seconds
GitLint                       FAIL      0.52 seconds
SubjectPrefix                 PASS      0.24 seconds
BuildKernel                   PASS      27.04 seconds
CheckAllWarning               PASS      29.69 seconds
CheckSparse                   PASS      29.46 seconds
BuildKernel32                 PASS      26.30 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      500.16 seconds
IncrementalBuild              PASS      25.76 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2] Bluetooth: btusb: Add USB ID 13d3:3625 for MediaTek MT7922

63: B1 Line exceeds max length (82>80): "    - Add /sys/kernel/debug/usb/devices output to the commit message (Paul Menzel)"
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/351

---
Regards,
Linux Bluetooth


--===============2328976748369125495==--
