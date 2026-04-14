Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A83C29408
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 22:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776204168; cv=none; b=I0H1thoF93E7JvxtnJ4vLb16tD2YF8Uvy2kurCG3sHR/Qez/ulXtK13KLcToQ+PmR0Y869XYz+tkwjD9sBQnzx4MTwSr5gKSXOl15OZsd0Fbk9ZImnM7YkC1r+eZMwTYDVXki6J9ytQpPubjH+knPVpTOO6WSIm1vT9zyQs93Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776204168; c=relaxed/simple;
	bh=z+Ht0EAwKvz1+gRMHdtfKwHO/SgyALM534fi73ovF18=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=rB/GkhxvJmzZAMYbVjFtKezxMTGAUmQVyJ4aLd/xrJbgbi+a69Od7rCgWv9BB0D8DjRKnmykq3Watu5dHfO237CryBRbgqJnkDmtsdd+F9J3eogNE/ATdRuT0SA9eu7LCOuTyhcB5pa9v31u6VAvZhYMYdYVr3qx4ihpoZPpHrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YSvP9WHR; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSvP9WHR"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-50bbc41677dso85775671cf.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 15:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776204166; x=1776808966; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2UP3qQtCxy7ClXaMl/nHTBQw+vG7OfKthmjIT+AFDsE=;
        b=YSvP9WHRrdSZt0sDPtu8+Zjk6iM8/761L+T1Vhrw86Xyul+f6Ame/U3mBnvO3wbWOO
         DRvuhagHjD2Nq1nhn8Xp+sILTywWYYAHT5euuPgO5VqTKsT68WwdaYKH/lvfJ7oDL9TC
         LgT9bFAU8vDNSVV8hkJcME5PeNbcUM8bGdFNaO9mz9jx7/J+rb5C0gbWdjPySCM1x6w0
         9V9vAYyY1I7c26zUPgG5VwIuan06jSCvL9auhN3pH6mk6C8vnI30uf5+4XdEdxV7pNao
         +sodQHMKr32t9asomMGFQs9NLSlqrMxlPmP7JhqIm/6SIBI23fEIQfipgs01Ok72WXLu
         ZO1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776204166; x=1776808966;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2UP3qQtCxy7ClXaMl/nHTBQw+vG7OfKthmjIT+AFDsE=;
        b=eN36JrxcuLHR+HYKzgcV0Nvr5A/4HthImEJG11GaSstV5SPXWWvzVzODQM9juqmmEz
         PbO/gVzjA32+ubkFW1dN9nhTFk+EUlIPvWXvH5wybqrTeHpLd9rSqgpLQQAXtDTEj/HS
         73vDQ1JmUXqjTIv3E7axwEPG9vxOgR5Ipa5WmMLo7D7AK3e1Ln3drqSSYeJ1YWKDJVuC
         W0HzYaRHmrKEzcO2VQQtHB9/ctcdoOz5vIP6zy6HYMKcgDSXCus+ytAWQFwlNIaJDLeo
         S5yDJFQGvrXdGYLuso0KBZ+QHZwKdZyFVgdwz2MnUedR6KBTPs4dw8KKFY2mBTwDZj6U
         NaFg==
X-Gm-Message-State: AOJu0YymwEEpryU9AG+6/DXlXOOlq1DjKrMZ8Op9wCYgjMh+w4H/4/dN
	u47Z089INq0std8DF76VjAMkW2lOhxNGCd4YhcNsylxDTnO1U/TPp4bq9kn4iQ==
