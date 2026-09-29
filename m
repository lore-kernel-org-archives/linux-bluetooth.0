Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A1A385D8A
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 02:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790647965; cv=none; b=oqKOfrAOMCQIYbpNKLOxi6iCL6nZcQR5WCA97mGLgPuKt8/dqxYlnM+XJo/B0bjzh30wU011iW9GwIRmK+qiW1caNy3URepLeYMk+g5xkV/6cxi3tj1ZPjWhuHyiLEYHYXtPxjEZPFDAvk/CNz/tKkqzbFsQhtOdktxcx9mpJaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790647965; c=relaxed/simple;
	bh=eT78qXYOg64lRWRduII1NHcGX2+MMQxEZ1jWkKk5C7k=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=BDsYmI7bny1aUqK3DveK51Kkq+rnm4WvDW2QbyFD4INZw+G8pqyikbkO4mg5ZjnEGvYog0VHm33+B6MXXZm/Y5EOhxIjss7aXZS8kddym34P6rQH4csSP9F+xaXWpv0vqnd2MjQc8ihrh/9LfdCbq5oIDzyKoS5sMnO8FUwJQes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MdxOI2QP; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdxOI2QP"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-398b3b189e0so1944643a91.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 19:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790647963; x=1791252763; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=d0soc6LmdeeKrhG+nypkoU35hK9YRuhy8+gKOBwJKhY=;
        b=MdxOI2QPcROl0Vqjbt/9dUjvPN9HG5Z0hTsyEDYkDJ6eUju+xqu1m9jh2YzTAtycQG
         7SmpSh9SSFzLnJOds3hyJn1GOyTBL7f5c1QG+1Ytd7UY2n7C0kaZEtJPrnsK8ZjAFe9t
         vY2PVogadvGrWokfzAw7hwl+zRiTZbXVToZ/NV9qhaXaIUdW8gxCGRs4UwJOH9LadoSD
         x8rb/WByu+2x5Q7SS5v0hiifBIiniyrPaRIvtWvuRKhDzefsDf86exT+99g1gRhqj/78
         xodbJMLydbd8NRF3bmqMVD5OtmD9RQP2KUIrMsXe6D8xodUwBDwgjZKGkpssuS2TJQlU
         gS5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790647963; x=1791252763;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=d0soc6LmdeeKrhG+nypkoU35hK9YRuhy8+gKOBwJKhY=;
        b=ePZ05VjrulF21TOXgI/EfEzucv6aR36zB63EMfRMP3ihrIQYvbL7qxSwz0mgNrNyqn
         2pR1QFgDHieAxTj0coyCGsL7MGoiK4hL8TDEnnjtTH8pJQpQUSMiLLwaTaTejvOz3qux
         3OVq/bQPfkyG71BxkEc6UdVxFU8N3MhkeAS0kUZOppPsRUYz7fcfNe1RTHPJjxHY+Na6
         UEY0YqoFQvJqoG2aZUCyyWEPudspg5TtG8FVzaumUiLSe9GGW6DGaHDBeL0viLKexKf1
         bzwGWRUloIBeawZhz61/+53g/MGUlL2fY7FCK9E+MMhSosKdFAjnPQu2gQHyK+xPBu++
         ki+g==
X-Gm-Message-State: AFq9FYKhwYdRLiqBCWIB7n2TkBwNYRxMYrpuJLViTou3PyVGF7T6kkmo
	aJ36SWubKwCJpDZpxXPLtpClek8y0xtZQ0m39wjZdxuj46cCi5SWtOybivro+4rV
X-Gm-Gg: AYBFou1xqB1ZG+48AcfzuXu6FxsiNoql39ziBx1mRjgVCvsSMIB5CxbH0NaFf3A631r
	cNspSp1fhy8zjrxhg3cgMXxKUuBkvqoHHkf+5PC7F+68RgYHgXVBXWmPBsBtsNCp4l758p2WMzY
	DhM+Mwsf/hDcERYC5lpH8bL0A4vG0G/wMUAyVeyyyS/WSETxbfndAFDpHktmjwiNCRqr/VqArPF
	TdN+QumpMhr1YttZLP2tF0FMiL8eYuFtTsVBAsszfO+5Bw/FWcPshb8MedGtST4KQDC73+Wh50K
	79tCtUE40DasOiWOd1hREf5NlMAJRe9jlI7zZTOA8mfD7IyfsM+/cz3lKcRMphLe9/bjt2uf2rI
	V1N33OkDZSi6gj8nJraEyFIl18JaNglusjzkiASc2csWyKYfgolv2Vc7fWwAiRTG4Mm9Ux87Li9
	7szxljUl0IbiJ+Ij8J27Azi5ZZhWyZrcN6X/ow01sWNx/XBUU3LohKIyf3GolraGMbVXh/dORRM
	4OKxQ==
X-Received: by 2002:a17:90b:380e:b0:3a0:bcc8:1544 with SMTP id 98e67ed59e1d1-3a0bcc815bfmr9805701a91.39.1790647962889;
        Mon, 28 Sep 2026 19:12:42 -0700 (PDT)
Received: from [172.17.0.2] ([4.155.101.195])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a49869b9fasm2648766a91.12.2026.09.28.19.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 19:12:42 -0700 (PDT)
Message-ID: <6abb1e9a.c052121c.e20bc.a199@mx.google.com>
Date: Mon, 28 Sep 2026 19:12:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4447152374688038232=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, jmsmg1@me.com
Subject: RE: [BlueZ] mpris-proxy: Line-buffer stdout
In-Reply-To: <20260929003432.3937487-1-jmsmg1@me.com>
References: <20260929003432.3937487-1-jmsmg1@me.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4447152374688038232==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1175670/

---Test result---

Test Summary:
CheckPatch                    FAIL      0.31 seconds
GitLint                       PASS      0.22 seconds
BuildEll                      PASS      19.24 seconds
BluezMake                     PASS      372.59 seconds
CheckSmatch                   PASS      290.15 seconds
bluezmakeextell               PASS      92.76 seconds
TestFunctional                PASS      1105.85 seconds
IncrementalBuild              PASS      383.28 seconds
ScanBuild                     PASS      1119.69 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ] mpris-proxy: Line-buffer stdout
WARNING:BLOCK_COMMENT_STYLE: Block comments use a trailing */ on a separate line
#108: FILE: tools/mpris-proxy.c:2958:
+	 * it line buffered to get the messages out as they happen. */

/home/runner/work/bluez/bluez/src/patch/14853746.patch total: 0 errors, 1 warnings, 10 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluez/bluez/src/patch/14853746.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluez/pull/2603

---
Regards,
Linux Bluetooth


--===============4447152374688038232==--
