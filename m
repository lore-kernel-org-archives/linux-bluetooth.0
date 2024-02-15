Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F1C19A
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Feb 2024 00:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707955773; cv=none; b=jKAqHiV0Bs1tQwZx3ixz+ZxcSg6eTKKcIBlNR4/E53EoR8rf66o03gtkVhYriSP78F8LphimV7TShRqOPW9ut4JKyv+EmNzlgV5yBNfpSwnAXBof347kXpqpwP5M5XJZkgXtL7vc91ezAhVvjvFiibveRyQoriNujQlkG4qgW0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707955773; c=relaxed/simple;
	bh=lkyKnMRFOyiBt2BWpNqeDPl+r5S/FWcvwh550R7WOts=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=g6wcJ/1oFgjH7O1LZqQ/J47uI5ee2nVKxBVyvlI3N3AO9l34lPIdTUR6wXGfFfX5D1prwTTma78FARWSS9cSn+xXCt5lypuYy8oFflCAf6mxHCO2hCrsUUGQk8UuUlLzAAA62arobQ7XeK3WDEVhdmnDjwTB+ZwmZaX0y/ljdoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OBTL4kBL; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBTL4kBL"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7872bc61fd3so12342785a.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Feb 2024 16:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707955771; x=1708560571; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qtvio0DnubqltIAd2ciZZocioe1rZ6+oYgTLtQeyKc0=;
        b=OBTL4kBLm/S3v/yKj3YS1l+eaOS9eyvOyEqtQiTfEZY1HCwcJeXJd9kSmg7ZygNGv1
         BBbVlAh77dR6SpiM6+z2XOdtH7gBbtE5nmCswnc45WgJiiCnsOCODxOSPW7OBalP4FMB
         aqNY0/IP+wx9PHMUI+evIGUritxHQXbD4vtbaj7oM3mtlhPE2Atk3fgwM/hjNzoB942p
         HO5K77mJk7Pnt3+s8qPI5wdRA1fRf3TZKH4VTlKd/KLvkiMw30KPfdfO/xHCbdlk6W1d
         0TzAqegJSFikh3rsqBDGr8YOp6GI8Gx+eg4XjiNktJg8JpHEErv/4i4ZgocqgBVbzzlH
         X8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707955771; x=1708560571;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qtvio0DnubqltIAd2ciZZocioe1rZ6+oYgTLtQeyKc0=;
        b=ByVAq+Dc8sVNNE5DUDlurOS9N3hxvrtO0cs+A8ajK76YVh93X2swUNvWqfelvekPL5
         wk1KEI1gkOqgOVyyvlS0JTbkW6rcZSHO89EWfFdotpHDkD5dLGarCzVY1QdT+u059E0d
         P5O+PSwCAt3KxJoekJIZdehiPdubjfZm2vKDe4pXk+5M+85W48MfffwgLOn7Uy/f/tz6
         TcLTcNxnwHhDWmyMUW1BJyve38I/ONwOTt87w69/4Cki5vJBBiwuZWMzqmTD+BR5r1nu
         tYcbBfynu5oqKuj/bNO1iS7DZ9Yei0qMW+1EYztzxbhq6VXqTJRdklI08uUyOT91xwxA
         OdvQ==
X-Gm-Message-State: AOJu0YwVf8534wT8JnCcfrTq6y0wEHB65mCvgPoi3difTiizVsDaKh0L
	lAk7DzRq4QLT5ZlSP2tlsB+53W/k0RaaH8E0eOVNQqs32cnpd2e2glSw+pd/
X-Google-Smtp-Source: AGHT+IF1aaEumgEsFD9xk9Lv6UPC6oJvP6ex+UNkdhBdcUd3HcCCwq0qJ6ZgYXN2HpwSpg5N2x5+zQ==
X-Received: by 2002:a05:620a:2606:b0:785:d37f:8f66 with SMTP id z6-20020a05620a260600b00785d37f8f66mr401907qko.8.1707955770916;
        Wed, 14 Feb 2024 16:09:30 -0800 (PST)
Received: from [172.17.0.2] ([20.55.14.224])
        by smtp.gmail.com with ESMTPSA id az42-20020a05620a172a00b007871bac855fsm111342qkb.47.2024.02.14.16.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 16:09:30 -0800 (PST)
Message-ID: <65cd563a.050a0220.5c5e4.0713@mx.google.com>
Date: Wed, 14 Feb 2024 16:09:30 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5126642182304886089=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: [[BlueZ,v2] ] mesh-gatt: Fix JSON files missing from dist
In-Reply-To: <20240214224955.405535-1-hadess@hadess.net>
References: <20240214224955.405535-1-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5126642182304886089==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=826174

---Test result---

Test Summary:
CheckPatch                    FAIL      0.61 seconds
GitLint                       PASS      0.32 seconds
BuildEll                      PASS      24.15 seconds
BluezMake                     PASS      735.22 seconds
MakeCheck                     PASS      12.09 seconds
MakeDistcheck                 PASS      165.29 seconds
CheckValgrind                 PASS      228.23 seconds
CheckSmatch                   PASS      333.63 seconds
bluezmakeextell               PASS      108.61 seconds
IncrementalBuild              PASS      691.98 seconds
ScanBuild                     PASS      974.78 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[[BlueZ,v2] ] mesh-gatt: Fix JSON files missing from dist
WARNING:UNKNOWN_COMMIT_ID: Unknown commit id '1f6553edd8a5', maybe rebased or not pulled?
#52: 
Fixes: 1f6553edd8a5 ("build: Deprecate meshctl tool")

/github/workspace/src/src/13557161.patch total: 0 errors, 1 warnings, 10 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13557161.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============5126642182304886089==--
