Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F81355050
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Mar 2026 06:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773037303; cv=none; b=K9jwR0smYC/UFwlwtKnFfMh8wjsCnFV4SAz+K4Ge/ehYubxMgZLEbkKLgTrn1eW5WyEFB+5OPtJ1e49crFcHQZu86Uycu17jaQUTuFEzD9j/xz9ivRxwkoYsUZnQ54bv2QzT1nWq3+kmGuejRAF4P3FgiW/kgykCHFc0AecOg9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773037303; c=relaxed/simple;
	bh=PNq4wUmrtKUmtJOasNQJY4C3sVgjGCkq/yYTKnEvF6c=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=RlOhFIlaSMgK/h4TRg9KfJjNKHExdm012pBwFRG9hnIcMUrty6QosIizUTC+d2bnlGiJKUdYFsAybd+8fVtprN1uuxzy1P4BJLGxMtRa5yel8q/5tlF8t9SRh5vjoeNMIeyxJbROPIDlGlP3B+yUoCLkr1G6f3bsah3sTGbHHfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S1A4zLFs; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1A4zLFs"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-89a14be4733so78852706d6.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 08 Mar 2026 23:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773037301; x=1773642101; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=c+Ys2loRvVE9Lq6m7mYJZXVMfspzdvupsu6OfkEMmT0=;
        b=S1A4zLFs9hJppQpqlgKBag1UZI8X5FIo50MlBHJlR8wqqDPUiYSnePl11sfS3DDUbI
         X+IQ9INqStjK4v8nL5zWe1hrEB81b0jen4Dxc/9weh/pKwHkiLFw2v4qlL2qQbWRQifu
         23H9WpcXkyfImgdNC2WDx2DnzjRkmwWQKMiSAl6v7UHmhqNmp33A/REPvEfkfmxTbYht
         5G0LTwgaOc9fj0y6xkUYous22sBo9ylJz1VCTanmRCDyeER8Q6uxMKQRlOhBCfMqJDop
         dsLjQ4IbcX7s9SLpA/cOP3bv005qOrwj1VcXgbtIA3YFKLE2xLbkRr2PGQXgTwk11xbs
         aKlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773037301; x=1773642101;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+Ys2loRvVE9Lq6m7mYJZXVMfspzdvupsu6OfkEMmT0=;
        b=kp6K9DuO2y9G9PGvaG9JVObtpk4RPzwJYmZyGE7Zh9+uiV0QcJLQCXeV1UMAxy0lIL
         I0ZB/q+aJ8uUoibSYlwmTAyB/Kpr3D3yRXqQ9T1hYf0YSeaoH5+25IgOR9SUYpZP0Bqe
         s4ezcDlpFMDF7RHvh/NNkqbCYXMO5TTmrwpOxpNppuqEPYEw8BuLbAehh2thyVsarE0o
         yFStJHGPM4tlPf1UBlluQMiwF/3Snn6Iui4ccvksNr+7AdxZSxYfx2DHiP5LRoi6GQO4
         n7tZzzvHC/4eVnsaB5JefEmY+gLlKFPgXw/u+UluNkB5oyDWYWIxeR0zgvwHrNz9Fh9v
         UgEg==
X-Gm-Message-State: AOJu0YwXKq4QMxizkBxJ1rqf9JriZZj5jWLBm9bIlpGg74CxAzoadlo8
	GOQOnfaAvuNk6oaolAePHgpJV5YLCSVKOmN6dS6aTh0ACSJdCJih47U+/ns5NQ==
X-Gm-Gg: ATEYQzxmR5X2hCJWGg8BDJMmbbLJXIiBWlMscPA78SnT/HD3Yn9fNqGpzTQrc0M5I+w
	xSo564CE53Qudrblb/rWe8BZR+v7JfVH4NVNAiXNyYh0jmyLYhAqyW1LCWlJrDUrMuiL25zq7re
	PrrGGwDuTls7cJKMbscDA++TnHvh+tWmGshE5I3rI1A3GpvKVm+lOqHGs2ZRCFKP7mogpgNRCKH
	3o6x90XbaBrc4D09jQcc9v2GJsCuR1j/Q43yADZthB2CkecycPZDTpJevwKqNA5ryBWzktTKUHd
	fx33d22XrolfGKQ5BPC+1Gi4gr/MITlTxm9Le3RHLSKHFNEbNxAyank1pb0nJj22ifuFMU0y1t1
	Sy48Z1MDlRF4rKV/MaHHSy3AvjLgquBED8bEp7M+tn0LuKUaZN7weMAj5499l4vK78zmT7B7KuC
	LLYzUvrDCSYyOLUHyeeEnR7wnEPI/+YMhe461dfaJk
X-Received: by 2002:a05:6214:202a:b0:89a:9b6:f4f0 with SMTP id 6a1803df08f44-89a30a601bamr161152486d6.24.1773037301045;
        Sun, 08 Mar 2026 23:21:41 -0700 (PDT)
Received: from [172.17.0.2] ([20.102.223.145])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a3140e59asm73065796d6.1.2026.03.08.23.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 23:21:40 -0700 (PDT)
Message-ID: <69ae66f4.050a0220.22b4c6.50f5@mx.google.com>
Date: Sun, 08 Mar 2026 23:21:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5629109536009828529=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, wolozgabriel@gmail.com
Subject: RE: lib/bluetooth/mgmt: Add missing mgmt_op entry for HCI_CMD_SYNC
In-Reply-To: <20260309045902.2354-2-wolozgabriel@gmail.com>
References: <20260309045902.2354-2-wolozgabriel@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5629109536009828529==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1063415

---Test result---

Test Summary:
CheckPatch                    PENDING   0.37 seconds
GitLint                       PENDING   0.24 seconds
BuildEll                      PASS      18.04 seconds
BluezMake                     PASS      656.02 seconds
MakeCheck                     PASS      18.46 seconds
MakeDistcheck                 PASS      225.01 seconds
CheckValgrind                 PASS      281.58 seconds
CheckSmatch                   PASS      317.30 seconds
bluezmakeextell               PASS      168.76 seconds
IncrementalBuild              PENDING   0.24 seconds
ScanBuild                     PASS      955.62 seconds

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
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5629109536009828529==--