X-Gm-Gg: AeBDieuxAq14YSypHobkrMIlEgFcH2ExUuxRwC2IfcT827p6nEoZOsk+YwSF9biyHR5
	I/Z0QFPlg0OUObIJR8KwtSddO7erZjVCfVDLbTrYwNwu1cG7LbzrxfsfKyK/PBS/TxntIffwH7j
	7zO+gkKIQFo1IMu9OeHt2AlbWW9W7LAsKQI+JZX/oWKAOyI6BVL0mLlfL87PuCGt46ZMrySA9dM
	epd2HiViRryhvc4/e7PE3D3kOjO3TnLz5WiDAtk89HTvm/WMD4UqC+/0klt4QznOs9lGeXebQGW
	/zr7Cd45gubRkO++ADqL/9RMdWx8zo+olBa+McoCeGPOx4yGvls4zWWodqPF2XgwOzjT1VMI+Fb
	t+TfgIZ+QcoC1Clxii9Llt+fgsCRd7Ng0KcEOSMqR7lICLxJL5ysIhCqm0iueTCBYJDq1vWxesy
	br9UXZyykPCFAMbQI3uZQK51X5hhsCHCQI6cgdjvtgWw==
X-Received: by 2002:a05:622a:a95c:b0:50b:1adf:89ba with SMTP id d75a77b69052e-50dd5cc6a5cmr237489271cf.40.1776204165682;
        Tue, 14 Apr 2026 15:02:45 -0700 (PDT)
Received: from [172.17.0.2] ([172.172.87.244])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50dd539c981sm113747661cf.4.2026.04.14.15.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 15:02:45 -0700 (PDT)
Message-ID: <69deb985.050a0220.151edf.26fb@mx.google.com>
Date: Tue, 14 Apr 2026 15:02:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7500839427248391999=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2] bass: Fix crashing on BT_BASS_MOD_SRC
In-Reply-To: <20260414190459.161947-1-luiz.dentz@gmail.com>
References: <20260414190459.161947-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7500839427248391999==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1081265

---Test result---

Test Summary:
CheckPatch                    FAIL      0.46 seconds
GitLint                       FAIL      0.32 seconds
BuildEll                      PASS      19.97 seconds
BluezMake                     PASS      610.01 seconds
MakeCheck                     PASS      18.73 seconds
MakeDistcheck                 PASS      235.34 seconds
CheckValgrind                 PASS      274.55 seconds
CheckSmatch                   PASS      322.65 seconds
bluezmakeextell               PASS      164.79 seconds
IncrementalBuild              PASS      610.16 seconds
ScanBuild                     PASS      924.97 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v2] bass: Fix crashing on BT_BASS_MOD_SRC
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#101: 
 #0  queue_find (queue=<optimized out>, function=function@entry=0x58b8761109c0 <setup_match_bis>, match_data=match_data@entry=0x3) at src/shared/queue.c:230

/github/workspace/src/patch/14524659.patch total: 0 errors, 1 warnings, 40 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14524659.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v2] bass: Fix crashing on BT_BASS_MOD_SRC

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
9: B1 Line exceeds max length (156>80): " #0  queue_find (queue=<optimized out>, function=function@entry=0x58b8761109c0 <setup_match_bis>, match_data=match_data@entry=0x3) at src/shared/queue.c:230"
10: B1 Line exceeds max length (125>80): " #1  0x000058b8761127fb in bass_update_bis_sync (bcast_src=<optimized out>, dg=<optimized out>) at profiles/audio/bass.c:1824"
11: B1 Line exceeds max length (126>80): " #2  handle_mod_src_req (data=<optimized out>, params=<optimized out>, bcast_src=0x58b894661be0) at profiles/audio/bass.c:1862"
12: B1 Line exceeds max length (143>80): " #3  cp_handler (bcast_src=0x58b894661be0, op=<optimized out>, params=<optimized out>, user_data=<optimized out>) at profiles/audio/bass.c:1910"
13: B1 Line exceeds max length (182>80): " #4  0x000058b8761bc978 in bass_handle_mod_src_op (bass=<optimized out>, attrib=<optimized out>, opcode=<optimized out>, id=<optimized out>, iov=<optimized out>, att=<optimized out>)"


https://github.com/bluez/bluez/pull/2036

---
Regards,
Linux Bluetooth


--===============7500839427248391999==--
