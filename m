Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DAE4749FA
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 14:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787234848; cv=none; b=gbE3qQebeo85OfLIX52aAj5WFtcBDm1Xu8zffG38fGXctLEGRqeGD+pLGkSO++mVebZMBoNp3m0ELow0O+w60HkEaJCgs2drP23TOwWvt3D7aqWm9V1LzZnpmVBUOVmEAdryel4XZKn2EIdFW9JpiLHJCQcl5kPTKxDlMaXm3KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787234848; c=relaxed/simple;
	bh=MhlnDTfoX2Io8CQ0FJq+Ws3UXLB++0xZKLnu2Xvrd1A=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=GTsb7u+X9kGgDNf34abYNyAJWhXBAGa/iWIqeCCr06YjJanJLsIAkyDmxh4/R6h9oBFLY8M+UGVh0IbX3MwjVb1wdJf4tJj9NG70NHY3bNuxlpsIRR9dHcRdDqepxfbDYGaildByoVtRNYw5Vw9BG4fMpiw/pyBLgc+HEsetPi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nK/qF8Ao; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nK/qF8Ao"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-902e4af2d9dso6915016d6.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 07:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787234845; x=1787839645; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9qimJda5nP/1lCa5fQ5xUurfP1oVtLy2t2tB381j19Q=;
        b=nK/qF8Aoo8wDwfbp6UCccgcfT7RRx74deTCo2GhIUinatagZKu08Wiz7gthlHLPKjC
         2Unb52//g7QrpDkh7ejet9Cd5fuSv/VoNaVhJgGPNk+8QfvtSD8pGOK4sdvVH6OtVPJ5
         nLAEVEyuYYXwQoOFPb2FsB2SvTOr0eVG8wjspUfCIPUarnT58Ne72BqJeHoffaHxuzTl
         PFKtfAmNRtXfjG/NcOBdefxkpgqKUvIQGM/G9Jn8JHnoyDjlqtFvf8l5WsDHlQDrceLI
         O7q/vbS3VbI1p1oXS3hMrW7t9G30MaVlewi6uBahpdD7Qv/gL4cPIE5UvkY/8pzbzwZd
         pAag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787234845; x=1787839645;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9qimJda5nP/1lCa5fQ5xUurfP1oVtLy2t2tB381j19Q=;
        b=XP/J9r7FaXDnw0FaT+YPxX49FNE/hS3BhEeMHeOxe+oEJqLs4vjgduY5DuRtVZuMo4
         1ekmLW3gWeNAfCyackp6+QXg5aInPGpUuGqL/by2BjBbOqqWir1O5F9ipHLpF4qyIJ1P
         UVVOJTbNHgefAJ/zwBD1oa5JpPfJXn6EOHRN54qn/RoQvJXPPLuU89qOSjeqqGGmQYS6
         8Ekr7IT8la4PS5KHLQInjC6u+cfHEhsEzsM/eXBpGgmOY2VWOBLrH2dJxRFC4Wc5oVld
         lu097avoGk4p4zYEpcprrxIkkHSTn0Jby2picRk9X7Bd7chdCaFImTD1NmFkEmi77ho5
         1zWw==
X-Gm-Message-State: AOJu0Yy6lPfgTDFiNaxK771IZX3msCnpLkXwsD3JBLj9m7aOPJIfCdCD
	XjzrO8tc7X7U4tp4DrebJd41MWIsYutfaIYtB+IULXF+nxMNDVBF5ryLzWtJDw3Y
X-Gm-Gg: AR+sD11427zCIaR8vV3GXmZzPNmarO4585CET3z/EyS4Q9CSLw4ORHFWe3AF4Dp9IGJ
	htfRnGxYFyAw/4P+AUDfZbK+Jxb/umIMrYN6LLjVTPAeftYsLSEp8xL1nYUYkBRXNKzBeRJKpY8
	7iWJhm9YZ97ptuKiaCYu5njb11oNZ2PUg0hRRSkrSJ5ZPICQMfghpnvBx5lyou/iykI+lW0gPup
	Ooq9tdK/fcn/EYJuMjOjFwBT+uyA0t9QHE8dSnPtiN1TYjyIkQJALSFpCo8YlA4WQhFGZiHOSdG
	YKjRUnDpm64+MCc694rsvC7nfNvDbGswU/bwVBR8zKlQZ2NJfTi/94RKNgdXLS8LBw3JCVI34vb
	5gIof4RPgMsLcBBDwK5UczjHm4pH1XF3rGKH2ft9Z39KwmIWg4o/3oiqVHgT78AkrvQ+of8jsq3
	l67Rdc/asRhBbP7bsH1LeM67m1WwmA1+Tt2jGQ69Ygupe6H2JuVvh3w8m44ikPqB1t/Es=
X-Received: by 2002:a05:622a:1481:b0:527:7406:56c4 with SMTP id d75a77b69052e-52de3006d45mr59858971cf.11.1787234845338;
        Thu, 20 Aug 2026 07:07:25 -0700 (PDT)
Received: from [172.17.0.2] ([52.179.88.114])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52dd8749329sm30860581cf.25.2026.08.20.07.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 07:07:24 -0700 (PDT)
Message-ID: <6a870a1c.e54e182e.35ffa9.737b@mx.google.com>
Date: Thu, 20 Aug 2026 07:07:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0902683999771988462=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: mgmt/device: report link security level to D-Bus clients
In-Reply-To: <20260820125806.1253547-2-frederic.danis@collabora.com>
References: <20260820125806.1253547-2-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0902683999771988462==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1149110

---Test result---

Test Summary:
CheckPatch                    FAIL      3.20 seconds
GitLint                       PASS      1.89 seconds
BuildEll                      PASS      20.78 seconds
BluezMake                     PASS      597.08 seconds
MakeCheck                     PASS      19.07 seconds
MakeDistcheck                 PASS      161.48 seconds
CheckValgrind                 PASS      234.44 seconds
CheckSmatch                   WARNING   318.03 seconds
bluezmakeextell               PASS      104.69 seconds
IncrementalBuild              PASS      670.84 seconds
ScanBuild                     PASS      1003.67 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v2,2/6] mgmt-tester: Add Security Level Changed event tests
WARNING:BAD_SIGN_OFF: Non-standard signature: Assisted-by:
#74: 
Assisted-by: GPT:GPT-5.3-Codex

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'GPT:GPT-5.3-Codex'
#74: 
Assisted-by: GPT:GPT-5.3-Codex

/github/workspace/src/patch/14759244.patch total: 1 errors, 1 warnings, 163 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14759244.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c:2002:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3924:52: warning: array of flexible structuresmonitor/bt.h:3912:40: warning: array of flexible structures


https://github.com/bluez/bluez/pull/2419

---
Regards,
Linux Bluetooth


--===============0902683999771988462==--
