Received: from mail-dy1-f194.google.com (mail-dy1-f194.google.com [74.125.82.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1BB298CAF
	for <linux-bluetooth@vger.kernel.org>; Sat, 14 Feb 2026 16:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771086845; cv=none; b=O6ILzX++wqP7J15Qhjo91oJ5SJ259cYhSY6nPVFcRsO8NC8peaaiJMhmzqQKSX6MgUqU5AznzPSurk+/IaIMkIDbFb3BLdjAH3XI62DxkSGBTkc7HGfn+LQ1r5X8RYX4NGk57GUDswLCR0bBjy7N4yRQGyZIy4on1waaTKoYrN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771086845; c=relaxed/simple;
	bh=gJ52gfXn+4bAizZjv8b827seX0nsXrFXwScvHIlA0Qc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=UJ3iv2Ut+QmrQO6efruodsy3kuUYxVTTGRO775s/42Gr9VjqWuHaTKt+u09tp1y9S3tAegvZ60w4GsLRNv5UT2xEhjVTAOKXk3Zh+JRRRJGXbHY4g1czkyf3GsXX9R4sIizDD1WSEexT6ycPBa4223X6rXBvW1IDzRzixaNfwEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gawERs1i; arc=none smtp.client-ip=74.125.82.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gawERs1i"
Received: by mail-dy1-f194.google.com with SMTP id 5a478bee46e88-2ba94dbf739so2028200eec.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 14 Feb 2026 08:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771086843; x=1771691643; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7vANmoQkAaJVFTCLW+K0vCQ/3VKnb1jupjKfwjrLzmw=;
        b=gawERs1i+Rb+SdAtjwnl2D04DAZmojzNQQcaEMi2MMMpOFc3DWcI0E9NjfOxm5CUTA
         YS7ZFoYnOkGmz7L2adnX97Z2hqEAPDClILkWG81r+lKGzokkpBclg2LK6op7RlVqDwnF
         8Y9ektuz7aA0ODGbTFztf4/acxYv8ikicu2AES61YnJAjWF5tSNaJTSnYUkQPYGUF/ll
         tvpHDy0bSfoDL9ZG8qQoE0xFJrxVZq5MZ0dJUoHlSkEJ0/ZJXzNIFMw01w1PvLe3Wfe0
         DNN+GCy3I+gCwZVTJ6UPtvIrvqXNJfmp5CSdSwAjgDJbj8tKtJCG/1DAv/kphO1//Y96
         Ezyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771086843; x=1771691643;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7vANmoQkAaJVFTCLW+K0vCQ/3VKnb1jupjKfwjrLzmw=;
        b=LLe9DlQgfA6S3NkzSfRx/X+fIYzTtmlq+kV4xnUZt3mAHQL4UnkeCBs4Epl52MNqqu
         vEt/9itpdhpOWbcfWWMFhYQg++A7g0WzKOzbKM58IXpPp01ISpzIZ60hxRvu4nm94vKy
         JVi7FkE3oWUcf0VyxnmHjM1nkFWII+jrVMfEgDxSrhqTDhgYrqDVLCLTQRn1SfmM6v4T
         8qpl+8WTVmjnb+SL8DxsSoOd1iFXF7TWzbOvWHTNjE4cASM5IIoOlubOMNCZmcf1QRBt
         CzDljDX4Y8Z7sQDKP8m/JJhOZCQWd9rZb51eQ9Pv8oJ5giFkTylJY55jPbd+gMCNjsAQ
         imVA==
X-Gm-Message-State: AOJu0YwCBh2P1m4K+0qpLN6yldptVk+Omjzq1QXdxFwU6GcToU8w2rby
	hnG2px8iwLQdbUdhpAKcJsNpkWbSqsBSSpW8PpoWBhHSpn6XhKPvu3+QhYQ9yCJ7
X-Gm-Gg: AZuq6aLXmxtic6u2Hvm1Tbqp+rl35VKdzwwA4Q3OXMFRGqAivqHxhFClL5pRnT9Ki0O
	2cqnljnpOk6NCHPOPVW6MLj5N32l5THwmYTG5ZPHJeFnRQ/RV2C/0abuTaf7SEMIW7Uotjs9V8a
	9XgX50vNBfdoXpWU9s3piUAqav+Z1v8o4npQFIdBqobtZbI5xG58K0yHrlfvSsY75nsJ6TRh6+g
	VcBIhAVXlxloXF8j+YiJ02i+1mrxV/pGTgkxsQGtBgUF5iCGsSqB3VabWo6Qn8N3VQVWoUwSeiH
	KJTZ/eTx5ClggfjNS/Y92HZuBTQIJGTSjrUm5tSyAfbsWbmJv2FHlG1DEKZQUa3iGZ/xaTije+h
	N9yNF2Ql86gKf+Je5fx2nZLBmfiinNJPvb0FDOd/wfoTDyUGhNK3GmBCC9SLeN8e2f93ahSXG0z
	NSyuieGRnQul1gjZRnFqhBJMiw/iyxB4Y=
X-Received: by 2002:a05:7301:2e85:b0:2ba:9fd6:c36a with SMTP id 5a478bee46e88-2babc4867ccmr2147169eec.29.1771086842573;
        Sat, 14 Feb 2026 08:34:02 -0800 (PST)
Received: from [172.17.0.2] ([172.184.211.241])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb65780dsm2625808eec.21.2026.02.14.08.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 08:34:02 -0800 (PST)
Message-ID: <6990a3fa.050a0220.354ff8.e041@mx.google.com>
Date: Sat, 14 Feb 2026 08:34:02 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5075087669427968061=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, sarveshwar.bajaj@nxp.com
Subject: RE: Fix use-after-free in BAP broadcast cleanup
In-Reply-To: <20260214153616.655-2-sarveshwar.bajaj@nxp.com>
References: <20260214153616.655-2-sarveshwar.bajaj@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5075087669427968061==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1054177

---Test result---

Test Summary:
CheckPatch                    PENDING   0.45 seconds
GitLint                       PENDING   0.38 seconds
BuildEll                      PASS      20.91 seconds
BluezMake                     PASS      651.67 seconds
MakeCheck                     PASS      18.79 seconds
MakeDistcheck                 PASS      248.06 seconds
CheckValgrind                 PASS      300.04 seconds
CheckSmatch                   PASS      361.86 seconds
bluezmakeextell               PASS      185.00 seconds
IncrementalBuild              PENDING   0.41 seconds
ScanBuild                     PASS      1034.35 seconds

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


--===============5075087669427968061==--
