Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD2B26FDBF
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 14:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778509740; cv=none; b=i2GlF64PFXCzo9wSpeyBWYl8+NIRSjjDXE68UeCT/GTecf2FpEdS3l6gEVjAOgxzjMNWcu2hLVBq+eXrhv16dZKBzt66XEqKsfbVBAokQ+qdUaWEJGxHLSPcA65lphLf404mdbPRgv2uKuTQi7RWKcPcT9CnuFXCsray3Gy1CxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778509740; c=relaxed/simple;
	bh=bs6Dp6XJXAnyeN0l/I2Pw/p53l/aqqCoYuCSWGlQXgA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=lT1untCgC5CrmHoggyPB57T5HOSJVHIJIyXj9uV04SdHo5SgwUzzeNeXPcbQXG1nsXTd+dH32uADBgpPxlHvPzVKecMkQvgY6If/dnfwGsSOgbgULna9rv+3UlSGEc+XdDdiCbbtV8cDGXrsQmu6EodbOHtJ0AxXZEoT3HCKEj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZqBVw30a; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqBVw30a"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50fb8e9a4edso48665511cf.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 07:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778509738; x=1779114538; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=miLtHA+GObBQv4OxE2DbLtHNq2kA/ClxNlHgToi9gwE=;
        b=ZqBVw30akI5Qmo19ZpaFKx4sHta1Tt07jVGrw2DtiWqP+KNcFf33uUI+KeDFfd3fL+
         gl1nAE56IK1Ny5LyxYNY1LlzUDI6tSn38BLGBxewZ2zKBaDo/K4T894GRjZa2leNmCDj
         LIa0iwKrAZPCjWy4r+/w4u5oBbBHSIDpGruRgz1BW/uuX+WQ9bPOdZAAYj9mgJBE/UlZ
         P2Y9CYW//e0p41cU7L4uuEBMQeqhClNW6MPTkfIBYSMr9VzI2n43C7O/FbykwuAwK5dV
         elmSqFCzQ7oMTL93amufhkODWWvp3N6R2NLpHN2L0POTbW4arLao8IsZ7F4wnJIw7Hzg
         5RGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778509738; x=1779114538;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=miLtHA+GObBQv4OxE2DbLtHNq2kA/ClxNlHgToi9gwE=;
        b=VKEiA6GHEzyW8A6mOw3vJ2gZsAtYUB8gtwA4DtzKq/yxFzSC199K5NxACIvX6XcXuo
         qOeHz03+DOVPXjBKAIPqyWLRKJObpwp+L/imCIkIiQoKn/ft5eByjeGV/RmbDyHI2B7X
         BVwYJMe7tTCgqCMBAVP2EBt/FRViAdia6eNwprckc6XPG3hH+Ut3SLo13n2WveX73832
         HvLbW1ifGHb22zhG1fjye9920CxD5E+kjnWnC9l49+fhcQ5k3mSBCBnxIWVAp/9lTPeC
         L5RH8VtcgLeri52rXcWq9/GGIAFLKLLSPOoMVlKwz59J6yOatAG9gj359Z4JvvZK4Ark
         3/vg==
X-Gm-Message-State: AOJu0Yz/A1FA6KpCxO9yTZ8L7QwE8UpiGvsTKeociXk890oNoVvmP1iQ
	9E+PNhboMdX7uCcEDTta/OfW8HgnqxCHK+8Smmd0uS8UEgWbVllPFzuqMiGiew==
X-Gm-Gg: Acq92OGnUq+YbpcclTJHYEFm6tnRiCSmITBAp4nNXWxDqyLA8bhLuNFqktcHpWg/VHP
	mWYbGaxkL/s6eOGkGHcOHh3Tw/Rc3CSP9cVT13mAiMLORnEtCk/gwRRltY+KP3Sb3timCb1VRlF
	zSY5DRwoAz4s7kXzOTEHDlYaqhFB5Spc8ztItsJX3sTFRLXMd3J+BaETRmQYJiCkCLNZPVHjr4s
	tPXU60RogPV/Sbn1jmB2fAxlWSENt83IulSlY1h6AocW9ELUvQnNs8dZLSfJhSKe3murt99sf2p
	GQ1uUj7GajUDGqojR0umQqQ89YaarRzgThg2f3GVpoiiEeEyvl6R5ahBYLDAm9sS5CGtH5hWV6e
	mIQ45qayHrrAG9dfT3kBPcIWwWps9UrGMIFchAc0r4ORFfVTOQw/mEeeY8zkLb1Mvva7SDDEKtD
	Pwd/EfWVy25/mlOXU1lY/n1YaEqoaYqbIucnxI7rCh
X-Received: by 2002:ac8:5acf:0:b0:50f:be4f:465b with SMTP id d75a77b69052e-51461fa4526mr344113471cf.33.1778509734677;
        Mon, 11 May 2026 07:28:54 -0700 (PDT)
Received: from [172.17.0.2] ([74.235.126.87])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e677e63sm91977081cf.12.2026.05.11.07.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 07:28:54 -0700 (PDT)
Message-ID: <6a01e7a6.050a0220.1ee0c9.9515@mx.google.com>
Date: Mon, 11 May 2026 07:28:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4142178928907000313=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, raghavendra.rao@collabora.com
Subject: RE: /bap: Handle CIS loss during streaming
In-Reply-To: <20260511105845.8008-2-raghavendra.rao@collabora.com>
References: <20260511105845.8008-2-raghavendra.rao@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4142178928907000313==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1092705

---Test result---

Test Summary:
CheckPatch                    FAIL      0.48 seconds
GitLint                       FAIL      0.33 seconds
BuildEll                      PASS      20.02 seconds
BluezMake                     PASS      607.34 seconds
MakeCheck                     PASS      12.70 seconds
MakeDistcheck                 PASS      232.61 seconds
CheckValgrind                 PASS      253.53 seconds
CheckSmatch                   WARNING   323.06 seconds
bluezmakeextell               PASS      164.34 seconds
IncrementalBuild              PASS      607.15 seconds
ScanBuild                     PASS      915.09 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,1/1] bap: set QOS state when CIS is lost while the state is streaming/enabling
WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#126: FILE: src/shared/bap.c:6720:
+		queue_foreach(stream->links, stream_link_io_qos_disconnect, sio);

/github/workspace/src/patch/14565299.patch total: 0 errors, 1 warnings, 50 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14565299.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,1/1] bap: set QOS state when CIS is lost while the state is streaming/enabling

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (85>80): "[BlueZ,1/1] bap: set QOS state when CIS is lost while the state is streaming/enabling"
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:312:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:312:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:312:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures


https://github.com/bluez/bluez/pull/2116

---
Regards,
Linux Bluetooth


--===============4142178928907000313==--
