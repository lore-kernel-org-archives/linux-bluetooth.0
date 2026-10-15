Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C578463B69
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 20:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792095673; cv=none; b=P9+R5LV1l/xDPRMe2BT+WqWhm6fEGC9BadW3lKWvt/fYc/ciu55xFZFafIgQqkznO52vV2YajqHao6a8SsGgmDyNVSTgdFVlvWEAY5O7Z7Dz7yrnuRySCo7ua0bsnpmEA5AkLwJ28hiMx5SwjvK9jGxkhZVfyfAsA06XhvSGEk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792095673; c=relaxed/simple;
	bh=+3rTCsH9EhDsrkICGv8ALalBcJSLO7OLx3ssNla29Ws=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=BZ779SCdny+G0E/UKslQSlcfoJVb9fD4CNJPMFEU7TZ1vWAF7A71nm4XupsEGS9LknCwKw92LpNblpny8EL75JeE+YqoXMMIA4R9Y6sOA9op5ovUskzs+HcwqVWeDtn88guEEans9+v62PWS4r57ZlnWoA4oqFfc8UDYxMOifAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j57LiMum; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j57LiMum"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-93a40a9a01aso50041085a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 13:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792095671; x=1792700471; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=m7DZH5bjcqd4q/HW/rPjjA7Rw6EvvliDldAa8v2M1+I=;
        b=j57LiMum2kQqVtij5NWkoHa5v+MM5zduO/3OwVOOwynMGq9Az4jMreOQ2F6CWmlowZ
         dO9QFVN9t3Ta2pR8TZpOske+vgbRzsdauGAIR828u97PZg3iKsT41MO0ZZCND7YOBJq+
         0Bap4oJrwaQRDGy1Eez9VpRsnnMhhyz53fGis0gQdxTLnmEYLtc5YUjPq6vMVNjPwjsY
         jkg9iiB4UHq9E+bJLrXLT54rf5yv0TDF7cWra6bh7OXkWxvWUzmUivBqQ/atmdDsjlRa
         gcsWvIikSuk+Ypaty5nd3VEvfEyhfE+kQd3MEtET54VX54YixJvuuIhGFQ2WuD9iidKx
         yA8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792095671; x=1792700471;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=m7DZH5bjcqd4q/HW/rPjjA7Rw6EvvliDldAa8v2M1+I=;
        b=mcT5pgEH+vjzrBh850kRy8t+2W954Sp6T8Oo4gkhbEG3wB76j4+DJv7OHxAwCgU1yi
         cyUHLl20agq/mlCWJkdQWDWZTSp6p1sa5wjOZXC7cyWPmo6cDSXjeCOqrNGLgffy1Q6B
         UrLLJUQH7ZZAsFVsjFuplbwVc/+1CuhR3m5KnADwvFEwXTDwZUae4xdRpQtjIZKuPhla
         Wkxs92bJ9lDLQBwXMlxyTLgKaWTqWM0Pbm6dEqeLKJQsJwtx4h65FK4R4/GR+69BxfWQ
         9EBS8aSzojaGUJ/r9p3V7qdiZk/UAxcixru2k0YZ4XH87+nMtbumSCOU6tCg7uHyWX/h
         GnNg==
X-Gm-Message-State: AFq9FYIfqJGZol+8sfD27nPyi24m78Oqd47AH2P/waJ72JWmbvAF8dwZ
	960HLg7uGfSw5cw0/oewQ3GhCCJEofqWS45kGyKi5BgIzdjePIqKPsHKxWBC3huz
X-Gm-Gg: AYBFou1Yvxml3dzTzKQUk7y+vSpKsSqzCzz9ScwG+w5KjEH1eqkdfr55Pd2EZ6ep1s7
	uDyjhcJaMMMH42jT0eYMy0cUPZUlywk/glOM1NKb467Eb2KGd4TzxXY/IikT6vHye2iBjs15O3d
	UEmExXNQ+Ne9JPA8mloIBRS4TFkdQFZ8LdY4Rt2cnRpI70Htfj5L9mRMRlWEo1j4oA88gcF3I9q
	Tw95F5tpabuvQtmSm8IOVXNZL2AEZlnzi+2HiEka+LG7SiXSqWcDQF9HMDS26wkYi9YRFEprR2J
	K9x4T8VtEW0uw5IFGydMVIllZQAwoMItZ88MTW03Zq+1hyr1ebA0i/Xb8psxoc3u4sfNuh019MS
	1Jhi2YTk4FUwZqtx3So8YiVCQK0LahFyz/Nz4Lsb7Xoju7O4x9vAk56NjwgWJwk3ZwCwAY+1633
	7a4aN4BFTHXLrjvfglwT0MIFDSz8mhr/YBPTJZ7WvLNIKfb/bWsQNVpg5zCbOTMd+6bBzJJtDTX
	jWYVjIXt5kxG80kHQ==
X-Received: by 2002:a05:620a:40d0:b0:93e:e111:2778 with SMTP id af79cd13be357-93f17ec6bdamr197751885a.14.1792095670950;
        Thu, 15 Oct 2026 13:21:10 -0700 (PDT)
Received: from [172.17.0.2] ([74.235.102.249])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f1a0cf974sm25670385a.1.2026.10.15.13.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 13:21:10 -0700 (PDT)
Message-ID: <6ad135b6.8c8d7b34.636f2.6f67@mx.google.com>
Date: Thu, 15 Oct 2026 13:21:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2011742658252555776=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, aluvala.sai.teja@intel.com
Subject: RE: Bluetooth: add hardware rfkill handling
In-Reply-To: <20261015181829.1692108-2-aluvala.sai.teja@intel.com>
References: <20261015181829.1692108-2-aluvala.sai.teja@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2011742658252555776==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1186713/

---Test result---

Test Summary:
CheckPatch                    PASS      4.01 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.24 seconds
GitLint                       PASS      0.87 seconds
SubjectPrefix                 PASS      0.26 seconds
BuildKernel                   PASS      29.73 seconds
CheckAllWarning               PASS      34.04 seconds
CheckSparse                   PASS      36.84 seconds
BuildKernel32                 PASS      29.69 seconds
CheckKernelLLVM               PASS      37.17 seconds
TestRunnerSetup               PASS      707.49 seconds
TestRunner_l2cap-tester       PASS      12.57 seconds
TestRunner_iso-tester         PASS      10.66 seconds
TestRunner_bnep-tester        PASS      3.11 seconds
TestRunner_mgmt-tester        PASS      87.68 seconds
TestRunner_rfcomm-tester      PASS      4.49 seconds
TestRunner_sco-tester         PASS      5.62 seconds
TestRunner_ioctl-tester       PASS      4.66 seconds
TestRunner_mesh-tester        PASS      5.51 seconds
TestRunner_smp-tester         PASS      4.34 seconds
TestRunner_userchan-tester    PASS      3.18 seconds
TestRunner_6lowpan-tester     PASS      4.42 seconds
IncrementalBuild              PASS      30.18 seconds



https://github.com/bluez/bluetooth-next/pull/953

---
Regards,
Linux Bluetooth


--===============2011742658252555776==--
