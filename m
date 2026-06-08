Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57AC3793CA
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 12:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780921544; cv=none; b=ivjrF1yxXrJn9J0s7Vj3jV1pnvSeY/o2afJ9CFZYyXaMt1Ct1qSWLkRbRrUOUVy7zLf8FLTardF2A1NU8rAH3C0qIRx4nKBPxzrc19lxvSTUZAKMP0KPkwuLKgdTmLiXGnQTZFlmTbK71IOSjCuEoSVxL6hnbD5JB+QJNlfnhvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780921544; c=relaxed/simple;
	bh=5OVmMgaw2mIeg0FpLp19vAJy/YZgVX7L52eR3nLdL88=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ji0z4OGr+uNQACMCBuCKSs7Kxsye2ry6owI4ZMgbUbWBX6gNLeo2aVmc0KSbqez9BA9lmAFOssRhvQb7uOnTAYSZyHQXDw0yEJ3EMQjX+34qouNX+O/PCqGjxj3HioXoedKIv/iXQCehK5tuj3xI3VKhh49H4nOnB3YYjhrEODA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cD8zEqAs; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cD8zEqAs"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51764768c36so59725821cf.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jun 2026 05:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780921542; x=1781526342; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=COSoJrs/U91aIBMUnvzYADnkNxT3tK7bC+Z41tWOQhw=;
        b=cD8zEqAswzmspsiKgvuEkJMSjx/iOIkfnVMJYySxeaFyqjn17wXaNdviik8JC/B4lm
         qt58+jVpp/lM3tOlPitNbSAah9u0mVFQyryKFZf1RoTWbj70PvZcIZ//kLk0w7TkKl1Y
         XCSeWRC3T9wKhyF0CFjbeiWykKMpm6i5YgCJa0sF0UaJv5tv0DqQJWWDO3XhHreQbFMG
         Ci/BtCtJtNXwvOr1sUwtTrCyc2xg302gvn0/Hs/GTKpxP5LkJ2vuKJbb+F1CFU1x0s5o
         bcQypqLmUeizVgwghFNDIv3/X8VwjRBtDr4ebX3POgnwpLRal5GNvi8yZ+n98yBynMit
         nCIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780921542; x=1781526342;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=COSoJrs/U91aIBMUnvzYADnkNxT3tK7bC+Z41tWOQhw=;
        b=mUAdhgsypiOvUIudYAE7U0sxQbFcymsLeVZWy93umjRd5n7RX549YzpgkicF5loB02
         DQqHDmKUvAIgF+LIGk1L0s231aXzrewmlrlrdteqY9o3K/xT8r5VxK3f4g8w9QoxEXJV
         aTdDIslKpbaMWuAsaSFn5SYWw0YDaROXJnJBofu0s/Os8aldzI3H624tw8RLZsfer3D9
         Q+Ee7Hy0OkKUjQQ7KrMDWzc5IwLLRQcNF3oaFPnBrr3xGGBURPC9uQlZl5rl93H3INVN
         b/8uJxm/B/zgV3r5MnurLT9WB93fNNfkkbujTUxV/0A4i0YZsHkZHw6MtYRBSouIez/u
         sNZw==
X-Gm-Message-State: AOJu0YxcVX8yoPif3MC853R7L8dSj9nYkKV6ScN+0Mj2PYZJCWpoFuwZ
	uqz0N5ukiducJnPucmhENgqUunCz9na1+mDHLI+g8zkxjxtjSmqH8OqmEqwFRg==
X-Gm-Gg: Acq92OF351f7ckok50hEZzcvVhuB2VYHD7NOMKLjYHJyXat/j6uA+46fLEF6aeY/5TG
	DCtP5/xHBxi+KADPsTCAiwEyy0zHY5LT8lvAnxD5OPMf3hGDogI4ULZbtvr800RBWvNykMPNGeF
	wSfrC32JnF/QVvs8Z/kvnuPLsk5pfW7D4CVsrORw58DEW1KnUFtegTeKpiJ6XPoQ92IlCsEoJMi
	qyL/GumO/BIxs8FZxzJhX6ROAhY/7abNPVPYObw4LdcGZMPIhBRNxbeNupdnnDcVEY2rl+ZzbCS
	L+IKa4I74TK+q8g4EiDmqauRT1mVFNOuhmPKDcokEUTQNoC/MimxY25RXmwRmwKn10zQGbbT9fl
	xj5l+0hOEQEct+aQthoTGEle2CUBLNp9sIrstwXxx9Qwad65Eun6pBNV5rPh7CBgkzMgTZk27/J
	R7hcaj8s2QFP94R1ef41lCqko5MVQryrUJzlvX3Nv1S6/zi80+VIg=
X-Received: by 2002:ac8:7fc9:0:b0:517:875a:d634 with SMTP id d75a77b69052e-51795b4cad7mr218039661cf.2.1780921541796;
        Mon, 08 Jun 2026 05:25:41 -0700 (PDT)
Received: from [172.17.0.2] ([20.106.191.51])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51775c07c29sm156028841cf.1.2026.06.08.05.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 05:25:41 -0700 (PDT)
Message-ID: <6a26b4c5.a9c3b6c1.38266b.e76d@mx.google.com>
Date: Mon, 08 Jun 2026 05:25:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3604903737082512260=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: [BlueZ,v3,1/3] device: Refactor device_discover_services function
In-Reply-To: <20260608110743.3683728-1-simon.mikuda@streamunlimited.com>
References: <20260608110743.3683728-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3604903737082512260==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1107774

---Test result---

Test Summary:
CheckPatch                    FAIL      1.45 seconds
GitLint                       PASS      0.99 seconds
BuildEll                      PASS      20.15 seconds
BluezMake                     PASS      611.00 seconds
MakeCheck                     PASS      1.18 seconds
MakeDistcheck                 PASS      235.33 seconds
CheckValgrind                 PASS      201.99 seconds
CheckSmatch                   PASS      324.63 seconds
bluezmakeextell               PASS      166.14 seconds
IncrementalBuild              PASS      619.73 seconds
ScanBuild                     PASS      928.74 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v3,3/3] device: Fix returning discovery error for Device.Pair
WARNING:TYPO_SPELLING: 'successfull' may be misspelled - perhaps 'successful'?
#99: 
If discovery was requesed from pair request we will report successfull
                                                           ^^^^^^^^^^^

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#123: FILE: src/device.c:7356:
+		err = device_discover_services(device, bdaddr_type, bonding->msg);

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#126: FILE: src/device.c:7359:
+				g_dbus_emit_property_changed(dbus_conn, device->path,

WARNING:LONG_LINE: line length of 86 exceeds 80 columns
#131: FILE: src/device.c:7364:
+			g_dbus_send_reply(dbus_conn, bonding->msg, DBUS_TYPE_INVALID);

/github/workspace/src/patch/14616520.patch total: 0 errors, 4 warnings, 25 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14616520.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluez/pull/2187

---
Regards,
Linux Bluetooth


--===============3604903737082512260==--
