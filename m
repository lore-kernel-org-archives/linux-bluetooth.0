Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9681D5CCC
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2025 19:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739387825; cv=none; b=VBdjkBJwZA732ogHZNGBpzmsDHBoSzZ9SoQm+UgVrFwdMfEAL0VnmyiDDv2qHCR/KPORTFSMaQ5iYBYMCFMRP/rgLj8l/yaFWfdRoqQkjfy6jo5jGywgPemX6z7zf+oMRmyiFoWXImsjxTXrD1QMC8oSPcaOty+5KtBVHcG99R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739387825; c=relaxed/simple;
	bh=VCwHwSTQZ5poAqfJbGdhmxxn9xDx/KJGiN2FkK27MJ8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=alFYL/a/pY+xm79kTRM/sEUjrKHT6NWnFCDbo0zbUF5617U0nNe8yJkl0KOUZPHBeWoO3KVJr4sGdaIt2/b3lyuSD1gu7yjRoEEHNCabqMLW9z6RnE7A132j/rgMOL6OAt++GqrFcH6PuLGg772pX4hjYj0QytRCOFN0cZtV+ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRhKOTzn; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRhKOTzn"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c05f7d9ac0so6517785a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2025 11:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739387822; x=1739992622; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hqJyDTjeZw7fEi1su75RCg11NFj8vkS4dqBcpQp2edQ=;
        b=NRhKOTzn2fXaZRBHTiJ0jN7RbcckpTq8h2P/R+QbNJRRxIITeocOOJHwo0EumeTEvv
         npmqUMqpEMaCz8NTgowsAPTbGB4wwp4GlZWr2LF2yA7OW8CtChkV3/c7Z6/APcDavafn
         zsduxnkGfoqj+pdbfxhb47r3+qNkWA075pEaW0Yz+LMAvb+GvhAR+HwotbhVKc3St3tL
         +efOTVJ+vVplhpZcmgh/BkBeaFbfxupNDoHX0nDwfEO/PXnPlX/Rdq/KfigpN1Jnn7AZ
         wspPrLvlDs3FCjoUFUTfybthCd0kQiF56zTRRGTBgIV8t5jwdQ2gFUxHftbi2rHLEEbl
         IMew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739387822; x=1739992622;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hqJyDTjeZw7fEi1su75RCg11NFj8vkS4dqBcpQp2edQ=;
        b=vGizmiOcrGzsGzAGG/9kKbjn83hQhCh8bOPdcEKfIP+ACom/UFuM3D2p+DVSjNK7z/
         uvUA7iClYBKRItuGMmgbS009cZkJ0vnw9aNJ183sWZ++OOzRhnGsK0F0WVgtS/hDBfQ8
         qsZgWRFz8BJ3k3N9oaUJbIPUpuiMSdqxzJNwBQObhXdRGnCX+jisOkqV1nfszQ3hEe2w
         yAPU9Ie/27lJBXpHKFRjG8LJiykzxd9t2OZO+VM5z3+20GKS0hlsdCXEKFKLk7zFP/pE
         ENTEzOQeaX89VU8vYjSAsNyODM3WWsazV5V8N3mcPCkSYPU5NH/u3aWaBv5LiL8S+6Fa
         UjwQ==
X-Gm-Message-State: AOJu0YwPHQyqxamWqNL2FBfPnYAllgSvsTC38Pk86hyKRvgwbtKxHl6+
	IZjouUNWEnMJw7JSvcZAMD1DbsGriQf2Od9aTz8X8xgvLbIRUl+0BI0dKQ==
X-Gm-Gg: ASbGncuzPqiPMuwFgWIc2AwRKbYCKiZqaMe9WlEDMPddSbxCzHGstDsi+SQY4SeA0oM
	DbdYKwMynATzllOVkIvArF6vWOOzA+5RN8GHmm7zjGbQwcxf2M3YCEOWVZRRQYkUdKZVjUDWSBB
	4I8XOle0QTr2cGf2PGMtvn/bUmlCWog5NkuU4R4/jmqU/9o57Fu5NhDWi+uM8Yq71POeZiqhCbF
	h0xyjGxMZIeqOpbEbVG0PFk6FjX2FuOVAbgI7dJ00nilclwAqPsUskKxoL1/kNneYUttmH6NU1T
	WgO4f5Wwi1VcaIDcsaXFwA==
X-Google-Smtp-Source: AGHT+IFBPkeLRAkpDW1+9XgCHsmhvN1JgBv7s56hqAD4i5C0moXKYHDe7Z0WOoVWXRhZmYMjZFFd7Q==
X-Received: by 2002:a05:620a:4382:b0:7c0:5aa5:87e with SMTP id af79cd13be357-7c06fcce1ddmr746048785a.44.1739387822608;
        Wed, 12 Feb 2025 11:17:02 -0800 (PST)
Received: from [172.17.0.2] ([20.102.199.93])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c041e9f917sm884589485a.79.2025.02.12.11.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 11:17:02 -0800 (PST)
Message-ID: <67acf3ae.050a0220.675f5.e240@mx.google.com>
Date: Wed, 12 Feb 2025 11:17:02 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0694064997126821154=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, arkadiusz.bokowy@gmail.com
Subject: RE: [BlueZ,v2] btdev: Broadcast EXT_ADV packets every 200 ms
In-Reply-To: <20250212175427.131356-1-arkadiusz.bokowy@gmail.com>
References: <20250212175427.131356-1-arkadiusz.bokowy@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0694064997126821154==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=933306

---Test result---

Test Summary:
CheckPatch                    PENDING   0.24 seconds
GitLint                       PENDING   0.20 seconds
BuildEll                      PASS      20.43 seconds
BluezMake                     PASS      1590.06 seconds
MakeCheck                     PASS      13.60 seconds
MakeDistcheck                 PASS      157.66 seconds
CheckValgrind                 PASS      213.77 seconds
CheckSmatch                   WARNING   285.74 seconds
bluezmakeextell               PASS      98.26 seconds
IncrementalBuild              PENDING   0.28 seconds
ScanBuild                     PASS      862.34 seconds

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
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
emulator/btdev.c:449:29: warning: Variable length array is used.
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0694064997126821154==--
