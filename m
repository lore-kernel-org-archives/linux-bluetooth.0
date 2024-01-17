Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491C022EFE
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jan 2024 23:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705534878; cv=none; b=JLuwzJcrwYXnSKGWobVDIrR1yCcU8D4RV5qXhhoLh0UGnMr+sSIAsXGaKc771vl4nrjQcpfD79sZULssWkJIPjp7dNOrWeYx68Ek3WoK+Nd2ujmYOhG+lj9sYt4dtKJKNCKlFpV19tHtVoEyPWUtNrZF5L4zVUoIjpmstwenQfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705534878; c=relaxed/simple;
	bh=Ei2n7irp33GqXK/a6Su905uLtesYaC4w+ulQ6v+jnHQ=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References:Reply-To; b=UJCrKtV/DzSD56bGO13Eg3/WN2I/+A+6w/ots0vsWFtcoBfcgdai/EGYnOcLnK9TEgUEcQBFgttrr8QQa/dXufYGTpOGcF9XPsJE1q6JkjmFvz0s02hLL8fYHfCCLU80yD4UNgrJfqWZWi2TheZv/hyI5sggnDqS+L/nkNpfg+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cosMcTYG; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cosMcTYG"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2900c648b8bso572981a91.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jan 2024 15:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705534875; x=1706139675; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=f3tABba4zAGg82FHsCsW2+Hypxw7uVhbLBDt2xXFGvI=;
        b=cosMcTYGnhbJz4ed4pAzEC2kfCDh9JTsZ+lt2ubakVlZU5psLTWaoXQjBqhYX2Svym
         qgLfN29CFgp4bAObmux79RdvBUa+bq1icNNUtiTJsvcEkQeGiC3kql4WzsEB8BSVRjlg
         nKAy2tIH+H9Hv3xhNy6wEOObZrjI6RBbgv9mJ/izv2uR8mHbxsXf1p9KBM9S1UL9Ox3D
         lENObO7d1YZcHxTm0d5zhvTcuEo7uFAdFy1VVigo92wYd1Hg0c2sdtiP07JuNWRzrKck
         z2DaobmWSEBiE/r58XvSaH4fjnv10JOiMjCV1jFMBr80lzmJjL6iJQBr+z+yiS2QtNkF
         M5rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705534875; x=1706139675;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f3tABba4zAGg82FHsCsW2+Hypxw7uVhbLBDt2xXFGvI=;
        b=US0N/9caj2Z1hv1d7B3VWFiC6iACjQVJaXVpXNKnQxwB0hpe2UWs8t4lbU8M1zV8s9
         7YuRFPqPac1L8i2091lxCQS3ymSkMUFNdnPJPtzVjVzr3ZkdiWqsovam3WV6J6nyIeCb
         3b77U4kbroBqO9DGFlaCrJW6A+eJUyCv59a2mez5dcA0BcyXjmEr6Ug2PGAm+0X32ldd
         FW9go8b0A5k7uFBCuzyRatv27aX3JJ0zCh7rAERDYftIv5yPGZDsfvKikz2GcuEqdLrP
         Q9oZeOzVr1weBkelgotSPzd6xsVVZ1i5UqV9DNNQQzZ3rs/q1TNeBn8PudJYdDP5LiG0
         9/XQ==
X-Gm-Message-State: AOJu0YyuFhSJ0ko9tTF6ZBEc/Db6TIIl8GV6CkYCbGhubBx0iJRaqhGe
	M5xZ5hWp4ZMtZ80g9EBMmPm/3dA9CEoYvM8+13HsvvDTVXEh1qBDVXwttDNj
X-Google-Smtp-Source: AGHT+IGwTJ8drzGSwBhCNsYcio9BhXt7E36TEH6c3RSO32ld8XiaiI4CeTkBglslr/yWKgB5QxLf9g==
X-Received: by 2002:a17:903:610:b0:1d4:b4b8:93da with SMTP id kg16-20020a170903061000b001d4b4b893damr42948plb.114.1705534875328;
        Wed, 17 Jan 2024 15:41:15 -0800 (PST)
Received: from [172.17.0.2] ([20.172.5.95])
        by smtp.gmail.com with ESMTPSA id f13-20020a170903104d00b001d6f5864d62sm191323plc.242.2024.01.17.15.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 15:41:15 -0800 (PST)
Message-ID: <65a8659b.170a0220.a7217.1b64@mx.google.com>
Date: Wed, 17 Jan 2024 15:41:15 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3795083274086154107=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/2] client/player: Add support for printing A2DP codec details
In-Reply-To: <20240117222317.1792594-1-luiz.dentz@gmail.com>
References: <20240117222317.1792594-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3795083274086154107==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=817657

---Test result---

Test Summary:
CheckPatch                    FAIL      1.28 seconds
GitLint                       FAIL      0.72 seconds
BuildEll                      PASS      23.85 seconds
BluezMake                     PASS      714.32 seconds
MakeCheck                     PASS      11.90 seconds
MakeDistcheck                 PASS      160.73 seconds
CheckValgrind                 PASS      224.97 seconds
CheckSmatch                   PASS      326.77 seconds
bluezmakeextell               PASS      107.48 seconds
IncrementalBuild              PASS      1334.25 seconds
ScanBuild                     PASS      936.79 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v1,1/2] client/player: Add support for printing A2DP codec details
WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#139: FILE: client/player.c:82:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#148: FILE: client/player.c:91:
+} __attribute__ ((packed));

/github/workspace/src/src/13522216.patch total: 0 errors, 2 warnings, 599 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13522216.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v1,1/2] client/player: Add support for printing A2DP codec details

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
10: B3 Line contains hard tab characters (\t): "	UUID: 0000110b-0000-1000-8000-00805f9b34fb"
11: B3 Line contains hard tab characters (\t): "	Codec: 0x00 (0)"
12: B3 Line contains hard tab characters (\t): "	Media Codec: SBC"
13: B3 Line contains hard tab characters (\t): "	Channel Modes: Mono DualChannel Stereo JointStereo"
14: B3 Line contains hard tab characters (\t): "	Frequencies: 44.1Khz 48Khz"
15: B3 Line contains hard tab characters (\t): "	Subbands: 4 8"
16: B3 Line contains hard tab characters (\t): "	Blocks: 4 8 12 16"
17: B3 Line contains hard tab characters (\t): "	Bitpool Range: 2-53"
18: B3 Line contains hard tab characters (\t): "	..."
22: B3 Line contains hard tab characters (\t): "	UUID: 0000110a-0000-1000-8000-00805f9b34fb"
23: B3 Line contains hard tab characters (\t): "	Codec: 0x00 (0)"
24: B3 Line contains hard tab characters (\t): "	Media Codec: SBC"
25: B3 Line contains hard tab characters (\t): "	Channel Modes: JointStereo"
26: B3 Line contains hard tab characters (\t): "	Frequencies: 48Khz"
27: B3 Line contains hard tab characters (\t): "	Subbands: 8"
28: B3 Line contains hard tab characters (\t): "	Blocks: 16"
29: B3 Line contains hard tab characters (\t): "	Bitpool Range: 2-53"


---
Regards,
Linux Bluetooth


--===============3795083274086154107==--
