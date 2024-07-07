Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8ADF9F5
	for <linux-bluetooth@vger.kernel.org>; Sun,  7 Jul 2024 13:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720357272; cv=none; b=heqQMnUWMyRcRGUpWVGXy466OsZHi+Ti3rxzLdsQoM+vuKb6sMXtgKORJU64tg8pPLJrGGjJg1phzlFC7/jeWCe1CRwJg/KHmYDgfrQ84jRwLkAFxWcsMuKkzvmrsyhZjmjJQP1oz+YYwP+bACJiZ5RxK7so0bIpQ2NL7YV7lA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720357272; c=relaxed/simple;
	bh=YY/3z1XIMJGwFySZnW8SXbl6bTfpcrwuQidzz0WG5Qg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=vBtYAOgc9aRK+j6ki+LUtAVMu+1y2jxv0i1vc/6WBRk0HH67U6ABCaA/+x6ENnssofTw7uWXIhU1I26a7joJU6uS/FFtOTK6o1xMFn53ilGVv/AsRa93mGw7QB3UAkNA4v+AtEm6IZ+Qj6+kKBDDaRI7lTqbSwy1jL0kVBuyLvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D8Qg+c7y; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8Qg+c7y"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4266381bd23so3970685e9.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 07 Jul 2024 06:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720357269; x=1720962069; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=k4CMdRTgUNlUz9i+UyKge6BmrAjBIJFV/G92XHrkTH4=;
        b=D8Qg+c7y6KDC4euIYHrumUQARfW9RXWdePYJ9rGfO+wptFO49CTJ+2+sk02+C0ImaR
         DpT3XnKuSI1SUn1atmy0LRpSb8baaKCUqxl1yJYhuCmEdH9SrVIJa6sMGPqCAbj3+zI4
         aBQ4N/jqJfvZp19CqueIXxJaPiqaVS+DNYdav6qDqyeZexLZ7RhUVsTRxIkGdHmOeTXX
         44+rPi7z9WnQpwL3cktb12jKku5G3V3kS4FayrUESTdxTMMfhaR6+IRwo3RNu4/VGTrd
         Q/GfwttNF9GCr0KgK2KJ0dMNBp2FhEKTATCz9njIpsJZKzjKR8TEJS+ue+gVROcLcUvW
         yphA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720357269; x=1720962069;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k4CMdRTgUNlUz9i+UyKge6BmrAjBIJFV/G92XHrkTH4=;
        b=Hoq4YSnbKtFm9W+L6Yx92fBAV61n/xwHReLCLkoIgm6BdeI0YP8h1cHOk9+kRy7+XP
         3QPeLOoNhg/Havl6g5ddfd+evGrO5SEhurCyhJiykM75Ckrgr/QIgPjUepjEclq+Z186
         ZTz3BFcZppJbFK4CACS4nc2xzJIJMlvdktVO6/Lj7eIKXNP4wUbl1BtfeQwkF6i5lDq8
         Q4EoOIuZGARI97KPX1QK712NA6/o2w2d50PvQvYrkEjHR37SMGW7fdUrSnsPZa8mpBKM
         Uyc2MGDq8tggYMg085ZSojmLwCcn+9S6KkOAjc589+95iTmYiz3dqWTqJ1R/3Jv/q3pR
         i5pQ==
X-Gm-Message-State: AOJu0YzY288NQC7AhxoinjV6pkOtWPR31dKg2dvfHZ2GWp/WuahZRUOj
	bzFwJTv37394AFusD270y5qJtbJdAVA8bTrMXDCSkv77/omUV2tDAlV/Xg==
X-Google-Smtp-Source: AGHT+IHS/7n6lEEO/vXk9UBZEGvPEPPqBW4XKPWBYf8rszuRBQEtM8MVgyLcvvQUPvyYBgQnuHllKw==
X-Received: by 2002:a05:600c:18a3:b0:426:6087:198f with SMTP id 5b1f17b1804b1-42660871ab3mr19228455e9.39.1720357268679;
        Sun, 07 Jul 2024 06:01:08 -0700 (PDT)
Received: from [172.17.0.2] ([74.249.21.241])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a188edasm128012395e9.0.2024.07.07.06.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jul 2024 06:01:08 -0700 (PDT)
Message-ID: <668a9194.050a0220.fb8df.17f1@mx.google.com>
Date: Sun, 07 Jul 2024 06:01:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7819171104472386369=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, gudni.m.g@gmail.com
Subject: RE: [BlueZ] client/player: fix incompatible pointer type
In-Reply-To: <20240707112452.3522-1-gudni.m.g@gmail.com>
References: <20240707112452.3522-1-gudni.m.g@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7819171104472386369==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=869066

---Test result---

Test Summary:
CheckPatch                    FAIL      0.62 seconds
GitLint                       PASS      0.31 seconds
BuildEll                      PASS      26.95 seconds
BluezMake                     PASS      1665.88 seconds
MakeCheck                     PASS      13.34 seconds
MakeDistcheck                 PASS      177.89 seconds
CheckValgrind                 PASS      254.56 seconds
CheckSmatch                   PASS      355.71 seconds
bluezmakeextell               PASS      121.30 seconds
IncrementalBuild              PASS      1401.95 seconds
ScanBuild                     PASS      982.52 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ] client/player: fix incompatible pointer type
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#103: 
To resolve the compiler warnings, cast the pointer with (struct sockaddr *).

WARNING:LONG_LINE: line length of 92 exceeds 80 columns
#117: FILE: client/player.c:5150:
+			err = getpeername(transport->sk, (struct sockaddr *)&addr, &optlen);

/github/workspace/src/src/13725999.patch total: 0 errors, 2 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13725999.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============7819171104472386369==--
