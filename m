Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CF11C824D
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Aug 2024 21:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723669539; cv=none; b=jt1rJ2jHA4bJlGoQR3s1yE8j5el8Sa2rsnWf2cuDO0LoBGBY9QzkYDppHmH658S9WgoO6rr4DbeZ24v1lpPeH0IGUje92sWsdRIBNxC7k9oGp49sX1L3U7SEXZGBrL4ir8BgMQsOywn2VhFbEEcFsbyt/KrWiD42QWHaNmWdNQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723669539; c=relaxed/simple;
	bh=DZDCUjVtqhfEPIMhzP88vgrGtL2GQFJLGwS6NxUz5F8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=X94mRpYHGUN9a4PO466kay0LXPD8aGZKhll/GUs4T+Co8RvB/vkoYzzsSYLFgUmHnbkES79WBtAw0k95rotO0terz2Pm/xg9tbIzoRYFB1n5rWGXVUeNLQ0AN6zt9uILfOHZ9BywkvfqM0hmIvqWWLZLoFmoDTOUIohfd6u834I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WcFo4D/D; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WcFo4D/D"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-79ef72bb8c8so13127685a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Aug 2024 14:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723669535; x=1724274335; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xZCwQ8azazTFo6cTP2UktIdkNCthnP5s9Zq49MSm0Zk=;
        b=WcFo4D/D++qQ84cQutCO5sBGs98It+rj3KT+kdjlplOZtj8pnuz1WLF+b123W43O5/
         LX/80b4gyNijdxq6jPt/osDRNhO5Vi1BabaWduJEANKpTPEY6ItuyjVC0BqVdhZTEvUw
         OA4J+8fAIIYQwdg7U3vN1Efav4mmd8PiZmOcdFtdNdIndAEgh+PGe+mfcfEz1rDbxIkO
         +WS6FNpLPRHXFMCMopktMeFTuWAG6qke2K3Fz4IiPGYbz38uz4u6HuZ7ThsGv3vr4xaa
         5Oi1JoONKvbAH8hxtGpKSkXASNSgw1InvtPzBeAylZILnIeto0sFff/4NQy8JLO/9uRP
         fmKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723669535; x=1724274335;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xZCwQ8azazTFo6cTP2UktIdkNCthnP5s9Zq49MSm0Zk=;
        b=GkFZcIxciIzeJvkHSL3pI9WZJenlMt0SnXPH7YQeUoFGcC1pnmD1S26EO/vN79kzIe
         d8t0hAiqM8bxrCspfTW1uHuPfzGNdEOclWwCIs+ZTm/w/h91NLMPYUTI0AoAVKoA+x0n
         +wu+lGgMIu76B/pqmBqyer6ynM1we5UzACzmPasw9wMoLqDZd1GiurWQbYdyItSpeplI
         01QPoKaQ9hbcXoklKkokvYcFR9p1qKEdMwfg4anCRe8bavgn522vC8py3TiyeU6lAMl2
         2HmVduyf4g4caLO6TWailvmJWWcp1snf1Ep2Z0xeC2yUwmo55zhn3fQDfOjwd/arKaq6
         1Exw==
X-Gm-Message-State: AOJu0Yxr0gttWMzFPrFlEpg2QtDx/HuubNX8kDeGWVBYtDDa2MzomerN
	5NSmeW9+aEtFKtc9huABRqicRYN9aodIlj00gSA9JCaN/PSAjQXyp9yKoA==
X-Google-Smtp-Source: AGHT+IFQYnAc1qMzH0duT3Ki6b0mSbeHo54yTFsgSh95EUzRDUpC7hoR2F9HYGuB2g+cYxqzanEEZw==
X-Received: by 2002:a05:620a:2948:b0:79f:8a7:eb8c with SMTP id af79cd13be357-7a4ee3ac1d8mr409839585a.52.1723669535238;
        Wed, 14 Aug 2024 14:05:35 -0700 (PDT)
Received: from [172.17.0.2] ([74.249.5.224])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff051155sm7236085a.32.2024.08.14.14.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 14:05:34 -0700 (PDT)
Message-ID: <66bd1c1e.050a0220.15940.050d@mx.google.com>
Date: Wed, 14 Aug 2024 14:05:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8469579159894521984=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/2] device: Promote Device.{AdvertisingData, AdvertisingFlags} to stable
In-Reply-To: <20240814185714.844117-1-luiz.dentz@gmail.com>
References: <20240814185714.844117-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8469579159894521984==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=879759

---Test result---

Test Summary:
CheckPatch                    FAIL      1.12 seconds
GitLint                       FAIL      0.83 seconds
BuildEll                      PASS      24.71 seconds
BluezMake                     PASS      1685.96 seconds
MakeCheck                     PASS      13.60 seconds
MakeDistcheck                 PASS      177.24 seconds
CheckValgrind                 PASS      253.55 seconds
CheckSmatch                   PASS      355.97 seconds
bluezmakeextell               PASS      119.79 seconds
IncrementalBuild              PASS      3048.70 seconds
ScanBuild                     PASS      992.60 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v1,2/2] adapter: Create devices if they are connectable
WARNING:UNKNOWN_COMMIT_ID: Unknown commit id '815f779aa8e4', maybe rebased or not pulled?
#99: 
or not and bluetoothctl has been using it since commit 815f779aa8e4

/github/workspace/src/src/13763849.patch total: 0 errors, 1 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13763849.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v1,1/2] device: Promote Device.{AdvertisingData, AdvertisingFlags} to stable

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (83>80): "[BlueZ,v1,1/2] device: Promote Device.{AdvertisingData, AdvertisingFlags} to stable"


---
Regards,
Linux Bluetooth


--===============8469579159894521984==--
