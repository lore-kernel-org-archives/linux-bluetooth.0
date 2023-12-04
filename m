Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AjKH2bDT"
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC66BC0
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Dec 2023 15:23:41 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-77bcbc14899so348377385a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Dec 2023 15:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701732220; x=1702337020; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=29NCI+ho3qsXjPrWLsax9A7WBMRgUQ8jq8F2dcLSSPE=;
        b=AjKH2bDT0mAkfe2TTaVTBE0ws64fNTokCnPOJFBaFEclDlmONDDvXtNEeILZ0hzvyA
         765L3YuDqe6J3h5SKkoTL8j0uVi/S/fNAGMTr/8oFaPoYYJU0fxP56AJ27S+6QB/du78
         RzghFfLfR5VjLjvaGJBwUCoRimFqU9V6L/GmjsGBUhAyAHC6/ZpxFn0jNtzoDOPEJv2h
         vgE5dlxzXyXJ5vjkSVJeOM53LOXlBuKxwlVpJVg4su5rs58j6druCmp7LfTOI8vDR5gw
         fzxZ2TvrfLrA4bAh0ah3aybTKLwIRaRxu4CtJ4h0fZoWTWgtmQt9JLIRiP7FfCmGsJhv
         sz1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701732220; x=1702337020;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=29NCI+ho3qsXjPrWLsax9A7WBMRgUQ8jq8F2dcLSSPE=;
        b=nVp9LP2cLdXGoarlyjzaPQ7neCGY7BSySsiFIFCh2a3dlkQBUXW8/8iF4Aco38YNcJ
         GADQl91s299+x+D9icx1bWnWlDosvm8nrI3nkI6qbVTyX4FF4LaRpRnCXuZF68ggzv7N
         ErZuP3tqkcR9dePmkKdX3Z4/O7fp8/U3b2y4OsCKtyxt2zDZHx2vl29X21temcLr9tgl
         CD3oLmI8k/6U6LdocoIGk2eSFnsjUz4S6ZZ13ZIN1luTgxb4uj1YNMYVTJ2VO7hJKbt8
         8B8/sd1Pa3yHtUMRQ/Rt5z0Xd1o5Cw1ppcDcOsovldBLpRYn1huBrrYvdn1jE4uHbxfD
         YEcg==
X-Gm-Message-State: AOJu0YzQU+RTIuJKFjIe1cl8rQL+eDqnKwQRsqaOtQtsMB7xBRWS18ct
	S/OGHwzBcj9P//0KoDJ8e/WJXR+tzAE=
X-Google-Smtp-Source: AGHT+IF2mHUbSkk2d04/Hf4s7vlC1S+0yaL+a7gjXXq2pZ8QI5cPwMFUMDetAGQ8xgSHw/Q6brKtYw==
X-Received: by 2002:a05:620a:a04:b0:77f:eca:34d4 with SMTP id i4-20020a05620a0a0400b0077f0eca34d4mr425690qka.99.1701732220578;
        Mon, 04 Dec 2023 15:23:40 -0800 (PST)
Received: from [172.17.0.2] ([20.81.159.85])
        by smtp.gmail.com with ESMTPSA id r1-20020a05620a298100b0077f15eb3528sm547931qkp.70.2023.12.04.15.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 15:23:40 -0800 (PST)
Message-ID: <656e5f7c.050a0220.c046c.3ee6@mx.google.com>
Date: Mon, 04 Dec 2023 15:23:40 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0882849552380958705=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] shared/vcp: Fix comparison of values in different endianess
In-Reply-To: <20231204220711.2974630-1-luiz.dentz@gmail.com>
References: <20231204220711.2974630-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0882849552380958705==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=806818

---Test result---

Test Summary:
CheckPatch                    FAIL      0.72 seconds
GitLint                       PASS      0.34 seconds
BuildEll                      PASS      24.02 seconds
BluezMake                     PASS      550.97 seconds
MakeCheck                     PASS      10.61 seconds
MakeDistcheck                 PASS      150.28 seconds
CheckValgrind                 PASS      214.53 seconds
CheckSmatch                   PASS      316.92 seconds
bluezmakeextell               PASS      96.83 seconds
IncrementalBuild              PASS      502.93 seconds
ScanBuild                     PASS      920.45 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v1] shared/vcp: Fix comparison of values in different endianess
WARNING:TYPO_SPELLING: 'endianess' may be misspelled - perhaps 'endianness'?
#72: 
need to be converted to host endianess before comparing with other
                             ^^^^^^^^^

/github/workspace/src/src/13479146.patch total: 0 errors, 1 warnings, 20 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13479146.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============0882849552380958705==--
