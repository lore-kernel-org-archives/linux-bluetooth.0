Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65D338DD9
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jul 2024 20:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720730639; cv=none; b=lJ/zF+KSmeetCizAh8IAUbmYfQT92HBAB4oi/9fSpowbRfWp674X2D0OC3PY/z6FS/cl3eo7l6CSWfKaIplAF2hqYrnmadeeIEU0d2B+jWEL/aTxEvwPfgTxQASod2ggJkEbSoO3ea/uK1gmqc5FPV5evnPkaPDemoPe5tZieh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720730639; c=relaxed/simple;
	bh=6Y2umjxuOOYMSYkiUnKMxxGkFC7Ghs9M5uLRhd0x8ws=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Jv9EI/Lzwghwxcn9gNV/sYRkh88ier1xllNP4Hm5QaZ0mgE65HcIoxw/snx4JDKK6WtZMwYVu5Z4THtAPbcG9UMwutfpyZXuQkscLR8YpRCIgckZrEhPrq3cvcuOsoguG456qlGrLd2u+lHETWVIjbgZkNefVpB8ZL5KFKLIqUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PHulfID8; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHulfID8"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-df4d5d0b8d0so1253417276.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jul 2024 13:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720730636; x=1721335436; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4CJbwp7ZSi9VsloR2XmUgPi+L4tdq208/fvy0MgK0II=;
        b=PHulfID8c+E4zEmgdOl7rNVuyyUNZDUGmzC3DO0MRNYwkVbwjMt/3h2WgKhqPhk+ic
         Kuz1ANX6MLO8xX7Yr7az5qgNc5/1ZzY3QVh/1TIaiQXN07cTkcPgQjdBy1GVbYT4rMja
         3zWFo3DoW4gurndF76NJNoYOyRp5odIOAFOyiLDu56HOWs+w8iLWfi7HtaVyfrAYCtup
         /FTYZTEObgFIUVLi9TWdVcxrLb8YzQgvrT5Q6r5xL104C39xp5z1ranom462uSusIW8+
         fPlS5Kg2tLiZS5u0jOnDuIRNx/O9wUEZyYDRIrKPFWG2Wb1t2Re0xnuKZ1tMBVk+ZWRJ
         /oWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720730636; x=1721335436;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4CJbwp7ZSi9VsloR2XmUgPi+L4tdq208/fvy0MgK0II=;
        b=NpJ8mzvb4Gz182fgxSwWDy7TUuD50XoCJhV8nH50GRxu8v0wQFtZil/8WiumhYcnoY
         YpDKAdbz2hItpdriPAC5Ta5No+SIo865KNU2g1i3BksNloVzsSLnYXWvElZcGhCbuADX
         yGZM/2B1E91K1H3jOUFIkgvLndFSueknQhVxXKs4tMcrjlhtxYcg+BqFQAJyeCERYu12
         IgXeKIcyluiXkt53YNhuLgjHVmJfsAkIZ8eK7zCyl+XSpocvWYaZtrNaujq+wyHn/iQN
         Kwc8lMyusjYQSy4pDiwDS/opv3xCwQlIY/I4zGcC1terje+2skDUNnq9HktnHhGXshpF
         Q73g==
X-Gm-Message-State: AOJu0YyQGpTeQo15Dt8km5kN5QGTIJwqMCkTsdFl0havYBefLK36EaNc
	IYJwzS9aS8VEJzTeF4q03Ublohw+osdMKBXTKD3oiUG1cTlh7+GINo1aqA==
X-Google-Smtp-Source: AGHT+IGdqTCCeijFxVIHslkD0Tb4CZbAcb2JAIGkoDu2VTptAYA5MzK9x5S4xsBnjzfUucjiLQlouw==
X-Received: by 2002:a25:aa66:0:b0:e03:5fee:66a with SMTP id 3f1490d57ef6-e041b123aefmr11567683276.42.1720730636642;
        Thu, 11 Jul 2024 13:43:56 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.112.126])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e0567fea53esm567617276.8.2024.07.11.13.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 13:43:56 -0700 (PDT)
Message-ID: <6690440c.250a0220.5a2a3.3241@mx.google.com>
Date: Thu, 11 Jul 2024 13:43:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3995483549604797010=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] device: Fix overwritting current_flags
In-Reply-To: <20240711192501.3699613-1-luiz.dentz@gmail.com>
References: <20240711192501.3699613-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3995483549604797010==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=870593

---Test result---

Test Summary:
CheckPatch                    FAIL      0.68 seconds
GitLint                       PASS      0.29 seconds
BuildEll                      PASS      25.33 seconds
BluezMake                     PASS      1684.87 seconds
MakeCheck                     PASS      15.57 seconds
MakeDistcheck                 PASS      181.07 seconds
CheckValgrind                 PASS      256.48 seconds
CheckSmatch                   PENDING   457.59 seconds
bluezmakeextell               PASS      120.47 seconds
IncrementalBuild              PENDING   60.39 seconds
ScanBuild                     PASS      1060.66 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v1] device: Fix overwritting current_flags
WARNING:TYPO_SPELLING: 'overwritting' may be misspelled - perhaps 'overwriting'?
#78: 
Subject: [PATCH BlueZ v1] device: Fix overwritting current_flags
                                      ^^^^^^^^^^^^

/github/workspace/src/src/13731021.patch total: 0 errors, 1 warnings, 108 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13731021.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSmatch - PENDING
Desc: Run smatch tool with source
Output:

##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3995483549604797010==--
