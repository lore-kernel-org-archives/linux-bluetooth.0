Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB8B13DDAE
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Sep 2024 09:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727254899; cv=none; b=d+WBJP4HFFJtZfBhL/3yvbG15xgJfNlzJ98rETGKWZmBrkFJZKb6akr1Dt8Ue+AHNdewvTG3NcQ3vEovVYBaoUyxyk0Lf5vjRN8OgH+FErQqTARdHax9ypT3oTixCFWacYBS8M2iZxlGRAKq8IIe6wZHit/8bDDo8009QdZEyJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727254899; c=relaxed/simple;
	bh=60oQALpyFJiv+eN3vt7UtJY3tZjgh3Qyjp5j+OjysAU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=QvxqB/WrVpob6+cnHsqMCvaCOqJGPvlouiLY8gM8BHR8Hy9pem7eiCC4YsphvCEismKNXCByUv65xZzTpnFTw1yEil4RmEkB3hLqof9TXyFgVJpNCHi+nub1QsZhaH3cf0pfS664HUhSsqlyZZ1iSGpXt2NLL/fN2oMqhelS9wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FyauGEJF; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FyauGEJF"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7acb0499ffeso611710185a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Sep 2024 02:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727254897; x=1727859697; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=64KTX49SiQsrDX60kQHzYRHq8Rsn2HHZKeGkuI7K8uw=;
        b=FyauGEJFFViL80xRppE2BQkySetm0IhPgXaW6X3G4aBN98k7zk51OR6fLr0U5oWRum
         Lm0IqYoKr9RNVv6wcpfbfS9/uTv+a/kB0BsIvZPTACviEQ2PNOXjG4T2WcbuN6+lzFKt
         +Eq9FLWKf0vin3lLIrL7XWl3K0y9ZBl6Jlwm2+pxHBU4+oCs1fK4WLCrI14Ss3nRYwFl
         fqplCV72vJ/52SLxcn2YfmughioMeMVLc6udvJ6gfUkDrOSjMh9sBa1i8AkmKvTVjsSf
         OSRSRIgmDBF4tibMjsZcRFLawYhqImyxekhidUrlWHjBRh3YBXYQ8NKenZm79cqO7Xh7
         97YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727254897; x=1727859697;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=64KTX49SiQsrDX60kQHzYRHq8Rsn2HHZKeGkuI7K8uw=;
        b=wd6Hgcn2XRmocGSCqW6K2cw8qddOs7XR47A0gWp12/rFQ2sIEmE8h5ZisPv7dmVgMZ
         T/6O4BggMgcgK/W5QNIPbSWC07KZqm0Op55JPChG1WcUqTuD21aE6QzxGmRTQ2xHEBW6
         YZjUrzorv3B61QgGkR/PgfNxNwEHkHUjzbmdm0p/K/Lxnm2eQSgX4IVYo5evLYJqLq9J
         io9QUblYR2wQ1S+hKj68hK6cu2d7vf/iazn5uYTNeNhyfkEE9poLGd9unK41us2GXt0f
         z75Bejfo22Z6fgkwv+R3FmVSDfcG3eePuKhTrgPqNtYcRSw+dAYKXZnFlNU0OioPY0rS
         +BxA==
X-Gm-Message-State: AOJu0Yzbk+JZ3+iHVPWkOvTx843DWByvFqgHSLrbyfCV5iUekZJA/kxi
	BotFTBIKu8Nz5gTyK96b8JdO59T+OmYAPqsMwvIsZScYS0HeGAA2+hPuRw==
X-Google-Smtp-Source: AGHT+IH0JnWwHedEU7WK+8HpUEbKqIk72zbNovRuY8PBMcMDHu9N3nYVwG2bfcyBeQ2XrsGT8BnYQw==
X-Received: by 2002:a05:620a:294f:b0:7a9:b904:d62a with SMTP id af79cd13be357-7ace7450ba0mr299762785a.45.1727254896557;
        Wed, 25 Sep 2024 02:01:36 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.14.157])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7acde53296asm154235685a.12.2024.09.25.02.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 02:01:36 -0700 (PDT)
Message-ID: <66f3d170.050a0220.318d13.6f06@mx.google.com>
Date: Wed, 25 Sep 2024 02:01:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4978364063903820789=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_chejiang@quicinc.com
Subject: RE: [v1] device: Remove device after all bearers are disconnected
In-Reply-To: <20240925073204.1499240-1-quic_chejiang@quicinc.com>
References: <20240925073204.1499240-1-quic_chejiang@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4978364063903820789==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=892676

---Test result---

Test Summary:
CheckPatch                    FAIL      0.71 seconds
GitLint                       PASS      0.32 seconds
BuildEll                      PASS      24.18 seconds
BluezMake                     PASS      1590.90 seconds
MakeCheck                     PASS      12.94 seconds
MakeDistcheck                 PASS      176.77 seconds
CheckValgrind                 PASS      249.60 seconds
CheckSmatch                   PASS      349.54 seconds
bluezmakeextell               PASS      117.92 seconds
IncrementalBuild              PASS      1470.89 seconds
ScanBuild                     PASS      1042.01 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v1] device: Remove device after all bearers are disconnected
WARNING:TYPO_SPELLING: 'droped' may be misspelled - perhaps 'dropped'?
#94: 
RemoveDevice should be handled after all bearers are droped,
                                                     ^^^^^^

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#109: FILE: src/device.c:3495:
+								"RemoveDevice")) {

WARNING:LONG_LINE_COMMENT: line length of 84 exceeds 80 columns
#111: FILE: src/device.c:3497:
+			/* Don't handle the RemoveDevice msg if device is connected.

WARNING:LONG_LINE_COMMENT: line length of 87 exceeds 80 columns
#112: FILE: src/device.c:3498:
+			* For a dual mode remote, both BR/EDR and BLE may be connected,

WARNING:BLOCK_COMMENT_STYLE: Block comments should align the * on each line
#112: FILE: src/device.c:3498:
+			/* Don't handle the RemoveDevice msg if device is connected.
+			* For a dual mode remote, both BR/EDR and BLE may be connected,

WARNING:BLOCK_COMMENT_STYLE: Block comments use a trailing */ on a separate line
#114: FILE: src/device.c:3500:
+			* disconnects. */

WARNING:LONG_LINE: line length of 88 exceeds 80 columns
#115: FILE: src/device.c:3501:
+			if (device->bredr_state.connected || device->le_state.connected)

/github/workspace/src/src/13811736.patch total: 0 errors, 7 warnings, 17 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13811736.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============4978364063903820789==--
