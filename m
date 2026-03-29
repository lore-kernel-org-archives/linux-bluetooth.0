Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F72A2C21D0
	for <linux-bluetooth@vger.kernel.org>; Sun, 29 Mar 2026 14:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774793426; cv=none; b=jyE4/SzveMlq35RMI7hf0dxDnRVN+o41UFI9g/dcl6/Y+NYpBWbzHQXRIx8Hfgo0I16xD8CTrCoJ52mmvt8gAKM1YchstWYT7tzwNJZ+LvJo4sQBNWn4mJb0xljkkcXUemnvLZ6OsTPIHlzFWW20k7kBdTLSBpiM7qQiMg43SfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774793426; c=relaxed/simple;
	bh=gxODADAQkxJoSCZmrX7TczMwbVELv5rNFL2lPHJMcVQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=hndNpyY6yGu/O7Hv81JR5hKmM9PWTApi6juNuIpNpOzNZpSTZ76PX3fw9JSXcab99ksk1jftaQGS77FpQ7bDYtGtGzb8Tgt8Jg/P9IF6UZLaUFZbqs7uxkobdJ9BhT2B+E3wdEtbnu9e6+op2ypOKpXCTz0CFOSjOU1sR4vYHOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZSnanm48; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSnanm48"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8a032383008so9715146d6.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 29 Mar 2026 07:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774793424; x=1775398224; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qe2/OkcDOm9mKNZv8nu4mhukF30zBb1cAKzbKeQO/nU=;
        b=ZSnanm48v7m2T2qgcsn4kePCGWXGLum1HsCM4OPztzp4BtPe5iMtyxdZFMv9cZ9BgG
         j22LVlcujAMTIwGssciKeV9bR4J5fDOjlrPMMa/D6fIOGlHRIJt4uxnQmOrYHhrXUQ6X
         BIVRg4sy4YaqMK4nfDzYpESA1rObKk6EPpme25NUuzEuEOdHRwa6CmYmIFWOJG1spCcx
         +Tl/OHihqYZ+csiUQ/mHiW6wxji3VJbIll27QxOTmM8U+84xndyl0VPX6M7WzC5zjub7
         5K9hCFdxfblU+hA7N1TzYrhvAZktHidcLmwr/HPLBSSdXAEaQon+LpHMQH5h1BHMVtRQ
         YWpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774793424; x=1775398224;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qe2/OkcDOm9mKNZv8nu4mhukF30zBb1cAKzbKeQO/nU=;
        b=Gz3XyrE4MyCCX5uNsRDtcdL0aUSdeEyjyw5UiQt5O3DpcR/DglKUmjnsSflQX+PnST
         dPL09hxmH1S08H5WqRh2p1v5acRomdxBoF8SSGPCgHUPnUhubFqdkrywaAzhtnVbimMc
         G+63c4nq+UpFVWXaJg9SGkxtd0ZIcaR5yhLdIVSJXjFttW8KTFT2Mxyixhe+N2rHOHUm
         9b9EwWpTacnJxMUPO2wF1439rBZDCalDkjBaBqK6wN2pXFNXBFeu7+BzWDAdxzp1DCKY
         TjxwcK/SAstEZehwAx862AblNMNsUIlwX5F1wnmkptQ3CbdMeHN9jpfTPm9hn+tqUUe9
         GFhw==
X-Gm-Message-State: AOJu0YyaXtwL2kSKEP3QXZvdp2t1sf5nyadgNeSlUN6P1/VNmde9SWmF
	E4dMH1nvttBsd5ZS3tQLzS9WUvTRv0OiGimEwOlIN0CZtI7196o0bOZ3c4fBKA==
X-Gm-Gg: ATEYQzwT6hkVqojRluLjyQeQQJ58e770OZ3nFYR75Dull0stdSvUSLykuL8dNfWP9tM
	TZwh7+Z1Q5/3VJRiheqdzAm+hkTdJow4RPY2PG0w7Mr24RfCwk1bSeEPZ+UQB/H8TV8bZhKGp1c
	Xf+Z1/bmDvAyuiPc5zogvydJVEWyW1w1AwF/ZeeCSojp2NzEx+DaKtcmArJBvUUsEBZru4BPspS
	+ix4Pk01jYybdct0AdbgEldpFKGMgesDb3lh9J3Zu4abA3G7SOk27UFmO7y5hi9Qv9lw3apLFo7
	iuQWY4G2TK39cSeWSAkZIK0vouEQ7tQbW5fPpv3hLMUrqpHquugAM7LEpfpJQPeOsHqTPU2b8tB
	/cuiPssT0qAHMQZZumJG25EQtHWv/e34NMYcVUdH4FSTXSarSITRto5z+lTTN2cxxRdN3qGYnph
	cBTVpVV9RYTLUePEyJf3GsooLrRa9ClPlf
X-Received: by 2002:a05:6214:401b:b0:89a:f10:996e with SMTP id 6a1803df08f44-89ce8d4ced3mr126720636d6.6.1774793423965;
        Sun, 29 Mar 2026 07:10:23 -0700 (PDT)
Received: from [172.17.0.2] ([172.172.119.100])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89ecf281b2asm40508826d6.23.2026.03.29.07.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 07:10:23 -0700 (PDT)
Message-ID: <69c932cf.0c0a0220.1e7d76.3194@mx.google.com>
Date: Sun, 29 Mar 2026 07:10:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5557881738365905635=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Bluetooth: fix locking in hci_conn_request_evt() with HCI_PROTO_DEFER
In-Reply-To: <089f435fb4668921bb416a3d60fa0f232456e054.1774791296.git.pav@iki.fi>
References: <089f435fb4668921bb416a3d60fa0f232456e054.1774791296.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5557881738365905635==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1074198

---Test result---

Test Summary:
CheckPatch                    PENDING   0.29 seconds
GitLint                       PENDING   0.20 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      24.58 seconds
CheckAllWarning               PASS      27.53 seconds
CheckSparse                   PASS      26.52 seconds
BuildKernel32                 PASS      24.58 seconds
TestRunnerSetup               PASS      526.15 seconds
TestRunner_l2cap-tester       PASS      27.11 seconds
TestRunner_iso-tester         PASS      38.93 seconds
TestRunner_bnep-tester        PASS      6.45 seconds
TestRunner_mgmt-tester        FAIL      109.31 seconds
TestRunner_rfcomm-tester      PASS      9.27 seconds
TestRunner_sco-tester         FAIL      13.97 seconds
TestRunner_ioctl-tester       PASS      10.04 seconds
TestRunner_mesh-tester        FAIL      11.49 seconds
TestRunner_smp-tester         PASS      8.49 seconds
TestRunner_userchan-tester    PASS      6.69 seconds
IncrementalBuild              PENDING   0.55 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 485 (98.2%), Failed: 5, Not Run: 4

Failed Test Cases
Adv. connectable & connected (central) - Success     Failed       0.123 seconds
Adv. non-connectable & connected (central) - Success Failed       0.115 seconds
Ext Adv. connectable & connected (central)           Failed       0.172 seconds
Ext Adv. non-connectable & connected (central)       Failed       0.172 seconds
Read Exp Feature - Success                           Failed       0.103 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
BUG: sleeping function called from invalid context at net/core/sock.c:3782
Total: 30, Passed: 30 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.905 seconds
Mesh - Send cancel - 2                               Timed out    1.994 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5557881738365905635==--
