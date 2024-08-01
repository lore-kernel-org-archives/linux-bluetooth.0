Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81F415252D
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Aug 2024 11:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722510288; cv=none; b=bUZOssN41BLg+Fnx/KZwWSpaufsK3k0ibBbeeA3BNe96LPUNAL6zdtyTQ+rJ2nCEsjbJc4Vrdd/Ziw4W5azqDPETnCd6nO86HUd2eSDg4D/+/45LbpcYbXf/bAOY0Vj1T1+nUev+uzlUL/rJQhSLaSBaSHMUauKnZMFPoww3uD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722510288; c=relaxed/simple;
	bh=oGO8RclwQYO7bJMvF1RUCtBw/qH2b0YA1am7IN5uPZ4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=oFTG2pAcHxkjz8PTTJFiZcuvwcbxw/ccjvrfFQ4Nosu66+XeV07B2M5U1FU0eU6DbdY4TP6JnHrJpzcq0ndwGmxVpwxOHLvj2zZIUrDw4LBx/viYp7Y6Cm3FCgJcZSCHluFP9I4B0ZC6k83PpNZ89Yuv/FgZHXmrwz+TaMBIh3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yddq2v7p; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yddq2v7p"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-44fe106616eso36942751cf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Aug 2024 04:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722510285; x=1723115085; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ORlfPOnMNbEwY3WlJ9AINVpVIxHIB2V/NRTGpwfDjKY=;
        b=Yddq2v7pgg01+roW/9fBy2fdB10NtyDyo01lYXgcwdveffSkSViL67ahvp18Q7Jr5T
         SpKjILEtz0HYw1e1DSK2fNpGc8awXqRjNcLOAHuS6NTVGrUXUjswhVoaQSi/4KhpY77U
         hpOIDpk0GvaVW2cT2KT4p9BUDjrfpJN+Fnlkl63QYrLhy9BO2Olf7F4u7NS1SqjcNtJL
         Wcl5yDkVxAfOusWIfUeOpd73hN/eeXXxMVsF06Hn12yPg330+RXxp528TGg9u0U6JUK6
         UBA4mOXKej9Fm2ndXRlMnZoZRKzQ7P64IL1Rj3Z+9hqpgY2sD9zxUepcfNb6lXIQbvSK
         8XfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722510285; x=1723115085;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ORlfPOnMNbEwY3WlJ9AINVpVIxHIB2V/NRTGpwfDjKY=;
        b=nJRBm1VGg8ZDtzQ3vBeWtDhMFQrnjaDp7WMHgmckPD9XIPjJzl+mZO4eb3TLhQUpH0
         81Nq6gMVUHqKZDqQhjd+dkytir3yYTfwkg98YehXkb8UGk9q3n5S7RuN/rZ/gXtqU3iY
         t6C+7noT0K5mPaHckZXzpGukkqRpMoqrXh7WJ0ZMX0xWa3pPSP7eJsMHB+tZdGZhk8TL
         sy0DJY99MSWDWLVWzJCBpcljsLnP26CaDa45gNbOvBykHx5j9+eUsifLCNQJ9bBGtr35
         iVD/cHsjWBpjT1BhtJ/mlYaRgnKLQN5xJHimdaTnWyCQK2v79PM6uA0/Ch2Ov98jVNPV
         gFkw==
X-Gm-Message-State: AOJu0Yx9fePxzdPQgOWD6uDeiYo08/yJLS++5MtNL5o+OkTCLw8M4WNr
	V2+JN4huZMwgS+RJXhw0XUfJKFuwOXlOTvU8mndx0KfAHPH6lxvfz/nNbQ==
X-Google-Smtp-Source: AGHT+IExBmf4toIyIAEkKjUpj9uLwgnA40s1u6u0soEMgQdVySzgkaDfhwucaW1SwDfAAj5znK30vg==
X-Received: by 2002:a05:622a:1103:b0:446:5368:cce4 with SMTP id d75a77b69052e-451567f92bdmr26887001cf.48.1722510285463;
        Thu, 01 Aug 2024 04:04:45 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.154.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44fe8201925sm65886471cf.63.2024.08.01.04.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 04:04:45 -0700 (PDT)
Message-ID: <66ab6bcd.050a0220.b4736.5f7d@mx.google.com>
Date: Thu, 01 Aug 2024 04:04:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3517235381047415474=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] shared/bap: Fix overwriting sink attribute
In-Reply-To: <20240801093010.144495-1-luiz.dentz@gmail.com>
References: <20240801093010.144495-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3517235381047415474==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=875834

---Test result---

Test Summary:
CheckPatch                    FAIL      0.61 seconds
GitLint                       PASS      0.34 seconds
BuildEll                      PASS      24.72 seconds
BluezMake                     PASS      1755.86 seconds
MakeCheck                     PASS      13.24 seconds
MakeDistcheck                 PASS      179.97 seconds
CheckValgrind                 PASS      254.36 seconds
CheckSmatch                   WARNING   358.99 seconds
bluezmakeextell               PASS      122.74 seconds
IncrementalBuild              PASS      1503.67 seconds
ScanBuild                     PASS      1030.77 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v1] shared/bap: Fix overwriting sink attribute
WARNING:TYPO_SPELLING: 'overwriten' may be misspelled - perhaps 'overwritten'?
#91: 
overwriten by source and source_ccc attributes.
^^^^^^^^^^

/github/workspace/src/src/13750084.patch total: 0 errors, 1 warnings, 16 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13750084.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:288:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:288:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:288:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============3517235381047415474==--
