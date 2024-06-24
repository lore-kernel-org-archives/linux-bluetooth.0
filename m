Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF465A4D5
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jun 2024 08:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719218647; cv=none; b=QOlcL4zxZSXWrn+ETp4to4MMYSx5zE7c/aLdFyJthdwslzA90TBwHXEqh2KmaTfePkjtqIE0eqyxuiQtMPbfjwzmQk+jryKBo01bKbEPiz3BG1DJG7ECfZV412XOJaIfGbvUcsXGUACs9lst62MUa9O24lbHo0q3l+VgzeKJbak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719218647; c=relaxed/simple;
	bh=ZHx99obghUydesmgclHuKXKEZ4ScP1VP6w6DVkArr68=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=dJgNTf/TkZNWs6eYOTYecbQAmqh6LeDuIiezO8G3qdicOg3pLi1Vn7Wx7NlGuFJaRkmuDZPx9avKYDYdWp3NGQ1uODdWZbXTGhyI3V/71r0f/Uhv6KKHvXDogudYdetRHRgCttsM/Fn+hxe6pWk+58IppBHQmAQ3d71km13n07E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNgmo8pg; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNgmo8pg"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6b42574830fso17684316d6.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jun 2024 01:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719218645; x=1719823445; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=K+u+kIATQXJWGePVxhaVu0Xttg2r9a+10PXLfqt0MP0=;
        b=kNgmo8pg2DVkrT3hNG5BnVWAd5hD8igDc3zCeqclXEWu172536Thmgx/abmZhxBnNC
         qh9RDQXlYnZIS/lJpDwhdbatttlkQeQRREoD/o3plIWiKmtZuiZDuWUCpfwg0em+qsgm
         V+nFG9Z8R1zPVar1R1vjMM9knXUaxnZisorZM4ESjmTdTZ2qncm8MVUaEN+DYZl1v0Um
         jLUllFt1DV98MgO9K0KJjDE6bYQko3Vrcq0cSjnqGcS93SrKA86SlN77mN2j7ze8/iH5
         w55WkGOhaHReECQb1QExco3LyKcioXBTt1rZH6Odg35zJTkc8CDFPFcm7zyOyZxLCOBR
         MnXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719218645; x=1719823445;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K+u+kIATQXJWGePVxhaVu0Xttg2r9a+10PXLfqt0MP0=;
        b=juHYcZtSy2C603PxImezTHLHUm5DSWYfUMTk45u9+V4wqkLTVsDNd6xH0BRJjmgfs9
         rv5mw0VponpVcivMQdh1oVHLfh8Pnrg9UM0XBNhO9dku1mzulUyyV1ESFyOlp5barlcG
         UKYOo6MRM3Ud6/AR7ZFZiCoqvUpP6ilczEb8Hl0MmiaLw+v0L3uDFEevgTCwt0vhSWNS
         az12GaAbzRbvIYAklbEkXq8yH1++GXNC5i7lEvNi6MLTb3e+NaasDvDgDoRJr2ka8vya
         2pnD1jihhQIotW1mxTq+egDbBx+tvQvgrDl6DSAi95dn/VYMn4Qf7BSiTrKqXdySLirD
         wQjQ==
X-Gm-Message-State: AOJu0YzVArqo29NoJgN+BleGiI3XPgre8tYVCy8BI2GsYJAFsS4KKTq+
	ZY4KcKXfwQSY1vC4E7UIRym3VXnHodXJypyf7OsyC1l6OLiKmR61QUitjQ==
X-Google-Smtp-Source: AGHT+IEQe8oJiE3mlnJsjg1NKWUEzvzfhJkTLYE4KWI+LL2AEgEactOIFpT6glDaI06hEKoMOd4iNw==
X-Received: by 2002:a0c:c50a:0:b0:6b0:5fd6:c737 with SMTP id 6a1803df08f44-6b5409bf278mr41373946d6.20.1719218644666;
        Mon, 24 Jun 2024 01:44:04 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.147.195])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b51ed4bd10sm31957986d6.57.2024.06.24.01.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 01:44:04 -0700 (PDT)
Message-ID: <667931d4.050a0220.a284f.947b@mx.google.com>
Date: Mon, 24 Jun 2024 01:44:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0019773483561186911=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_amisjain@quicinc.com
Subject: RE: [v1] Bluetooth : Update the mas session structure
In-Reply-To: <20240624063627.22705-1-quic_amisjain@quicinc.com>
References: <20240624063627.22705-1-quic_amisjain@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0019773483561186911==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=864750

---Test result---

Test Summary:
CheckPatch                    FAIL      0.64 seconds
GitLint                       FAIL      0.46 seconds
BuildEll                      PASS      25.47 seconds
BluezMake                     PASS      1668.39 seconds
MakeCheck                     PASS      13.04 seconds
MakeDistcheck                 PASS      184.98 seconds
CheckValgrind                 PASS      260.17 seconds
CheckSmatch                   PASS      369.87 seconds
bluezmakeextell               PASS      125.46 seconds
IncrementalBuild              PASS      1529.93 seconds
ScanBuild                     PASS      1098.93 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v1] Bluetooth : Update the mas session structure
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#94: 
Update the 'mas_session' structure such that manager_emit_transfer_property(os->service_data, "Size")

WARNING:TYPO_SPELLING: 'tranfer' may be misspelled - perhaps 'transfer'?
#98: 
As there is no new tranfer registered during mas connect, hence setting the path to NULL
                   ^^^^^^^

/github/workspace/src/src/13709034.patch total: 0 errors, 2 warnings, 22 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13709034.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v1] Bluetooth : Update the mas session structure

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
3: B1 Line exceeds max length (101>80): "Update the 'mas_session' structure such that manager_emit_transfer_property(os->service_data, "Size")"
4: B1 Line exceeds max length (104>80): "will get the proper structure in arguments as expected like structure 'obex_transfer' and transfer->path"
7: B1 Line exceeds max length (88>80): "As there is no new tranfer registered during mas connect, hence setting the path to NULL"


---
Regards,
Linux Bluetooth


--===============0019773483561186911==--
