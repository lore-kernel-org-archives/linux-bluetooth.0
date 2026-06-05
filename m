Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAFC4C77D8
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jun 2026 11:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780657845; cv=none; b=SxoKWLb0xIRUUWT977yBslrWXXSJ5d+LWOdinmvAkV7RTNG5aNWFUmgVMbTLr87SLcCIfvDFjI8wzVhRKCOrLe7rEb7GUuDEX7WahBoFGBa0FV4z3Vt506ir/1b6M9Ve90BZCyh/j76Cd4UlclvAzVUQo1lorMX8wP2U3Iy6GsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780657845; c=relaxed/simple;
	bh=imjvLZBBP+5Z8zxo/GxVEb/8JyYEKpUXSTHL4TnBfm0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=PQSob/t1cZY0zbdqlTGLf2zhtVqWS9M9UO57twocUC0HYQT2DGuKmt9phJasXZaQe7eADoLWp9ASqHSBkfFmk+7l1Fx274tOcIu1He/aLmHTNnoXQwCspiyuIXn+JL5G8youayaYCWUGHrl2qO+dQOc+9+Iw1PC9igd5TBeYyv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r0vKBuqD; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r0vKBuqD"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-13807d2f898so467828c88.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Jun 2026 04:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780657841; x=1781262641; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MxKO/3tsWQUfcwqLrJR3eaeGnTfMI1W2BNcp9LHb0TE=;
        b=r0vKBuqDzoRJuAl+S51z7mtqAe1tqJYkNOyrDScDJKfZ1jnyPrWCJgWhk1yhEK9tLs
         zAJ3FTJWxFXrTfMsjZZRGrobWdtO9gq3zFhQCjyB7Hh5Uk4CIi3W/UkdJur+BKz92lef
         bbKvFtCp5KxgzgRnWfRSe8tYltuGo8hkctDh9FXQ8RdJMpprQ+KseMIUUWZ0fvydZ8zP
         BC8Y7wn43d2/2KP34yEx3n6XjqktkJwALfs8du748zqUUWgnaIgRM+nZbmJS4KBPJdj9
         dkvfLJWFZCdxhmMOzHKpn36lm+N0IO+cD8vSdWpmkXB0jDx5PVDtBZpmvBRvUmMDydw9
         XRWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780657841; x=1781262641;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MxKO/3tsWQUfcwqLrJR3eaeGnTfMI1W2BNcp9LHb0TE=;
        b=NMpR4zAzT/+nPcq2Cquz1fJvA62IT53Lotw2ClZwIHPAzziMonTCeAWhkPUGuV8Lu+
         bcR1nJp9Le/t6gQN1hcoO+NCi7DEzX5wOkJbjDMvGp0R4TliPbKxGOSW2c1FOuU1LdGb
         6rU8reKL6PNAb4Ta89GOaErBfeRcnZM4JV0eUhm7KFTrj4UC0CZIHHVV73B+8WTgAEBz
         mof0xAxeV3YRVfP8fO3WXv4VKxczDJVXPPPOQrGG5q3cwgxQmOsWOmOUS8TCuXrzUiTu
         y09mrZ48FT4SQ0dPuBb0yR7GJkt+HqpID+sul8WK8b3YU67MXiVC3vXXnQtPOLCrGArV
         rbjA==
X-Gm-Message-State: AOJu0YwYGs6dHtvWQs8bZQnD6Km/6JtjHCUyijdbzpTVRmRCYZSCfhLn
	gS051SSNqWkK6o3KekYN/TqpTNOM9i+4cdH0x6mZ9VD9tSidTK2fWO6TAwGVxA==
X-Gm-Gg: Acq92OG08t5GN4DUi9qy/De7qkkz5144/ilTlUhKXBvfdm75xoQHnGbLuj6Xri78Z9X
	X0c6AF0mS9IeLzY0fUzvAJHS8z3kMaW7vQT8XKwMFSWJ0h4DqMvehvwyWnKtaJXnRDn4RPyfotR
	MSbunI0MotToOJ9GofXqVCzFwj3VdP/dbJKYU3bsi9voQAbUOQc036faH63/WwTmXFbL5GTVNmS
	GcVay4Ii+0W8QNfPtyi95X2iYn4ZGyNMRQDMyKAAL6+ViZKha/Gg5tQffaTL7dWd42qHdZaeSw+
	yhMP34k4QVa3bsmYi/SxHbILeL/Ck/iM+eG/6pUs8Kni1kCF2SYL42Xqoa2DYhU1tu7o9VnUyvT
	xxVs8LDoV4hsxrMsatVoLDgmorUwQfZwMaVF+qgVdORBdgbeHI4rmUuS08Rkv7jmNkUbxdZg3vY
	P0aG64AZnp/tUltpGxli/tbn8Mt5aXiX8OeNK6EU4=
X-Received: by 2002:a05:7300:8cac:b0:2d9:6373:ad0a with SMTP id 5a478bee46e88-3077af4f7e4mr1619363eec.11.1780657841199;
        Fri, 05 Jun 2026 04:10:41 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.55.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074db55f60sm9737119eec.6.2026.06.05.04.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 04:10:40 -0700 (PDT)
Message-ID: <6a22aeb0.e3e4d428.19705.646f@mx.google.com>
Date: Fri, 05 Jun 2026 04:10:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2582646002214886038=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: [BlueZ] test-mesh-crypto: Fix retval for skipped test
In-Reply-To: <20260605093555.1969171-1-hadess@hadess.net>
References: <20260605093555.1969171-1-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2582646002214886038==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1106487

---Test result---

Test Summary:
CheckPatch                    FAIL      0.32 seconds
GitLint                       PASS      0.24 seconds
BuildEll                      PASS      20.60 seconds
BluezMake                     PASS      665.36 seconds
MakeCheck                     PASS      19.11 seconds
MakeDistcheck                 PASS      250.36 seconds
CheckValgrind                 PASS      300.16 seconds
CheckSmatch                   PASS      351.23 seconds
bluezmakeextell               PASS      182.59 seconds
IncrementalBuild              PASS      654.30 seconds
ScanBuild                     PASS      1052.78 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ] test-mesh-crypto: Fix retval for skipped test
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#58: 
  ============================================================================

/github/workspace/src/patch/14613073.patch total: 0 errors, 1 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14613073.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluez/pull/2181

---
Regards,
Linux Bluetooth


--===============2582646002214886038==--
