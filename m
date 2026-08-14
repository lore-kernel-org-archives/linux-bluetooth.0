Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF8939150E
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 19:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786736638; cv=none; b=pG43y6Jcyu8WTXNmn+3TbEtMczpERqi0GR8JWrIb7C+donesu9rUTJyWN7F2Y7aHrjD8cvQOvgq8ajiZtFB/hm1Ew6ZwFRAXzpLpCdGvr220o4ikJJIHQVqEvAVYKU5/Cvu3v+lpG/8yZcr5k2bbdkUnpIySrmOAy9+WsC27NYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786736638; c=relaxed/simple;
	bh=NHANSfOH2alspUteN41Yn7KZ6mA/11vhn/QUECZjjgE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=LV75H3l8EwwJoJ7TCT3Qs61iW151Ont3KaCuNvUisz1edylMLHVOk6OiP0CGK637h3onS3vJxkBjmgGdlZw2wTn0t03RL8/Lo7tll3b1lrGuyoU4/H7xanDDA7EKZ2xebdpgsbLG9OjkBiS4XS2Qm6eAPzOJVoETvA8Al6hAKTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o+Et6RRK; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o+Et6RRK"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7ea9c6ea7deso1000602a34.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 12:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786736636; x=1787341436; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wKXqsXCZ6qjgWW32kY8zwLqs9w03kf/fQhdsXuM5+OY=;
        b=o+Et6RRK2g3lwRtgBWWIfnk9O2UaJErtHATNP1uI8ylq1CjgPS2zEnTgZYzyy226Gv
         SPpm9G+rMg3y3CmZP+S9n7qjht8W8MqoCq2cbSmSB3PAHgwefNbkNQimcm4lgv7HHc9F
         uuOz2f9zYMcPyFY0mHKW+HWp8ylkdxaTyiZEDvCn9l6t5TOZou4YJoM1XyiAjPH0rTxc
         UMKbPcvRxZBcTCIT5APmCuH2C4D/1O65rtFCjad8v3OokmWyy8li09Yny7IEw+bHYfxO
         4JDYH6EkiUiRYfjxkn/doBoNTZeBOW51SCTxsXuNY3y8aWXuoIl/4xIhx9zOHc1kYLrZ
         Ro+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786736636; x=1787341436;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wKXqsXCZ6qjgWW32kY8zwLqs9w03kf/fQhdsXuM5+OY=;
        b=ZxUkmzDeHjYUl0KrFZwiHHuZxm6yQWyyBBFtlSlInSqgTUM15ij/D6wMpWGu0xh12Y
         v/2IOUE+4bUoqOdRMV7FthFDgmwD/bFD0EZcV9br/irKnVT9p88CXsmFaMgadhGCi4Ls
         FOYhlzL0/rYE9xr/aCA5uU5p+I/28RGFIFa/AFrDBv1UZo8qVumWWnvzbEH7tyz+zLTp
         5Hnp0fN91XBiKD8pOpWnclGid7Grh9WQxEvyzqE0xVl/g2ePY1bgleEY5/YsuAt2/jxH
         M4BohTNXJlYaF3UqXzfhqShvUQT7f6vWp9hvShzgHrzXc9XKPiM5phAqKlsVW6NBPwGF
         fA+w==
X-Gm-Message-State: AOJu0YyJ04S2thwCFHtbfc6Lg+Lnp49Re+CFwLX61843ebzYIWbzRJ2z
	Yn81ziTs1NS6wW2nrFEvTQXsUvUdQrzYFLfCsSPH/XvVZKNudCyoHPeqyCjv4g==
X-Gm-Gg: AR+sD11jWSws2abHqMaaTea9mIWCrcIXhVctEZVnioxpVqkfldyUxl1O2KIBB3yIiZ1
	TrwzxizsMcZlSZDhY0pzK0LTGpkiPDX5sl4imoNXDuGRMx0bzj2cMvKJrrEY/lP4JfgNj/+aVxZ
	4QONDXAwTmhAbcANeYFuIpd86mtDlZkRxu14Ujb2yRpG3LANno6c1p2RmKFzwQKne3zfrKVzZha
	ctEUBgFSHHjtO6/Q9Jz1lxXGi7EkFA/JpW6TVz6IrNJ+qvzzN/hPK9KqTYY61jWad4/n5da9z5n
	8PFf02kTcd0To9askSNruPQ0EKebZjDYgxADcPE8tzVDc7tkmVBHLOp5D+EutXebEasJdcaaPxQ
	CcJab+GaUfN5NuZ9YyhSPS6ADXzzxpFh2QHhdEPL8tmm4cSGs4AXOHGtGQcTfmIKXrt23oY7mEQ
	+1e+XHAWWQqo1S1HyKMBKhXTu5WKSujtllgO6R1gjqWhKBjBCLoYeWiQMRgzB4kXbQE9mjthRkh
	LPEro10iCzCpiNQkmwq
X-Received: by 2002:a05:6830:2106:b0:7e9:e9a0:9a8b with SMTP id 46e09a7af769-7f3de6c7832mr8234096a34.16.1786736635629;
        Fri, 14 Aug 2026 12:43:55 -0700 (PDT)
Received: from [172.17.0.2] ([135.232.208.137])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f3e86685f5sm1600063a34.21.2026.08.14.12.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 12:43:55 -0700 (PDT)
Message-ID: <6a7f6ffb.afd65eb9.1281f7.372c@mx.google.com>
Date: Fri, 14 Aug 2026 12:43:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0607571736555283728=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/3] sdp-xml: Fix leaking the parse stack on malformed input
In-Reply-To: <20260814174731.1441738-1-luiz.dentz@gmail.com>
References: <20260814174731.1441738-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0607571736555283728==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1146225

---Test result---

Test Summary:
CheckPatch                    FAIL      1.60 seconds
GitLint                       PASS      1.63 seconds
BuildEll                      PASS      20.52 seconds
BluezMake                     PASS      569.56 seconds
MakeCheck                     PASS      18.91 seconds
MakeDistcheck                 PASS      153.33 seconds
CheckValgrind                 PASS      222.76 seconds
CheckSmatch                   PASS      296.58 seconds
bluezmakeextell               PASS      101.80 seconds
IncrementalBuild              PASS      595.61 seconds
ScanBuild                     PASS      876.15 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v1,1/3] sdp-xml: Fix leaking the parse stack on malformed input
WARNING:BAD_SIGN_OFF: Non-standard signature: Assisted-by:
#115: 
Assisted-by: Claude:claude-opus-5

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'Claude:claude-opus-5'
#115: 
Assisted-by: Claude:claude-opus-5

/github/workspace/src/patch/14750740.patch total: 1 errors, 1 warnings, 32 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14750740.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v1,2/3] unit/test-sdp-xml: Give each test its own test_data
WARNING:BAD_SIGN_OFF: Non-standard signature: Assisted-by:
#116: 
Assisted-by: Claude:claude-opus-5

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'Claude:claude-opus-5'
#116: 
Assisted-by: Claude:claude-opus-5

/github/workspace/src/patch/14750741.patch total: 1 errors, 1 warnings, 47 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14750741.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v1,3/3] sdp: Fix memory leak when freeing alternates
WARNING:BAD_SIGN_OFF: Non-standard signature: Assisted-by:
#120: 
Assisted-by: Claude:claude-opus-5

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'Claude:claude-opus-5'
#120: 
Assisted-by: Claude:claude-opus-5

/github/workspace/src/patch/14750742.patch total: 1 errors, 1 warnings, 35 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14750742.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluez/pull/2403

---
Regards,
Linux Bluetooth


--===============0607571736555283728==--
