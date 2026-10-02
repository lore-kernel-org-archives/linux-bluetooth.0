Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14D825B0B7
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Oct 2026 22:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790978828; cv=none; b=rDDHBSTyvRSBA6xtK9sFuL1b5v1Qd3RUrn8tSvveHRJr7WYQ88oK+gfgv4ulr1dONM0yneIqpy/SELAPfy2G55Ibr/e4PXQnK4zeY7VBsu/4sHLbcWYEQrOWKkx+0dHktl62SVwUS2qhy2W7lNE4d0D9dci0KcwhVVC/aB5sBN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790978828; c=relaxed/simple;
	bh=iq7NPv29PazUOG6fRQGAyeWehq6YTtQikEuLhCYiprY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=LXlslu5VmeniQzolKUzYM+AtbUDLyZsouJfCaIDgMtNq31rnmw5Ouf09G38507rp5Oy/0Ojd4wN1p3deXOzgHL5U2d+91bN3ELxtdeWyZoEI+f9vWDG/Hvrdi/+hLA/AmjQ6Znh/07rcJzPgu9WUWouJrnREtNHvAenN2xCtmWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r9hRkwQ1; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r9hRkwQ1"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-3115c4451c8so56688eec.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 02 Oct 2026 15:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790978826; x=1791583626; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uS6Ahswo7Q1saGARE7k24iF57BHlxqgh7z4WtGnNpjg=;
        b=r9hRkwQ1VnTZdomLMcGOWPUDMDPc5mdBq5006C8nKfUmjO58aAPpSkDBb4/F455Tj3
         wKbi4IDcEab7L0Y70NPOgyzmZExjbxM2HLf4nETgHEans2k4fjYzd+zCY3qmL5PL/13s
         l45KLGLAh4xeEuxCwoZZ3PSYxdj6HfsylnMhTRfFwUTKx7LagaDrwKXZvXYWUA2Q7rns
         ylsr9XQrMOZB91p15Wzd9i4aWKUDJuAkN9o/v4QFFxOY5ekrGiJ1I7K81XImwKRXvDhh
         10PyaoIDiUh1qEG1uGgZ2ApxUZao8TAhhj8WxqUuP+OcLxdkhyqTbjxAU4/stiZ5kXXO
         TFeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790978826; x=1791583626;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uS6Ahswo7Q1saGARE7k24iF57BHlxqgh7z4WtGnNpjg=;
        b=UjBbqeLy4RWIFmKlQXqA6LdwJPbI98jt1Rij6bDtXOe0UaUIGwWmlKbqqNgn/5MEea
         E/hDhy89hzmekLfKFxB0NECWiNM+oPZcRELiu7kjNaTtJwvhqMFkydMcK+tRsSoo4RJo
         UUdwaFIZ1YbtD4L65wpS6GXribVlfaWHouvvS0aGEI8Bov9ckFc+dNTtJ2YK/BWQqYD0
         /r7cARfCIlMbb0nZNB1Hn8GI4tiA4Zf68WJG3bw6+gRKFxMu5Q9qReaWe0sOCkF4Srbi
         2lZ7op98NogSo0xnGSZHGapLr8l4HQZRpzt0x5at26XIlNpxAIzIbA+6ZybU2slMBL6t
         ORFA==
X-Gm-Message-State: AFq9FYL977CFgpe7PxxqC+97Mp81qqmIW1SAMuXeLJ2MZsHQckeLyvgG
	H6qS+1DdS2R69Inmrp8jMpCiuTtSyqYmH5hr/eKA1TLCN8qo5bCL28R70R/50Q==
X-Gm-Gg: AYBFou15gfFgaLZwkWv4AtU68yx0GAuEN+jRmmnQqdEY2xt6Xji4TRqgxGcszmkblHV
	j0BYRWOXmV60nPIeXqKlOLcyjxN95HKfT2OW5pppPFkNDjdRKJel+FHkcDxouuqdX6i7HrlMaHZ
	3SB2TFciPCnRokEufJkT8S2hWGEU+GNW1kgNMjXx294WP198JRg7H3o2tecvrcbhgmiPaaPcyt4
	lqqvWQWx1gvNYb/WPh71SkB2e3cGia4+nySdlZX8mi0OXinQoXgGLlOipeqcFtMZKXRVJdqQsQZ
	oHIFOiALhO9yKDeuGJ9YAhG/eI6TAHfSDBkRXGX7Qpwmu+r0frv3lYpvCgdFYOjWoZnIQ88Kzq4
	q60ph/NrX3/NGSeIETe03zq6s9VdM0CLBhTQLBhvyaxyF0pfckDlu2HtaRV5OhMJ8H+pgMtN+J6
	2zOVN9MKIcrJKn0Kue/WAgVCtk281XOMsSfNu0M8qEsYq/ikmWrcaJe5AHDylEY6rc8nsvt5MMO
	9Ph
