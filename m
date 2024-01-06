Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86954F50A
	for <linux-bluetooth@vger.kernel.org>; Sat,  6 Jan 2024 21:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HlKT1wQ9"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-680c7cf2ab3so7055046d6.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 06 Jan 2024 13:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704576638; x=1705181438; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QhZm3ApsYM6TV9s4Wf24A3RnOpdDDWf0SvCw4GF7tvQ=;
        b=HlKT1wQ9djEawMpts9pFZ1EKv4SsAca0ZrmbFwirFBonkV6tFl6+PbbeB5x7e2OsaQ
         W3zyLycWMKX12NcGuUBrRvZKbKXzloJRUNhr7gn7EjDpaKmx1GZULPELzyf6A1NnC/LE
         S1KgfHIHtgJ7RqFy0n77ZpfKUnID10w+ObcA2Jn8b8YiONNZXEPplM2NSzNNJoVPk49i
         8919wzixAtLM3qkYDAgoSy2/ZO6jqyiFOSNPIzljPgQTYVkeA0zP0iPink5vtizMQF++
         8YjzjY3uyVr9Jaiw/7Jd78IPEeIYghcbcNO0rddmPX/JXkO8iQ0fFQvG6xVPPTO3FlaE
         BymA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704576638; x=1705181438;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QhZm3ApsYM6TV9s4Wf24A3RnOpdDDWf0SvCw4GF7tvQ=;
        b=g/Ire4YZVWGk8OlyjpKfUpQY1DonW4/B54v9pT7zx8O4Ang3/OtmObLeuwFgo/NwsL
         B4nNMt/kwYjGbbpEBqIfnJE89I0xZ9C3ygzVSflDgNtktTNp4fNZ2UD+hkZYNIheHqB9
         iBcnjkugn/n1bWno1OwH5DcNZTlzrrfSWAMtQUHzl6gZB3T+hlO7lpxxZ6zSx3R+Gn5d
         wPO+IwcVWSYZZfNNeVgcU00tkOTTeFXSdBoeVnuSseddAiA2o1RJtihxYpVpsrQ1YbN6
         rlgaNqoPu8bRw4T/JIE9KfSaAsvpPqZa2Hs2fyNEG9jtgru3PsdfyEsW2Q4zUr4LzlnD
         xVzw==
X-Gm-Message-State: AOJu0Yxmsa7wp7jmmSHZVmTgT+AeR6U44vqDyV30pvx/zmynf2poMge0
	7hFOBH0TwaYq0M3Bph24pidY9ChqtIA=
X-Google-Smtp-Source: AGHT+IHHrkPvILJOmNQ1OaPAFZM8Xx6SdokMFNxvZSjO8rYvjizNpu3MXRXpbFwM3pvEPO4lRTSqUA==
X-Received: by 2002:ad4:5c8e:0:b0:67f:af66:c9ca with SMTP id o14-20020ad45c8e000000b0067faf66c9camr2309281qvh.72.1704576638160;
        Sat, 06 Jan 2024 13:30:38 -0800 (PST)
Received: from [172.17.0.2] ([20.75.95.163])
        by smtp.gmail.com with ESMTPSA id i14-20020a056214030e00b0067fd4a002d8sm1635409qvu.19.2024.01.06.13.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jan 2024 13:30:37 -0800 (PST)
Message-ID: <6599c67d.050a0220.6488.6df9@mx.google.com>
Date: Sat, 06 Jan 2024 13:30:37 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8430291421062379547=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, contact@willowbarraco.fr
Subject: RE: mpris-proxy: add --target to target a specific player
In-Reply-To: <20240106202926.8106-2-contact@willowbarraco.fr>
References: <20240106202926.8106-2-contact@willowbarraco.fr>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8430291421062379547==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=814860

---Test result---

Test Summary:
CheckPatch                    FAIL      0.67 seconds
GitLint                       PASS      0.35 seconds
BuildEll                      PASS      24.14 seconds
BluezMake                     PASS      729.72 seconds
MakeCheck                     PASS      11.64 seconds
MakeDistcheck                 PASS      161.70 seconds
CheckValgrind                 PASS      223.47 seconds
CheckSmatch                   PASS      328.29 seconds
bluezmakeextell               PASS      107.09 seconds
IncrementalBuild              PASS      658.87 seconds
ScanBuild                     PASS      950.21 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
mpris-proxy: add --target to target a specific player
ERROR:INITIALISED_STATIC: do not initialise statics to NULL
#61: FILE: tools/mpris-proxy.c:56:
+static gchar *option_target = NULL;

/github/workspace/src/src/13512791.patch total: 1 errors, 0 warnings, 26 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13512791.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============8430291421062379547==--
