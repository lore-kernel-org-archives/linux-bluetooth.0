Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D70534FF74
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Nov 2025 19:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762456236; cv=none; b=BDBwBGNkK5M2ZCevqvtl/dz/Djz9Q4v3m9IJ9z457FBtqq1a2KY0zj+REcvpGfjYhAkWhi4Et/1mzek5LKeW9tP3uNFY+EDUqnx1j2cqdoF+8QIcjzYs9BRwVJE/HrK1C3yJHtAkTFDlI+rgOcdGi2FCk6xtDXaFSnwexbbD+l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762456236; c=relaxed/simple;
	bh=skBBG50qsTxv8Sil/FP+y4vt9a8wyuRJzAuR50e7SlY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=HZ8EG92VlGpWY2z3OV+k1Fa/VruQ3Xmsa/NZvpLbha+YgV6o9s5+1mFKJfp6RoFVhl8E6iBZsNbwtqF+NmM9pSXphMz0ni9FvK6agkw3d/tAialXefaMh1DQUVShmIESAqH0kxQLo/l+tiqL/RS0OCtowClMlFUJHorIb1vWdA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CmyyfO69; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmyyfO69"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-294fc62d7f4so12826385ad.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Nov 2025 11:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762456233; x=1763061033; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lFfrFpmsCLYcvDSvkVZLWhEoXtUNAYNym9Vpjc+n/O0=;
        b=CmyyfO69vwyDscC/UDd6eG9awk18Z2zmMgF71Gfs1aJLWObGbZqDj1ekoxzQSbKm6K
         LmHj7RCLOCLa3q/eGsESRTADs1LHKtslMj2UP3mu0o9rknIiMaDDZ1Haxc2wnbjGs28J
         nQkBVEspGBbrp0QsD5EBc63c123C+YLCxZdhdhWplhqNKFgXbNYXl5gxjg1b2i6P2DZr
         yuAQG0Mrv7/og3B6Q9fJTCGApGcsqCRlTFoDLLMqWs1AQ1+d58UwpfWW1WSZsqtFG9BH
         pa2WOnwGKo9OHJ61zMGFCA3eu1qzjIL6UCyXnBrl+fcZq7FqSB4ejb5SQeaiuhuQOr6n
         Z86Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762456233; x=1763061033;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lFfrFpmsCLYcvDSvkVZLWhEoXtUNAYNym9Vpjc+n/O0=;
        b=iM6+KBpNnLa+ifiwzq9YnRcnVgWlbuBVZcSjB5ya0w8RyN67ZseNYBxcxXj6krUYHy
         FYCtVQoq8+oRSjB6td5Niz6nPzFzg00KA74E/McGMt36IQZa4CKRjL90wgWST3p7wihg
         R9uS61/uMY9KE99MsqSAeVVnbsPupObhIxUzGmghNsCOGlBvES5Cv1XmU22tHobCa5Um
         D8DT9mK8bZAtpmmpbYshb/nz4RPuc1Di5MrMmFky/CUqsQ+wKrvJvsU5fKnStPG9RNdB
         x+SUl5QXA5kGJ0WVxA/olbp6vzwAtabq71Tyju8tgf8m88DWLlo0paZbjlhOTqxyl4Is
         5QlQ==
X-Gm-Message-State: AOJu0YxwOltT+YHkp28t42Csi8wfm9HLoeeiM4v5FDGFmrtedl67sxC9
	y01xZz3FVx1PqPOZYRCr5+dVhax+FFvsmsOSht36VFz5tCafW8KD+eSKgRpg2g==
X-Gm-Gg: ASbGncsq14PuRG3Ce6mX6hg3T1Uex4nNwudfwAovFOWXc1E0+fFp9gbBqPJ99dD4nAF
	o9JfAnZIrarN864itfZl3WIhApwKglC2dPGTafR4Dscaj6WWRPEGd2swBG01lGj0nZifXJJnufy
	WNgMz/3wQQTUyXMY4tlleNddHYhdOBQhqtWcGic48X+uEfuwNOqbYU3Kywpaau3TIvye3t64pWL
	IRKxQoVZ8NOHri60TQtIL1qOOTRsX0H1LkqT+ixDjr1r2dd2H4de23ugNmS1yQWoxOs8NXElims
	EvcXKETya7gAIS0hR0tBySLRfl+vd8w1gRFXHNhICgySsqGmMwhDV6E57ncQ7yO5u3lDA2wG7xx
	7c2bjJsreNPHuTwPxANHZrYbCIFo/xI+laIVjc62wJDnSv73G3nhp7Y0lv2/7Pknhxz6aNru2X3
	+BmDeQQQ==
X-Google-Smtp-Source: AGHT+IHhqZwtILZ+BTrp6HypH+5Kuo3ZRuAu4N+7HVb13mdTJy7bsIS1N1Dn50GWg95OZzelKhmXKg==
X-Received: by 2002:a17:902:dac3:b0:295:7f3f:b943 with SMTP id d9443c01a7336-297c04387f1mr6931725ad.28.1762456232582;
        Thu, 06 Nov 2025 11:10:32 -0800 (PST)
Received: from [172.17.0.2] ([52.234.40.197])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651ca1669sm35563795ad.94.2025.11.06.11.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 11:10:32 -0800 (PST)
Message-ID: <690cf2a8.170a0220.960fa.097d@mx.google.com>
Date: Thu, 06 Nov 2025 11:10:32 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0307929300233605261=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] github/issue_template: Add basic issue template
In-Reply-To: <4ae9101b9ad8a521af68b0eede9ed33e752de65a.1762450967.git.pav@iki.fi>
References: <4ae9101b9ad8a521af68b0eede9ed33e752de65a.1762450967.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0307929300233605261==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1020579

---Test result---

Test Summary:
CheckPatch                    PENDING   0.36 seconds
GitLint                       PENDING   0.45 seconds
BuildEll                      PASS      20.40 seconds
BluezMake                     PASS      2864.95 seconds
MakeCheck                     PASS      20.36 seconds
MakeDistcheck                 PASS      187.25 seconds
CheckValgrind                 PASS      238.14 seconds
CheckSmatch                   PASS      310.06 seconds
bluezmakeextell               PASS      128.90 seconds
IncrementalBuild              PENDING   0.36 seconds
ScanBuild                     PASS      923.69 seconds

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


--===============0307929300233605261==--
