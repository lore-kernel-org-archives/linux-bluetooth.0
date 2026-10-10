Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB943D0905
	for <linux-bluetooth@vger.kernel.org>; Sat, 10 Oct 2026 08:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791622136; cv=none; b=WmYtXfJTsDe0TXe0YA1jtKLl2yHOgCie/6On7uN7tiHVC3JCWX1xPXitdSVbb7TvZ9MHlVy1WELD0YwOugNJpTPhvn4kJb77XwX95BsUaNcyXc3BaqBhM/qt4JV/rWpovR5shic276YOmdsJoDGSgRTczcUHB+r6VEAsa2kVJDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791622136; c=relaxed/simple;
	bh=c3rNe+rY9fVeABmSYSFiLlKU8GQsX5f2qH9BI1y7giw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=HTeNWErtCthEiTbxdd7eJyAKM7q4umIhSs6Tl34jyEJJOBB9IT6WWHwWUe7CSNVY1Z8ZVkLZc0Vka8lzyyO1dWhOXI28QJX3JOEBWIXzWdI1za/DobxYDuDkBi2kos4WEB6adlr8U/IPjXIkTpr/KVI1ws8C+RR+9VY6SHw84Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UV/pKASg; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UV/pKASg"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-917997ab0d9so7661856d6.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 10 Oct 2026 01:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791622131; x=1792226931; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=c3rNe+rY9fVeABmSYSFiLlKU8GQsX5f2qH9BI1y7giw=;
        b=UV/pKASgQ3yb1loJ0tJTTuqFfM0vljsv2FrIEKVf0ZqWEKYPx+HQgPBxTVilcOsOlU
         JJ6poqyArkjpcQPIbdEBTj620WvWdI0lMrg0OVKgFhg/q/lZDg99ogbDExHUYv/sApZh
         pMmqkItEVZ1md/NtMOyJMQmPFg+w4Ao11HtILB6reXIcO731EtPCZUpmkW/6tjumq8Y8
         PtY8KLT9ZAZWVEnIbQv+yelEUGHaUVkdn77MVsf+suAbYSsFmlQRmVabWe9bekOQVphn
         nHXHAoAnxso4KP5KsRjX96/UTz6BjrriDpqOe2/ZG8dkgEV8XED/moB668Ido0Arns4X
         7tMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791622131; x=1792226931;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=c3rNe+rY9fVeABmSYSFiLlKU8GQsX5f2qH9BI1y7giw=;
        b=dL6RoqAeDTY9SFQANh4g4h2vsaAa1bHWIYE6hUGafRFdxS85P8toU4qQrm+peEISFc
         ITFv4FXw1HWNClGvYxefVVB6mmmKMPJ3e+nSJbkYlkhE/dNBlpzTRlTZrU1O8TYvCfWm
         GpZwRkbwYQ9NAfcfba2IiPSvmPDCl0L9LLILqRx28kgyTVh54d8NMp5FYKa6nK3y01Nr
         gjp/Wo9hWqzsKUza2cOzrP2BVRhc9GBnUJFpoXNveKJLWfrJVCkqJcJTVlQsJeeNIydS
         Qy65OQjiDLWd8Zdjcj5oiSTFlFuYMn6C6/os8oabP67O553y9MAF3AJT1oz62sejKGYF
         j/Bg==
X-Gm-Message-State: AFq9FYJTSgHTCdlIGSYpu1ojkcq5Krf40WsNiZMX6j0G02JRFoQYATNW
	Hd0/WjRFP+lUaKv31wtrRUDEwHE7dnx6o6auGOBscnS0TpBXr4Gytj5NsmqBew==
X-Gm-Gg: AYBFou1fA0hy9MEMNNaBRlf9/0F75fG3GhdOMqaK+SFxuqnNaJXiyKqqbaOxV4P1itJ
	2r0BO5FWM9t+Flh4zCZ4YARgQVqzSgb1w9p31L9L1T6V4L/asYELBzFC/3/F+fTis6xIRlHcpAb
	MFvmzvfo6rxSymNfSTFlgu+AZxRZSJa1rNzaJ+IWj9RBy+TQRm5pC+Dx7BVGWc6CiCFT1eicoGg
	QnvgSUBNBGNKb6vyEhD6f6K907Opxk59NXIbIQj+udj4Asq4wqOI0g4fOdaaJ5AAHGsa31rCveN
	gTqjkBYx6If2tR9T4XbCOxiuL1LfZxBN0/CGsSe6JJLPWkbFseqAAoWTiwZt0i6G4B3Aftpmoqa
	wLmt8EaG6mL8o2N3wa9Fd8xeCv+VQl4wVk5ZkEliJZ9UcttAZG/h9bMkvko7XPp+X0zSGPkcouA
	O+bqNBLAi+Y205kNgcwF8JzcT/iaeHc8sPrsUThEh0lO1jCOuGNvjcET5QckBiMuecxecLzaNti
	d/S0kwkJsqtew==
X-Received: by 2002:a05:620a:1a29:b0:93e:5fff:daff with SMTP id af79cd13be357-93ebd0cbb7cmr703416885a.6.1791622130679;
        Sat, 10 Oct 2026 01:48:50 -0700 (PDT)
Received: from [172.17.0.2] ([20.49.61.51])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93eb98861bdsm383521885a.24.2026.10.10.01.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 01:48:49 -0700 (PDT)
Message-ID: <6ac9fbf1.6cefb47e.13431f.4630@mx.google.com>
Date: Sat, 10 Oct 2026 01:48:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8808770083867407088=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yaroslav.voytovych@gmail.com
Subject: RE: [6.1.y] Bluetooth: hci_event: fix simultaneous discovery stuck in FINDING
In-Reply-To: <20261010022523.2789588-3-yaroslav.voytovych@gmail.com>
References: <20261010022523.2789588-3-yaroslav.voytovych@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8808770083867407088==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/hci_event.c:1748
error: net/bluetooth/hci_event.c: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============8808770083867407088==--
