Received: from mail-dl1-f66.google.com (mail-dl1-f66.google.com [74.125.82.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00354ADD99
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Jan 2026 11:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767870649; cv=none; b=uBlhlGj6wFZB3rbXQSA2IB9hP0HuKc1J9Bhr+rGTeGDk2uvDiAHYQbhC3mImkINmzF7H3Z48lQosMx3iWc3NxtmPiAahrFvYfQE3LKg9UjNVjnfUXCD2uCTrcqtJECvKnmO/T8ekbx6LYbIIyFbtwjs1aa5mq8/rIDvfaNHsYGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767870649; c=relaxed/simple;
	bh=Pz6Z9e+DFBJ5c2asSEPn26SM07yjYy/B7yJJBCjfHBE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=AjuzL3ZNw7xju5SHjQzAYBnGaZD9CceJgRGlRXSxd8mqPWreJ7Kyw04Q5TcQh6I93NWq5S/jXTYmd2MvBz9DjRyC7oDIvO2Q9Op633hqR+ElHA8Fe4kE7Cy6kvBP+XtUxr4nGVOBUaX0T7a5NtWSk4VVlQb1nuVRaTG4f1vdlJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iov8qfaq; arc=none smtp.client-ip=74.125.82.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iov8qfaq"
Received: by mail-dl1-f66.google.com with SMTP id a92af1059eb24-122008d4054so284977c88.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Jan 2026 03:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767870639; x=1768475439; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LKRRa2cvlo363PCwS6wPnPWddqj2wLbHjKpglT9BgyU=;
        b=iov8qfaqZcVllRMusE4kq6hKxMO1OV7gAPcynAr/XOIgnYnWN+BEsfhPzzsMML2pWw
         r3/KJ0EcA2h8AzfjzNY03BJAQ12Bas6or1gyyf0in0/YYfXsvrFr84MdeDrk3l9vvRke
         ChaL1hmXHUc7MGYPTe0rStn9f8LRlVZ0FKnK7T7820Uw8ip+X+FFSHuisYU7mICPxEiD
         hUtSH7u0uCNasnC1TkLJrw4tEz0vkCjgmjw77FeIJ4sRJU9p/uJvjxyIZS0aq0vA4ym5
         4ANpuS0HHgW1BocOkWDqi5lkPSJqLd9/KkpecrpScx7gfgPu+iwxnaFaeBMSSWJAizQ6
         7f1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767870639; x=1768475439;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKRRa2cvlo363PCwS6wPnPWddqj2wLbHjKpglT9BgyU=;
        b=Sa/7K3J/+5dgnf1+/QcvI2qH3DcXZFakqviQ7TanFd8FDukNsSG4JuMgYs5Y5dzONg
         PDCDWdpN+DNiqcUnVBeoWE+g4Pepi4lDxtNE/fOwQTuxYJuaktKFE50qDv7BhTqzQs3e
         +6cqrwL8RrFv2D7prsUJVUmmjLBxN7tAY2/Z7JGHg/0YEryiOMsteQuOuXa/6CqKdg0X
         si3JUVehayjHRgKqkNPHn2r8PsJUKDUtSgsAdreoPr2uDjLN2/4yILtVEXk9Mja2nMVy
         /pSwHwlsUBCL8y65J8wORwAOcyoPsjPz3rXFiG5xsrt8Wt0y3Oy3WmP5J46M6YLMh1Rv
         ppmg==
X-Gm-Message-State: AOJu0YwLTgvuQllahIf7p2pxnn8qCjurmpdor3kMXlIyKcranKQTjAyG
	qx1tYiAw5QIUiUxsScAvNxcBPpHOgi5kX7YNr4YO/NyWGLCRSAjTfZV64MsVY32g
X-Gm-Gg: AY/fxX7lxSmfNFF1nWrV4dFiXbBzTzsILYFNl20hkeepyfe3DGo2TyfAIoQZ+YDX8n/
	2ZWIS7c3BwaMM4Xnbmgu3+Djl0BuVhrtXu6EIoFpZ67rybdmy/S7uKm/bSebrdq43iWH/6aZKsJ
	NMkmi6ZcXO0mnDEGKq1G0ihOXHJbIYbWM0jI8j5SYiwBNd6sgXuixykRsQqF74OgjCwD1Eg0ccz
	PWtfG1rw6LOKkUy08AmI1P8aHbfEhM1VJY5CtIWabww9CxD8HrUXj621Jy008qMqdAWQSM5hS8i
	mwmMNVsjI7ygGjHZHX9+RkE5k7QAFWUQGA+WbMPfO1btqhUd+PyeC5nKJIeQZTmkTlR3n7NRZf5
	G33TI/wGYKdPI9ArmMOxuAUutxEHhHPZxxJW7EKgmdyeSDGl5YU9qUVl87dtrfLBgUuRG/w09C5
	66/GUriiaMrrSt6o4=
X-Google-Smtp-Source: AGHT+IGLzlMsyCWzVXxUdgfxfTxBtAHZDO59fWnf2lsqWhCtLd64Ia7i2A8seBK2hqRqgQ2yACn0Vw==
X-Received: by 2002:a05:7022:1001:b0:11b:c1fb:894 with SMTP id a92af1059eb24-121f1b4539cmr5663883c88.19.1767870639252;
        Thu, 08 Jan 2026 03:10:39 -0800 (PST)
Received: from [172.17.0.2] ([20.169.75.36])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f24a65b9sm10629161c88.17.2026.01.08.03.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 03:10:38 -0800 (PST)
Message-ID: <695f90ae.050a0220.2b1ca4.0c40@mx.google.com>
Date: Thu, 08 Jan 2026 03:10:38 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6665168579966812452=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, dalegaard@gmail.com
Subject: RE: [BlueZ,1/2] gatt-client: fix use-after-free
In-Reply-To: <20260108100136.486675-1-dalegaard@gmail.com>
References: <20260108100136.486675-1-dalegaard@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6665168579966812452==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1039830

---Test result---

Test Summary:
CheckPatch                    PENDING   0.38 seconds
GitLint                       PENDING   0.33 seconds
BuildEll                      PASS      17.55 seconds
BluezMake                     PASS      600.91 seconds
MakeCheck                     PASS      21.64 seconds
MakeDistcheck                 PASS      218.34 seconds
CheckValgrind                 PASS      287.53 seconds
CheckSmatch                   PASS      313.91 seconds
bluezmakeextell               PASS      167.39 seconds
IncrementalBuild              PENDING   0.40 seconds
ScanBuild                     PASS      921.61 seconds

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


--===============6665168579966812452==--
