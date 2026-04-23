Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD4335B62F
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2026 09:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776935521; cv=none; b=CD7o4Ed2IRSjRp/gM6C61tml3BHMSkLSi+fur//ZEWb7aygjGBrpb+vjzl2RC2eDhcP6yPjC50MSwXmNzkkeEPBU/83YP2ZT2kh7yiHUL8sFgJBNCTMyUSQ0/RprMc0j5CdEMgODOQJXM1j3naa/i7wsbpkYoGloDvL5b+rIQwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776935521; c=relaxed/simple;
	bh=AUmyiegvMe9JbMUWJBMuKOObNXg8joE+/BJNPXuYlv8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=N0fS/FIou+KMTKEiveIrOjimBURrG+cdJoaKvVnd6HPQic/W8LG/ffrnrT0P7ql6zXbTdwIhSyBVHnK5RkGEOn8sSNMAOplJOAIS7hHjZnVRJu4Ypgt2XF67+lyyapymmkhMMbtgG/O2N2sEFkgWB8wfVRYu6rHi7uHGQWdDVSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RYthzbuc; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYthzbuc"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8f0a87e23daso119515185a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2026 02:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776935519; x=1777540319; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mcQ4llvpD7J2xeU9MPmxKXnILUmk574vyoL1S4N9zRY=;
        b=RYthzbucvfa2H2DEJCPuyC2/pEL3NFm8/7ImE97QzQz21BiB+gRW/6NiFjCldhLusM
         QpVL0BdiVi9tdNqeeuyoi8JnlKRdNi2Z09Ua8O5/wwGrm79DbxlU5Y+wgZnEcu/cVfZH
         GZaLRPj0R1NDVXTA3nbdqfGB6p/KaMATuJsULgHY19hNt01v4geq5WXT/CFjP83tlPGV
         EAYOt2JM7M9qnnnHUOLN0cASgc76XNDUppMfg6/rbvbeUBnce+mLkFW+sYIuyLh8lnBP
         B2AhnkyWwgbOh/fw65LecDA+ybUaZ5QyGLYh5jMsiVQumFLP4LSTFHxmqMlBDSdOluWZ
         x29Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776935519; x=1777540319;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mcQ4llvpD7J2xeU9MPmxKXnILUmk574vyoL1S4N9zRY=;
        b=BLCW+V9FRI9hxKsvJ8PqoofjIGo4PhgQHf6yhWcAaaqhO8WvtSCveqJTx8vA91uCTw
         9PaJbMtiOC/bYq41dzgttCvFEgFrLYFXvm6GZ0Y7RuTX29Pt0lPPcEoeyoUREhGMMSbq
         k51EktIj+2NthIu2IdJnwQi8lrt1oy3OsnfygzJ0mwXGbKtpt7nQrkV+T0xELPNErptO
         frJYbIUTOumIjB103g7nKYoYJko5Th41fIyvoQH8Q2Nv/E9wUzSpezCFvuYliDY3TcTx
         /qTwsahFRIptsKPM6XB8Nx7C4LvsuN4QV67rWXb1h6P5rJ8/ROrGylksJ9Km1lbeiSeH
         7myA==
X-Gm-Message-State: AOJu0YzeW+iZWW1kEtsASLjVxjQFhplRe5FPy3jaaoDQqM9ATyiV7+/H
	2gZbXbOUzpeY8MZuAqtiwuJPx0WaTOOVNj51g1VWUwszSKUdXynDoL6/4lQVTA==
X-Gm-Gg: AeBDievXuk4EZZ+sz60VfZWpyWYdaAUKWgpSBLCuOZ1+hGzZEdv+N2vxHXvhIC0R2r7
	E10iSua9K1CQglzXRkSit745zYUSUuswUd4CmTqcp3dIqAbDC4ExJtO+9Y4oaXrIt/Z8f6AYQqp
	lvXohxnC/Kr+slbJH9ODWbqNwtFtUscO+/G91WIrsAP3OI7c0DMj+HdeAWvs5v0pmklGOWZeTxy
	to8VIW0z65KZ8j2l36hbnuXK0SFR4oPcKSswbds63puUtnAOAAH6TqMQx+3wuCSUOX/wD5oAUGx
	ePxlxM11sZgc5tqUQFL2wetY7lcRDccGgIi/zNfIMlSvW7kN5Y8wiEPEFjxW3DpKfSbFfUanHis
	n+HotHTSX1kx2TEflK5ZqofQmxQ/fSlDmXMBo65aOs4pE9A5SpfFc0k3dVKNuaA3++nflzl5T4l
	tYbPQp06pNxUfC0qmsuKlMbk7ggU0sRHnuzQuU2iU=
X-Received: by 2002:a05:620a:1a0d:b0:8d6:39c0:e6b8 with SMTP id af79cd13be357-8e792a5dfeamr3731150785a.61.1776935518927;
        Thu, 23 Apr 2026 02:11:58 -0700 (PDT)
Received: from [172.17.0.2] ([51.8.121.161])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d8edb734sm1761727685a.29.2026.04.23.02.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 02:11:58 -0700 (PDT)
Message-ID: <69e9e25e.050a0220.38ea78.4281@mx.google.com>
Date: Thu, 23 Apr 2026 02:11:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6181724224053460596=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ,v2,1/3] audio: Add ability to force CIS transport Links property
In-Reply-To: <20260423075309.493820-1-frederic.danis@collabora.com>
References: <20260423075309.493820-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6181724224053460596==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1084559

---Test result---

Test Summary:
CheckPatch                    FAIL      1.65 seconds
GitLint                       FAIL      1.02 seconds
BuildEll                      PASS      20.80 seconds
BluezMake                     PASS      660.92 seconds
MakeCheck                     PASS      19.20 seconds
MakeDistcheck                 PASS      248.30 seconds
CheckValgrind                 PASS      297.58 seconds
CheckSmatch                   PASS      352.78 seconds
bluezmakeextell               PASS      183.93 seconds
IncrementalBuild              PASS      654.86 seconds
ScanBuild                     PASS      1020.42 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v2,1/3] audio: Add ability to force CIS transport Links property
WARNING:BLOCK_COMMENT_STYLE: Block comments use a trailing */ on a separate line
#109: FILE: profiles/audio/bap.c:2672:
+	 * by bap_stream_set_io() */

/github/workspace/src/patch/14534951.patch total: 0 errors, 1 warnings, 204 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14534951.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v2,1/3] audio: Add ability to force CIS transport Links property

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
15: B2 Line has trailing whitespace: "    before passing the connect event to all streams belonging to same "


https://github.com/bluez/bluez/pull/2064

---
Regards,
Linux Bluetooth


--===============6181724224053460596==--
