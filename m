Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FD2DF6C
	for <linux-bluetooth@vger.kernel.org>; Sun,  9 Aug 2026 14:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786284151; cv=none; b=WSlXmBsXkrm45AtWLTouBA6XrJ8znRvUIc/V21rRPQNZPhqeQcwd17pXhXmkIvK117dlHAclO82ZY08MYUJQE+lCXmlkCJOQUllkE3s4fsm2TPybw5QJUmFGX/MzCF7B4L+QEHa/PnhO+ivq8eq6I7gSeXVXxfZ9j7hAi2psj6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786284151; c=relaxed/simple;
	bh=tQ6U3QLsiknfagURBfPB1P0HUhcLtTm9oMwmWRZL+YA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=AGNi6nQoNFsxmMnxB8/TKf6rwaKvVQTcTmQXg8GeVawlFGd2pGrlUQYBbpJfiSrqQiGZFQ9Y2ctkNvOPXg8BgX3ZWw68MCKzI892tvkKh6EWlQFsVEFVlGgEuq16jZ9qe+v/SF5CcDSTVZL5rpVWf9hHB2V5XLzRy/5uT+xHwR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RPld/Gh3; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPld/Gh3"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c9e0b89e228so418483a12.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 09 Aug 2026 07:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786284149; x=1786888949; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=G+nVykoQAelCF4GZIPcav5sj0d6b0KSj6Xa+AlAAvvg=;
        b=RPld/Gh3mwUkXIgW1H+0AxLZ+BKU3I+nFLmwydutRue7zVxGUrsc/+TKWJC88r76Em
         rFzGHwam6HxGXpb+rnlgvtpMMuWNCpJbEfR63sfFyuaLz8PuIFeapK6+Fl+129Unny/s
         YfeTvOUdd7vSIyV3bzvbhT1QCwYwnaoD6O/uF778SCs3IiU70z0lHa5CN8Dm12UT5ZoX
         7b3JD4gsIyxm6SqRuwyrdKfJH0pWAzPaTx9xvPS0zvPM9p1g5N6yimHZSmhtK3RgoUQO
         yJN4u8rsXvnorFe+JpwfshOf7G3eHnH5RXBryXs+WlR6sHF4QZIzL8SGWzCRDAD9EdZ5
         PRtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786284149; x=1786888949;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=G+nVykoQAelCF4GZIPcav5sj0d6b0KSj6Xa+AlAAvvg=;
        b=pkbIeiMDZB4MYpLc32XOY7bjLALU7+OM1Doxu6QZWqa50P+JVh+WYg7365KgK7CYjd
         grYEoKH72PM5Qx8p7Gg7K5/dQX/1t18oj7LEonlZHVBR+9mOIohKKYLyUtujzuVJP7OL
         SZPiGnfx8QTWrL+nIPeCI+JVrJCJdOCuinnzvBZItKOg5b3nSI+vVJ4dfnm0AudfOzad
         GjlaI7PVO3ZDl2biRqmh+q9yaXzRDKLaRfXGHiv0TaPaf9jVBX2Cp2eRoULWB6MemZMU
         ELGY0nx1E/LxXeRq0NhFh1b7qIAi5nbrRaEB+8fltP9vu64RyOJKQazLcBN2dbf1TQGR
         nxfw==
X-Gm-Message-State: AOJu0YyW5f3IGMrbzILSNsPD5gK0825b1zxsQBW11XPfT393o6jMgKRn
	Kugo5xnY92R6+xQm8SiQ7wlzTdhBISp/txVhNpLBOyjiXY84KNkcjXh/hHFxBXJG
X-Gm-Gg: AR+sD10VALnTRqZVxg9GkMoLqacDPHK26gjYNDEStY9CnXdwDN6rYMVEuRqCA3FaC24
	XxKFTIFMYqcMMauLqS3KlFKzZsbSUFG0hMJrBQNGGd4Ifuq/4dabZEykQmWH3xQk2755A9m3OyR
	xo6wKg4bED6+1CY8sq7CXS2V/7QI9axM+U5Sc1bcDwBPf3+cHEAbQ0ccMp/8OC/jsrW5FMAz64X
	JfeX9rbMzqHC7Pmz4uGRJJvxonHaY7riwzT6JNZ4PNjKwJi8RcjyQQQM6E+irX59/j6jCcw+ab/
	wWOQ3ONUxMcrxrliBmZPrBEtnORQDAxohYEwDKS6b/mFgxIMLaTYkYJI0u8D/6gLADtgzZPwNpC
	rfBtOuL+v/n7/t4zY+dSffW6FhGxy8rdzFtVZ1qIdK8IKmLEru7Qge1bhyPKx0RSBqCGkhqrhO+
	vkrPjGUG8YaURie7NzLx8HlC3zWFoTaQX26Z5HfHJNnkDcsrWezbg0A7Cu4s343skeydwMt1jh0
	APJgg==
X-Received: by 2002:a05:6a21:b95:b0:3c3:875d:c531 with SMTP id adf61e73a8af0-3cbce6f1862mr16140771637.6.1786284149339;
        Sun, 09 Aug 2026 07:02:29 -0700 (PDT)
Received: from [172.17.0.2] ([4.242.193.225])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315be8d6074sm33968041eec.12.2026.08.09.07.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 07:02:28 -0700 (PDT)
Message-ID: <6a788874.9edb5c9d.219adb.505a@mx.google.com>
Date: Sun, 09 Aug 2026 07:02:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8728488611209983715=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, christophe.jaillet@wanadoo.fr
Subject: RE: Bluetooth: btmrvl: Slightly simplify btmrvl_process_event()
In-Reply-To: <9fc342cc7dd726868216174cd83d196d1ca18f94.1786280385.git.christophe.jaillet@wanadoo.fr>
References: <9fc342cc7dd726868216174cd83d196d1ca18f94.1786280385.git.christophe.jaillet@wanadoo.fr>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8728488611209983715==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1142910

---Test result---

Test Summary:
CheckPatch                    PASS      0.50 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.22 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      20.64 seconds
CheckAllWarning               PASS      22.92 seconds
CheckSparse                   PASS      22.71 seconds
BuildKernel32                 PASS      21.69 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      373.38 seconds
IncrementalBuild              PASS      21.26 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/562

---
Regards,
Linux Bluetooth


--===============8728488611209983715==--
