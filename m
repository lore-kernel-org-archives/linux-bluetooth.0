Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3639B343D83
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Apr 2026 16:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777567728; cv=none; b=qKWa3PYhEsqziMPi4uXWZdBTpi1nGI9BbofecHjcpEve5oiqZNcvvhvvwE1se600y7kOTdX4zRSI1bn7bvHorVssHo49SDLfh81Zvqrf6HrWei3J6ndSUSq/jO1ykacbEfmg9WMvLTzPbRxLmVoV+YhXivldXXWi6oPVayG0beM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777567728; c=relaxed/simple;
	bh=DtXy+K9ykB5vndNL3ZNPQpYbqimvYOXnQytTdFVYZuM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=YLDv6MTEU397R2oUvYP7CcAiCtukot4eDQQjZQ8/jM7FlTeEXQu63xLtjHwyitu0fQUjES+9WpIOFpYahOcywU7s5G4iwfCzwVl01DRIdr33hZzZYMhJiDxw5VFizYutwhdfbEKZ3K2kGehcDSM8YytxagLL4bTXqRWjWuDWB7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cs7AQU41; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cs7AQU41"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12c726f46baso1882958c88.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Apr 2026 09:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777567726; x=1778172526; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=icS4F4H4Nywr54anTll19SA8A/Yq0RbIvlWxcAnJh70=;
        b=cs7AQU41FElDUjAS7FbFZEozPiE9CegMsfJo0ifIpx/wBJ+qMwVjiUlBSgi5ZKLfl0
         MxVUhVA8gTJO4QpcKhL5GTPY7zJ1Wp/6cvYQ0o/RaF/1Or1j/scv6U2MOcGyYQIds7Xb
         CQ9N+wQPrN8iAEaQlcuLlXyqYIH7Jty9PtwMuaM8ceT4dhFWs5PuzhKBDJQCpDnH1T9d
         SEUGrz6CWdVqOXumUToQ5uztIYOstFIG7HQzCja4GscJbwudMTlJpeaajbs5N5pdstE0
         UDzqj9Z1jO/b3mNvrT7bwUVMGZ5PXODZ8kx8e+OymKrbki9/UGXl2QNkwY/Zu5RoNVUJ
         SmhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777567726; x=1778172526;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=icS4F4H4Nywr54anTll19SA8A/Yq0RbIvlWxcAnJh70=;
        b=ElAzmirA1gd4bZc8OwhHlTeeGnprbCKOtnZ6ZMy7574m+t5bo3YGoylNV4Yvb5WM6N
         TriuxqFJ7Ad+lkC73hU39vu4wFT0yVvt72tTWe/zUHSobsIrgwDOvXSQOlHcouph2Ys+
         w3105wUgL76oQgdU1udaghK51fiSWkaNbTJmfAQB5YFakNsaViGtQZssmNnD3OE8eg67
         6E2l1LXMWUToqptZkNydv0MFH0T7/lvm11K0ssA4inyvQWfxSCW8ImNBUXm19Z/MCpP+
         q2vHpOalbClug1LmJQXib1PbVqWMHdgXFHRwq4Frf4nxb6PVrTqeBvbopbDQ1rTFANLg
         0vig==
X-Gm-Message-State: AOJu0YwSefgH8fcXMZnf8kPeaGpUv1zIK2UZN0g0MNKm1qDwCIzYhjaZ
	8ujjM/0avnHboNoYqBx6v/ThFWM+GCxV84gfNJiighAj41QcMxLLsmqLBpwCwAeJ
X-Gm-Gg: AeBDieul5I9fNMAMW0QT4Bk4D4KsG934uiDMQNwqxyDeRDERDK6ZibJRRiAsGs9UHj6
	cQLyvpLujXWogj3YX9Be/nBqpryzr8Z7Nv9C9zyAnPEMyxgR7sy/hfKtWnzTplF7cPB31Lo4efI
	SOjUtH4RdjQqemvTah2wxn7GUnCM1UkqmhtYcII+wIv+Guj5m7Uts/TdRIfyxGtHgMuPyd66+Lw
	u9bjkvo605bWea06VR3fE4UXtx/9P5NjChDm7EDiBLQDwohfVuyCzhByG2dfO2bsy1rptmxjZ0r
	5L3dJRgOI+FkItJzmtq4kGYNnZ8QHqmCrkxMh42iT8ZKNC84bqN1+Xy4Quk+LTyk3JJ3Zv8Wk3K
	9/IwF9+JSGC4o88GijMOYxnrxQ/uVk/qz0gtuuzP2rySgbeXrtuuxWTBdgSn+RwCRNfGqH+8nIu
	p94fKHrN9/kntxrhPPhKkzvHaBe4GYSh98JCpi9G5bCg==
X-Received: by 2002:a05:7022:419d:b0:128:d375:f1d4 with SMTP id a92af1059eb24-12deacf940amr1693852c88.28.1777567725784;
        Thu, 30 Apr 2026 09:48:45 -0700 (PDT)
Received: from [172.17.0.2] ([20.168.159.164])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12de320ed98sm8563624c88.3.2026.04.30.09.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 09:48:45 -0700 (PDT)
Message-ID: <69f387ed.050a0220.5fc55.eccf@mx.google.com>
Date: Thu, 30 Apr 2026 09:48:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2949507999468027892=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [RFC,BlueZ,1/3] shared/hci: Add BPF filter for registered events
In-Reply-To: <20260430155038.426968-1-luiz.dentz@gmail.com>
References: <20260430155038.426968-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2949507999468027892==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1088223

---Test result---

Test Summary:
CheckPatch                    FAIL      1.10 seconds
GitLint                       PASS      0.61 seconds
BuildEll                      PASS      19.80 seconds
BluezMake                     PASS      643.54 seconds
CheckSmatch                   PASS      346.70 seconds
bluezmakeextell               PASS      179.12 seconds
IncrementalBuild              PASS      693.44 seconds
ScanBuild                     PASS      995.59 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[RFC,BlueZ,1/3] shared/hci: Add BPF filter for registered events
WARNING:BAD_SIGN_OFF: Non-standard signature: Assisted-by:
#106: 
Assisted-by: Claude:claude-opus-4.6

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'Claude:claude-opus-4.6'
#106: 
Assisted-by: Claude:claude-opus-4.6

/github/workspace/src/patch/14549670.patch total: 1 errors, 1 warnings, 108 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14549670.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[RFC,BlueZ,2/3] shared/hci: Add bt_hci_register_subevent for LE Meta events
WARNING:BAD_SIGN_OFF: Non-standard signature: Assisted-by:
#111: 
Assisted-by: Claude:claude-opus-4.6

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'Claude:claude-opus-4.6'
#111: 
Assisted-by: Claude:claude-opus-4.6

WARNING:LONG_LINE_COMMENT: line length of 88 exceeds 80 columns
#234: FILE: src/shared/hci.c:635:
+	/* Without subevents: 3 (defaults) + evt_count + reject + accept = evt_count + 5

/github/workspace/src/patch/14549671.patch total: 1 errors, 2 warnings, 316 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14549671.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[RFC,BlueZ,3/3] ranging/rap_hci: Use bt_hci_register_subevent for LE CS events
WARNING:BAD_SIGN_OFF: Non-standard signature: Assisted-by:
#109: 
Assisted-by: Claude:claude-opus-4.6

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'Claude:claude-opus-4.6'
#109: 
Assisted-by: Claude:claude-opus-4.6

/github/workspace/src/patch/14549672.patch total: 1 errors, 1 warnings, 269 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14549672.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluez/pull/2087

---
Regards,
Linux Bluetooth


--===============2949507999468027892==--
