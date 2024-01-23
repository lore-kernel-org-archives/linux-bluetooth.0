Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACE07E799
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jan 2024 16:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706027534; cv=none; b=g0olgbPu9wKKoHO+XJLRaaT7cZp/Poxz5N0Gohn7xWlqMNdTxmgs9uGobHXYmZWchd/Y4RU68I4jwM7W/vggrnluTUiqutfVoVB2gNUpzopi6gv97E248jrFkvfGBzATWk8pQlhFnWowqo946jx3mzbhYFyPi/JSxLhQd01yO0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706027534; c=relaxed/simple;
	bh=gO2RFJeIdNvY4Z/wzauCAIXcu6S1uGF8HY1kCs+L+U0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=nEa3EuHkQxX/VMopmiR4Mv9ymPfvElIkfZaqpzTamfHMoPLMRxGYHe2EJ6jowfRjUkZbH+SGfPagDewyCrCCG5rzqL3FSEC2wuMGArFC4Gh5aHJaaY65AgpCH9eUo/k7AMk/bJIx8BZtAXevkTAJ2ScTu0pTQKSr3JcOmdVUpTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UTz+DF2K; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTz+DF2K"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-42a49d42f06so7390291cf.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jan 2024 08:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706027531; x=1706632331; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rt9uZXcTaxQJcMEE9d6fxar7wY91uRaXhbmhZu7IXEs=;
        b=UTz+DF2Kiw8HSOaLoHhjlmdSRdPFuA3bu/+wA1c7LG76wgreLPjbWeQqwCNG17oKr4
         0FF2QGG5I5eCFHUfG/TpEgFmyQwUjB3RQ82pogLXRCCwMY0JYGUxKoKV8cfoyIkMPgWV
         80GsQb4jYWlSq4pr92BhduYXAvsLJviWNOnYphZ9trOPrXUVvFLZt7mv0AWeTQtNAbvs
         Koze4Md7L6yvi95Xi4TPfeNwnVcIbXfmJR68w+uWZ44RJm4r6E9cHOTxzrLlG46LTaNk
         A/mTNR8kGHSSq9cMjsJuJU3bTK3APNjCzmBaKiuJFg2FPC85Dw8qO3HsPNHJo5Bzw03c
         OJqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706027531; x=1706632331;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rt9uZXcTaxQJcMEE9d6fxar7wY91uRaXhbmhZu7IXEs=;
        b=F0MI+cRS9HM3ekKjqDTUhOSHfiTH4ROT/sdqLkcdIU/zKvpshG41DMMNMZAmuerqvj
         CVbEJXStL6LhTW1+vhm2zW/P83dQ02wbzV2LC5KwevSP//tBAz1HxglM7KsusrnbaK5S
         yoK3q7wdzkgo+x9qmFgUGB+GyJ5JLqow/La1fb3oeuBdWqodTtseZJ0mJveAXc+KWQ0V
         uD5+7EPv1QiHKhluJjMx/owtfvL7sfb72AaBhkDghtLJMiVChQ2nhIHF4kVMc+i4QVlq
         FyKjushOJ2/ZO+VBrxFwZAMBwJ7WEMDbGgGx+eWqqnf5iIww9mhs9LIUY0SpuJg4Ksbx
         vMdg==
X-Gm-Message-State: AOJu0Yyzj2Z+NKCcABnP4iinKbo2zE+2nHI39BZUwppJpzSfv1mZ/VZH
	pB/CN+2Odw1K2TWnQujEWUfYca4KwghslSz8ZYyBKNqP1YNpmIv30OXAb/AX
X-Google-Smtp-Source: AGHT+IEh9kkARbs+4mk0ZU75MVFtuKhmH5BRK6FFPwjByqBKKlhm6kxmoglZckuTrNuSuHOQnUSCLw==
X-Received: by 2002:a05:622a:28d:b0:429:9183:45d1 with SMTP id z13-20020a05622a028d00b00429918345d1mr1121401qtw.81.1706027531088;
        Tue, 23 Jan 2024 08:32:11 -0800 (PST)
Received: from [172.17.0.2] ([172.183.51.240])
        by smtp.gmail.com with ESMTPSA id bq17-20020a05622a1c1100b004299f302a7csm3608344qtb.23.2024.01.23.08.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 08:32:10 -0800 (PST)
Message-ID: <65afea0a.050a0220.a650.d880@mx.google.com>
Date: Tue, 23 Jan 2024 08:32:10 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3888409969692934717=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] isotest: Fix not handling 0 length packets
In-Reply-To: <20240123152838.2880053-1-luiz.dentz@gmail.com>
References: <20240123152838.2880053-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3888409969692934717==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=819151

---Test result---

Test Summary:
CheckPatch                    FAIL      0.67 seconds
GitLint                       PASS      0.28 seconds
BuildEll                      PASS      24.13 seconds
BluezMake                     PASS      742.53 seconds
MakeCheck                     PASS      11.46 seconds
MakeDistcheck                 PASS      161.37 seconds
CheckValgrind                 PASS      222.53 seconds
CheckSmatch                   PASS      342.82 seconds
bluezmakeextell               PASS      114.90 seconds
IncrementalBuild              PASS      695.80 seconds
ScanBuild                     PASS      942.32 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v1] isotest: Fix not handling 0 length packets
WARNING:TYPO_SPELLING: 'sucess' may be misspelled - perhaps 'success'?
#92: 
means their status is not sucess.
                          ^^^^^^

/github/workspace/src/src/13527606.patch total: 0 errors, 1 warnings, 16 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13527606.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============3888409969692934717==--