X-Received: by 2002:a05:7301:1c1a:b0:34e:2150:e5a4 with SMTP id 5a478bee46e88-34e2150e886mr6882883eec.16.1790978825435;
        Fri, 02 Oct 2026 15:07:05 -0700 (PDT)
Received: from [172.17.0.2] ([40.65.59.119])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-351123070cbsm1227083eec.31.2026.10.02.15.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 15:07:04 -0700 (PDT)
Message-ID: <6ac02b08.84503012.2f9a79.6ee8@mx.google.com>
Date: Fri, 02 Oct 2026 15:07:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7269246486445389367=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,vRFC,1/7] monitor: Add audio quality statistics for ISO streams
In-Reply-To: <20261002192759.3071262-1-luiz.dentz@gmail.com>
References: <20261002192759.3071262-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7269246486445389367==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1178559/

---Test result---

Test Summary:
CheckPatch                    FAIL      4.07 seconds
GitLint                       FAIL      1.59 seconds
BuildEll                      PASS      19.30 seconds
BluezMake                     PASS      372.71 seconds
MakeCheck                     PASS      14.45 seconds
MakeDistcheck                 PASS      139.51 seconds
CheckValgrind                 PASS      228.69 seconds
CheckSmatch                   WARNING   288.24 seconds
bluezmakeextell               PASS      92.37 seconds
TestFunctional                PASS      1112.13 seconds
IncrementalBuild              PASS      424.40 seconds
ScanBuild                     PASS      1110.12 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,vRFC,1/7] monitor: Add audio quality statistics for ISO streams
WARNING:COMMIT_LOG_LONG_LINE: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#105: 
> LE-CIS: Handle 2304 SN... flags 0x02 dlen 4 sflags 2  #302 [hci0] 83.728300

/home/runner/work/bluez/bluez/src/patch/14864145.patch total: 0 errors, 1 warnings, 682 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluez/bluez/src/patch/14864145.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,vRFC,5/7] monitor: Add audio quality statistics for SCO data
WARNING:COMMIT_LOG_LONG_LINE: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#106: 
> BR-ESCO: Handle 257 [90:09.. flags 0x01 dlen 120  #1455 [hci0] 19979.296105

/home/runner/work/bluez/bluez/src/patch/14864148.patch total: 0 errors, 1 warnings, 396 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluez/bluez/src/patch/14864148.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,vRFC,6/7] monitor: Add ISO link details to the analyze mode
WARNING:COMMIT_LOG_WRONG_LINK: 'Link:' should be followed by a public http(s) link
#107: 
        Link: ISO interval 30.00 msec NSE 12 BN 3 PTO 0 IRC 4 latency 28880 usec

/home/runner/work/bluez/bluez/src/patch/14864149.patch total: 0 errors, 1 warnings, 182 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluez/bluez/src/patch/14864149.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,vRFC,7/7] monitor: Add audio quality statistics for A2DP streams
WARNING:COMMIT_LOG_LONG_LINE: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#107: 
< BR-ACL: Handle 256 [E8:EE:C.. flags 0x02 dlen 602  #15682 [hci0] 141.214796

/home/runner/work/bluez/bluez/src/patch/14864150.patch total: 0 errors, 1 warnings, 442 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluez/bluez/src/patch/14864150.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,vRFC,2/7] monitor/analyze: Fix a new connection for each BIS or eSCO packet

1: T1 Title exceeds max length (82>80): "[BlueZ,vRFC,2/7] monitor/analyze: Fix a new connection for each BIS or eSCO packet"
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c:2290:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3924:52: warning: array of flexible structuresmonitor/bt.h:3912:40: warning: array of flexible structuresmonitor/packet.c:2290:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3924:52: warning: array of flexible structuresmonitor/bt.h:3912:40: warning: array of flexible structuresmonitor/packet.c:2290:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3924:52: warning: array of flexible structuresmonitor/bt.h:3912:40: warning: array of flexible structuresmonitor/packet.c:2290:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3924:52: warning: array of flexible structuresmonitor/bt.h:3912:40: warning: array of flexible structures


https://github.com/bluez/bluez/pull/2623

---
Regards,
Linux Bluetooth


--===============7269246486445389367==--
