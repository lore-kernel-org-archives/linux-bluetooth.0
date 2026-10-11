Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B19C8D9
	for <linux-bluetooth@vger.kernel.org>; Sun, 11 Oct 2026 01:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791681604; cv=none; b=GnG5zydbIj7myEO2UlO+Na5yCkDmdXUQ6iR4WBq3v+yXz+vDsmfYYbq+tJHojxjhlcfP5VhXVsIm6yPhO5ovdAafpBh+qL7fsAuYOBujJr9f6nVeutuYZbUX1M5+ufhJsxd3WEy/MvlYVgyqiAGWMF619s4GIH3ccFiHD3cp4Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791681604; c=relaxed/simple;
	bh=lVhsNDvfEtDIsk5M9LEecp0jAxllyO8F010pQ5u/KeQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=NdQKg79zPPTWlKsrDvu/8yzFhWnqWxX09xlFl/I1tGLeyAAeDECPZzT9QW6TP19GxlwdRjexf8EUumkzeMcQIAuKbUCXwKZ1Onrs9l+vALjOC+i9Lpnx67WWC5Y24sIVMBimHEBEXUSHwc55nw+mb8vYnkz7bEyDaxvjt3mx87g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pDELqtJG; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pDELqtJG"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-354ba08cfd1so1548685eec.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 10 Oct 2026 18:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791681602; x=1792286402; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hBPQTG3BVZCu2UOvogkn27K8uF7vC8yFQ3S6QFB63Ko=;
        b=pDELqtJGVw+mL5TA+9JnzjDRv1MLaJPhBUGGQWt4UpfOt4lQptcLY4FHwm7PXX9xud
         5+j156vIxFCJoBOUpiMgLCxe6cF7EdwnJw28hkDwVLIECVOYE2gTGtRyH6t+SCuNnUn5
         felpzcG6B9zxbC3aqqLGFSM5G+2oy2Ev2cRLqhFVdXK1vijjJiRIFOD2Cqpv7OG79Guf
         Ks+olcBSw/l8hnjJTrQAtkSpr7O8dgMxQtCgzTI7JeL5rSD8nUY0jsxKmizzvzVv+ASA
         AZ2Th7btjOeVkgDVxiOufVGNcHI2Z2zoHQbQCGfTKyy6xPn+NYxqEegxowAVEYyu5e3J
         IztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791681602; x=1792286402;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hBPQTG3BVZCu2UOvogkn27K8uF7vC8yFQ3S6QFB63Ko=;
        b=kGK9VOdr/I8LgfcB6gPAqMCjVQpxa2RJcC03cl6OMtm+UQ3M8i3ZMrMSkR7iGBUdYP
         J5+WXWHRpOV3TXh4cGJ+4Q5R+3D2gwQK1U82NcrfnjEzHlzReNL64HMJhv/cYdmzihmW
         HbrtGV/xnd8PKKZcdUpY3bscEQJZ/siZLN8of0w1GMpJP2yNhjXfLj9VWRQG/FiOqgGz
         LZI1St2vq2QaVjX/QNLX6cKAe3ZCLsgUDwKYFQjvroxb4wCSP6nU4khlrtoJuF8FB50a
         zCtLKG/u49sO6BcdL1x76edgs5KneYWFRqXI692UhxTW4o5OzHVTJIhrIdQwUU4flkG+
         ab1A==
X-Gm-Message-State: AFq9FYJ6USmmivuZoZzxdMFd7bkNB2jFPW2jgQmFE6IoyDBJeplaLJQQ
	48DG9/LNlNkSS6QEh9v8/V1b0Um51t9FlOFuf5vv2Irgv5CqdJkt/PGHYD82AQ==
X-Gm-Gg: AYBFou2E6iZxPmk9aJ3vdbxJDJjs8bfDQwFq/Q6LwuVJ05txgOWICch9dbn33OoE61j
	ow+8wNCHwkc3OG9Eb6qEMINazB9u2Rx2Ixo+6XaFcSkNUCBkabxhy4Y/j8dysQxDZu4nRMHfB4/
	aBYFtSX+ObtbIKZroXUZ2XJeKzEV+bjsYRO1UVhhxBB2vqcCJNaJLTC4zB5FbWTCI+663ULs7t4
	QRtc7HwEfebd6CVUQJdYvvAMOeY04xbK6emrmLnmPp8T5b8p7YaKbVefzuK/80Yx5lv4agsWtui
	88svPPQSlwXwmzVyfsE5bRgkwL8N4XRC86mvxWzPXyxE81h3aEpVsP4ukDVLtXDZqA73AMfuVu7
	tnnYzuduNV4XsbV3s1cKqej/A7fvS6b5D8w91skQtrp+NXvZvLUC/Zgu81rRWrNPkgpX4jAy/g9
	KrUMJT3kD4hXTC6RQ5ccRxSmjW2aosbVw1bKEFeKu2Dat+p0JILNn9IyshKcuYAOCOU8PfKzn2v
	jUFpT4Yh41fCec7
X-Received: by 2002:a05:701b:42c5:10b0:14d:4c0f:48a8 with SMTP id a92af1059eb24-16a5ce950cemr8179588c88.26.1791681602107;
        Sat, 10 Oct 2026 18:20:02 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.126.214])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a1becefdsm17538949c88.7.2026.10.10.18.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 18:20:01 -0700 (PDT)
Message-ID: <6acae441.bdce4de1.160bb7.6f5d@mx.google.com>
Date: Sat, 10 Oct 2026 18:20:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5103445905182782601=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ooonea@gmail.com
Subject: RE: None
In-Reply-To: <CACmoRBYCiLYXr05CLjvAA4wPpbjje2BhFHe1v9fEfSFAWFR89w@mail.gmail.com>
References: <CACmoRBYCiLYXr05CLjvAA4wPpbjje2BhFHe1v9fEfSFAWFR89w@mail.gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5103445905182782601==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       None
   Pull Request: https://github.com/bluez/bluez/pull/2593
   Created:      2026-09-26 00:38:20+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============5103445905182782601==--
