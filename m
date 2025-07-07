Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B5DEEDE
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Jul 2025 15:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751901202; cv=none; b=IoJiRoXQ9sc+vxRqNCvZAmFcc23MlUC6QusQzNLgTcMqgwUCZRfrpVfveRGxABXVu5S3sQuv6xM6lhp1uqfKFek7iatBPumSXL3JcvLFuv1Zy3oC+/D7BYmCBc1PIVrh1rY7IK9oaelB0eZRt3shQmByyH5DsKI1ZmqgHdwQlt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751901202; c=relaxed/simple;
	bh=Uf0pbShGg+VqrB0kGW1+aZWZkOXNawo+cuiWk7U/cAs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=b3NnoTSVFQP4oz5PGmIhDFtPzJW9OFsGOMLzew8oOs/v0z7V4DwfVKKfNzCQcdvpvyUgEnZWQEpimjIJlnN1T1CeIZfw+Ek9/AaX2ohs7sH39T+zdyliDIcTgbJMgplf17OP48HSMwqILc60oNnj4E/LTxztocxPulyIDZSgQMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4n71RA9; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4n71RA9"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7d5d496c361so293153785a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Jul 2025 08:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751901200; x=1752506000; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vM2AGPWUBlPx4SDskCvLy9AVuyLeOfn5z6/HKbDIM0s=;
        b=D4n71RA9Dme8hF53Hw0IMLiTU1HtRCvw3WriHQ13LeyP+qBuMS4FAEw3VxVun//tdR
         /Jv6vFtXP3lL29+WYkgiySsspacLR9Cm2v6A8HkJ0+5eHnXTq4/jXGf0cikZJaAsoGv+
         mYS7DgKt9JdMBZSANtrT3XedHuiUcFRfcbeZqZB6bZNwHfAefKMO9T9hV7uInl67QxL6
         QJmffmQjBUsMkMdub3M6toxnFYYMszeZ4mUy7pa9J+R8m7qn1jHsB63IXFCl+NPLszGV
         doBPm5UOEMiYDfmRwmJYPX7KeoCCOeslcqnZii36qccHxHlfsKYtnenJ1852mLx3Gf13
         IgyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751901200; x=1752506000;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vM2AGPWUBlPx4SDskCvLy9AVuyLeOfn5z6/HKbDIM0s=;
        b=BiqlLISTw2L4+frOWB8NOgsr0FhliX3fy2lyyQc0I38pzFzMi8efDO6ttNZ/mxfdD5
         EfnJ5eNi0uBb4mfxGiNPiygb6C/6Nt5WcSYAS0cMLKA5tvrfA9RHn29rL7MaUt6tAZr5
         67/xjCPvwljXGKi1/g4Vs7aqC9NCRWaXJVFg9BLtN2vc2eWd7cnsBnyqoADz79Pjgfca
         xzDH59SSh27LrUZBxuiv6tgHvPJSUIZSA3MGs0I8VXw8eaRDzzbrpIgVLEOaPX4850Ff
         NOt4IWSa6lcOzi96HKu1xTqg56VEgVBL5pcMx3ZUjJJO/tI30z11lCkWPp2P/Ate+1y3
         QQBg==
X-Gm-Message-State: AOJu0YwptXRR19CfwEHFxkBcA7DzWIPjO7YvZXWRonJXFneBgV/ldoKO
	9xJ44olXBMpWJCVnBrRmhZWx4nq6xHyRdSIctnI8XWSFRyFdNRdhrTcouQe+0A==
X-Gm-Gg: ASbGnctxVCzh9kScNotsryFvauglkLAoGwiW2K0clsbmRoLOeQO4KuWTg1aZuL94t/k
	pZ4Idfmx0nJkWuqHpBoqrarhUjhzQrfUNLJZThNtlqGgk30DCTHDvhwlpoY8HpYC5flLn4reWDO
	Lpi6CLcWDz4CJt7+3CbACEJbymNUD6Z9MbYjGwM4a6q94CguAVut5xLlEl9CeDLvJ/dhPzL/tL2
	sGjgcgcblDaLOY/CzwbCW2ZRk9aJBLjLPNxH9KN1ArcZ7W21B7P6iZr4wR6fz93Rr4iGNAyN6U3
	pxHdC1nT/Q65AT2GODtYGU73xD18PjHbH1hfYXk9aP2B8abXfr4xWSLojKTk7BCtEAxGlw==
X-Google-Smtp-Source: AGHT+IG0nD16JISwIVJIj8eRvMHuadzqx4wrPP/mABJ96wr+KTJSNafYXEvrdsG7hwfrfFmeW3bO1Q==
X-Received: by 2002:a05:620a:708d:b0:7d4:1e5a:95cf with SMTP id af79cd13be357-7d5f2f3f49cmr1204890585a.47.1751901199667;
        Mon, 07 Jul 2025 08:13:19 -0700 (PDT)
Received: from [172.17.0.2] ([74.235.231.227])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d5dbd93dcdsm626874585a.2.2025.07.07.08.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 08:13:19 -0700 (PDT)
Message-ID: <686be40f.050a0220.2f2483.6181@mx.google.com>
Date: Mon, 07 Jul 2025 08:13:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3177475072175064981=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] audio/avrcp: Fix crash with invalid UTF-8 item name
In-Reply-To: <20250707134958.72368-1-frederic.danis@collabora.com>
References: <20250707134958.72368-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3177475072175064981==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=979696

---Test result---

Test Summary:
CheckPatch                    PENDING   0.23 seconds
GitLint                       PENDING   0.30 seconds
BuildEll                      PASS      20.81 seconds
BluezMake                     PASS      2717.29 seconds
MakeCheck                     PASS      20.41 seconds
MakeDistcheck                 PASS      187.70 seconds
CheckValgrind                 PASS      240.32 seconds
CheckSmatch                   PASS      317.72 seconds
bluezmakeextell               PASS      130.27 seconds
IncrementalBuild              PENDING   0.29 seconds
ScanBuild                     PASS      919.27 seconds

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


--===============3177475072175064981==--
