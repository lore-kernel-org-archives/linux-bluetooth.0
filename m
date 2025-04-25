Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF1B18C337
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Apr 2025 16:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745597215; cv=none; b=P7flVdHw1HeVdZcjQSsmQJoAI+rpOzERUfQzGsYqqaHhwUhWK1oA7OYrw5qr1jF2PESe7RpuuIXT2J3NBRf1Xc6z1F0ceOXrUdOdfGeeZt0WrUChbL8skYnHELqSWD1lAhjkQkCmlBGJbD+3LSxVbFxemKC49vGXGbh33V3QWv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745597215; c=relaxed/simple;
	bh=7EZMJQ//ZLDGfkgMb2fyOVSQ/VLD4LlK0/vSYf0YYT8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=fMgTq/S3hl1sw76TpVPkBIQF3Q3rs632WPFUAYqBB+qh5Hp7JNxobBcoM2U1tblXBE2xWBiCOEgrT8PqBZPZ1JPuicldPmyKEKNUWop66mTjITUe3kULs1cir8rz9Tc8+9mDmhwxdUtUVxLzu76ko9LUOcycvwic0xe0hRH9FZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZDkqhmsk; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDkqhmsk"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6ecfc7fb2aaso24137196d6.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Apr 2025 09:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745597212; x=1746202012; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qnncgVtxodm5waIsmsEEpDUJe5AVUF7TOVoVJ5NOiLk=;
        b=ZDkqhmskXX4iR0PYFPZvbNsYB2z7CVwmySyxDPEFXbE26wfMMmnKtM6P3eS52iSx6B
         oCakTH/JGruhezlGovuTzZaI+lpCf4DiBr5SWMFkk6+L4AhKV4vb9NVHF84ydXZpeqOW
         mI/67xcQNas0ONi7+2djmf+JpLJnyTsqdQluCJJ0Tqw2iw33B3wCDUiqzG9rMB140hSG
         2i/qRAQ/SYOvUuvo41dylLKZtahB9fWMVjtbHa/W9Mk5KE9Hhxa8+wC66Jm09jn7WG8R
         oulkERFbc8V2fN5/n/mne4Oc3ugiQ/9eR/AAOVp0KqVEr4kOo0Mg8KCYtr1IvsVzHZ8f
         17uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745597212; x=1746202012;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qnncgVtxodm5waIsmsEEpDUJe5AVUF7TOVoVJ5NOiLk=;
        b=RaEOTIeNdqfG3lXDSbv2abW89mpdVHJOF0Yv/sN9ClbDnLu2CSqUlZmA0R5GmZLQ1e
         5qGyIK498SgCWh5WZZjdOSICqT9zwiEGz9HPD85pVoUXuBEbAWoFBHh5/5jS+S1u1RHG
         wCi9dKB9Z5EXMkIT7didx4BqkZvdTSFM0CKC7e5X4fWChkj93BX38A5wViq3UbSwj23e
         jBgZK/BVy+gK3HuKWGoonavo0bVKWajuL7LW37IttOBNPxV8S1w8VxZTp3GrYVc8gqrq
         TYBiPI+S0x9AlyAWdBgL+j+nNVjQ6PWL6Ul20Xvvw6g7jMGCj0Z5KbN/HIla7JrOaMuw
         nq8A==
X-Gm-Message-State: AOJu0YwIQRUAcF6uYrQWA+JAXNJJ4QIbOGjI4EZENGS4z6AoCdDZIHB5
	tu/9rtO0Z5BkEZeNHAJWU7rst8cFQJqa9WZBOUW3yLr3MOZGfrqlBI5TZQ==
X-Gm-Gg: ASbGncuaPs4BRLRHyLaEC5fuH7335rgq1xGMyk2IuIq53OSKKrcN5BclAb/n39JxUN/
	iDqiB4pU2F7GikA/OjCUnL0Q1/Jqg57OGdpa1f9QB6YuBj7rEy7SLieM2wBGK1IN4EDXRf93jpQ
	qw00uvFX/4w7eargciNOhO64K8Sr2qO2fsfZwlWCHVSqhuxliw+9tLclkkIevVBTJhaRdvIzrC6
	QQM84XceQ7e2NwEWX5uiiWymU7LItEAvBscG/PMKZ2vfHPxEm3fjEk2+05tMGyN2BijWWFTqBpC
	fNs0L2R4FORbss5BqLCuhMl6H7jhqx0Jf4IhifNPPhXka9Js
X-Google-Smtp-Source: AGHT+IGu18XKrYN7AmAvrir3gOHW7fFdT2/YD1gefkxsmDdEIteZt2EIfmTgfL4RoRU/SRmd1Js1Lg==
X-Received: by 2002:a05:6214:5183:b0:6eb:2fd4:30bd with SMTP id 6a1803df08f44-6f4cba4606emr42582416d6.30.1745597212436;
        Fri, 25 Apr 2025 09:06:52 -0700 (PDT)
Received: from [172.17.0.2] ([74.235.134.190])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f4c0ad4382sm23492166d6.125.2025.04.25.09.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 09:06:52 -0700 (PDT)
Message-ID: <680bb31c.d40a0220.1fa87b.e659@mx.google.com>
Date: Fri, 25 Apr 2025 09:06:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4165223456024716375=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] device: Check presence of ServiceRecords when loading from store
In-Reply-To: <20250425144418.408145-1-frederic.danis@collabora.com>
References: <20250425144418.408145-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4165223456024716375==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=957071

---Test result---

Test Summary:
CheckPatch                    PENDING   0.30 seconds
GitLint                       PENDING   0.25 seconds
BuildEll                      PASS      20.42 seconds
BluezMake                     PASS      2631.74 seconds
MakeCheck                     PASS      19.90 seconds
MakeDistcheck                 PASS      196.39 seconds
CheckValgrind                 PASS      271.42 seconds
CheckSmatch                   PASS      300.92 seconds
bluezmakeextell               PASS      126.82 seconds
IncrementalBuild              PENDING   0.22 seconds
ScanBuild                     PASS      891.17 seconds

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


--===============4165223456024716375==--
