Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8507D170A1B
	for <linux-bluetooth@vger.kernel.org>; Sat, 15 Feb 2025 21:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739654917; cv=none; b=Ezq+FEyoc07ga64oeynYi4iHgOSAG2d5W5N3Fa4/PtXVUdhP7VglL554hqh5YxltuA8tdZTlH1lO5tsQSfYUV1+2Lg5HFiKOIKK0kR55Dpp7eDV9f3+4o3qU3hUuI5+rdKaI0mrTGUX7kYc4GwgoQ20FkZ5wM0yug5VZgwE93u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739654917; c=relaxed/simple;
	bh=xA4GBmEEbhKzqhgeRKs3z+Gf0mAGuBw8H9ypXdveqqM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ax8vI8j11doDiXx7cJEws15DARf6lUxEHjsrzW9d0r3+Mdf4cH9/30rX3ILjWEsjdK8b6V5Ajs1KtMUxNb9nlkYZxM0nGIvyXsr0dY3vQgy281M3KFRWaPtVb1z3duvqxPlw0tCqz4N5JnNEr/ugLxrNLkMs5Fe8KjS/50WoaBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AmopRqn6; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AmopRqn6"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c08621f6a2so157932985a.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 15 Feb 2025 13:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739654914; x=1740259714; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4r2y843VroIoazvCvPZsYxG82WMnfVm3BageyCiNG7k=;
        b=AmopRqn6eKp5n2oNxAdMHibOuAz3LSOM76pRoWSaBJ3wpD6YNW2AUIK3o/9vAxvNiI
         tY40cv38pKDEZeVxYPpmlLE+VOGhq441ElEto8mIKgeHayx9xFQuVUVm4/15Aqecfz3T
         TY0qeTZFr0TQJVYreZaucVo3qTrDzBUXxcYl6OW0N5UWg9HhyJ2jVODOvqLCka7QjE/4
         6MPocAP1tcyMN2dpvD42IzlMOULYKMBLWiZ7K4v1zTqmV4C0UH5qW9yr4CAJ/1htuK+Q
         ymX6cdM2sSclDT/SSs2LFAI8jz1p8XKlgRzGhoPVxC+PU1d4WP4fF6zkuZ8l9JKvuXaR
         K5dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739654914; x=1740259714;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4r2y843VroIoazvCvPZsYxG82WMnfVm3BageyCiNG7k=;
        b=Q+jAjyHHEuBSo7ff7Z1e51MxWnH1vQelNZQROuIx9tdR9zjIaQq2SGIZxSDvD9Xjuh
         R+Th8he9t1EjLDUy3sVkqgliHa1HuZKawACXkOtVieUeNNt8S6fqOB9AOwXWuXW/3ohl
         UyO31d4enhbJaUfWvgE76VlPRFOMmX19nuaJ7yMhV6I1gaskufL2pcLiHgayfjM4wN4K
         Mh8Vn7ZrUreKkb0/nUEMQpbvGoLgaJIPX9YZAqfqfDvGlBEd9v759n+piEyU1V7bzMeI
         O0ySNiIWnE/FocuuZA/P/YX0iu3qZWnqFwaPlBd8/aiI+hcKUkC1tYBsYfJGaNy+62S5
         2oXw==
X-Gm-Message-State: AOJu0Yz7m2MWrrW559oyX0UwCCJb/tnYvTxfntcOdrV30dAkYwnyoQ4H
	DO8Hl2GXG2TEdBoOtDZa2lV14ru6/TFhjM0GC9SQQd+z1Opd8rREhBXsuQ==
X-Gm-Gg: ASbGncunIRZ2xvhxJF02Yc9+Ts7nAvRo/3bzfm2ToLunyfB1DtBHNUbPbCU2zaWii5l
	0Jy39SNROsafdGiBx7yOpFjmx2RFS8dn6ZCbpvOWUgktVlLqQ+zCc8VeRy78WOwm52hoYgCyDlD
	oA/HC7VIUGsC0RpgReZvikxNPDmg6syA93M46VXmccp0OV6/V1n1Smn8caFDbyYGe0Fl3qD/jhe
	Vu88bJ/rpGMhcbdk9Zub8kxNt+KZmxVIiT+yAE8OtKa9M0axfp5QeC5fpnmKITx7eRkiWWbiTBx
	Ya3zGSTKHSf/rInG8ILSrAQ=
X-Google-Smtp-Source: AGHT+IFoxw071S93qk5S7u6r0OHcWdzbvF69x55VzR5uTHAIB2zL11f5I1INt+HFp5NMwmJhdDXWyw==
X-Received: by 2002:a05:620a:3906:b0:7c0:7c8f:c3b4 with SMTP id af79cd13be357-7c08a98fe91mr677577585a.8.1739654914080;
        Sat, 15 Feb 2025 13:28:34 -0800 (PST)
Received: from [172.17.0.2] ([172.210.84.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c07c6081cesm358578585a.29.2025.02.15.13.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 13:28:33 -0800 (PST)
Message-ID: <67b10701.e90a0220.2136f6.d514@mx.google.com>
Date: Sat, 15 Feb 2025 13:28:33 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5424205268865943754=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, arkadiusz.bokowy@gmail.com
Subject: RE: [BlueZ,v2] bthost: Set advertising intervals to valid value
In-Reply-To: <20250215201329.173999-1-arkadiusz.bokowy@gmail.com>
References: <20250215201329.173999-1-arkadiusz.bokowy@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5424205268865943754==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=934345

---Test result---

Test Summary:
CheckPatch                    PENDING   0.18 seconds
GitLint                       PENDING   0.18 seconds
BuildEll                      PASS      20.32 seconds
BluezMake                     PASS      1435.46 seconds
MakeCheck                     PASS      12.95 seconds
MakeDistcheck                 PASS      157.43 seconds
CheckValgrind                 PASS      212.69 seconds
CheckSmatch                   WARNING   282.54 seconds
bluezmakeextell               PASS      97.87 seconds
IncrementalBuild              PENDING   0.27 seconds
ScanBuild                     PASS      860.16 seconds

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
emulator/btdev.c:450:29: warning: Variable length array is used.emulator/bthost.c:613:28: warning: Variable length array is used.emulator/bthost.c:787:28: warning: Variable length array is used.
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5424205268865943754==--
