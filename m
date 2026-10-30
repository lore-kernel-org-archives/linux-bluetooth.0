Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793374751;
	b=rbTee0IwgmPXncAdnaX1bsCXYlTDwiY0sCYVkY+Z1UZrL1mVPGbc7toN6JIyoy94o5Gj
	 Bvg1oqIZJ4Y2IJp9KyLsXkQ1yn88deSe/ichIXwWmygLkFxTgBm41xweDtz3ocbNMCxzg
	 d+mKp0OtCuJGE5WSfIfSUVpNfEHlhZufaMZlmbioXxG9nQyKG9EteDrOkvV8GiMOWFKGn
	 0VOxkh8R0rkjjWTLfwv+PtEDzwlLANRe1rRJ0bpHuc6hWDMd4BdGkSuGqsyR6DbJLtTLt
	 TKaX0emD8EiIwXCCH/gnmZgX0S/tTHgZqJDXkXUD1OEQ2V4sxdEYmzMFbx6Tv/VYiqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793374751;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=6P4vaVE/9VGAU55C3xuGCrv89T7qiQRJJZx4v52pAq4=;
	b=LqzswpstkLKbKZHNKEqilWOFWTrh11nOnHj1EbOan2tQ7EJ+jBpyzBhnL7qzprojCPU8
	 IOrbqBNfNmBtPiSwaS2YrCXJ94s0AmY5JBY03ciyBmIoueZOLD0v3hUWdvrr+rFVYn8Wm
	 qNpzMXSoZmhptrDx8DV1m5dKIrJ4bSwK3JR0c9fwVk2dR+4aQHacu8XZoqNovzODLfijV
	 CeJDjW7+omxcJNnXZcwrAYFvbu9nJYEMiLEnipgAy3GnT2GWIHczOpm8CQRERDzDV4G5z
	 cmHRnd+7IwjCRWtllMwvzbHEEviHCZkc5VpfsmavebJCBBT/qJ5JSapXHlUSe2R+Big==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z2K8uRGM;
	arc=none smtp.remote-ip=209.85.160.53
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B96E606A31C
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 15:39:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B96E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z2K8uRGM
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-483c607ccb4so520356fac.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 08:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793374750; x=1793979550; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6P4vaVE/9VGAU55C3xuGCrv89T7qiQRJJZx4v52pAq4=;
        b=z2K8uRGMIc1vERcshE6oMzhpJmS0I4hv70ascdFNTfLQ+GWkDqvrnqyyS9qLuUUSBT
         xsx4wGgtK18lu2D5QSPu8FHlK2R0+O2z0Stdv/UUKcCx02BFgT4NhnZxVXng+7+A2qWc
         twqG4JfYZKxx6V7hYVCJY7v/i57wjwXjQJr+ug3h0WrkxPnL2++fhcXc4tdIkcDnEjqN
         R/PSmXzkCDCfTH1jKXpgk7lczBMRZyGHqSSnTwKz+QnrheLVPEmPaEJ5+DNoT1IfIuIc
         2MFLMZT4+J9Fhw3kbjdrXBwHqkP2z4l6cwiT/3mryWSf4a3KolnHhbITHS5wXqdD2t3k
         y46A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793374750; x=1793979550;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6P4vaVE/9VGAU55C3xuGCrv89T7qiQRJJZx4v52pAq4=;
        b=OMLHLVcXd/V2vM7prXaSAhQpKj0ew+tfpgtrmeaux5fnK+F2iYu1rhnS39mlKokox3
         LqjJkvBicHOoUuxCr22QyL0uaJOJMQOyM1It/itcTqG3n1f6UlryZ2TrrWfORe7+Dp0o
         Z8GbdO6eCvdmG8a26nyOpCVyvTI/N0AYJ3nBrmVPpPkKF6dgfj09fqym7A2knDTD4idb
         sPn6M+Amxi7BTru689pXQtcwbl/iAvAlmRinmB5bm4SR62blggT2ZOnJbRAhSd++Sdx8
         HN88k004wIyPvQ7OAJLYx3o5Ifc8Li5S3cXQF0XTzZwaiWknk/kekTdky3de8Ip4iH+3
         NEcg==
X-Gm-Message-State: AFq9FYJ7PdsWmADrXazyqi3fKgN9dvXJD4jZIrm/lTepNAYbsv27q/0C
	gMEujECFlRU8IQztqQgF9FzI35wsOC6JEX3/EdHeK6ps2JQG9DV3QHGQbJObaw==
X-Gm-Gg: AYBFou02nY94ZPbmsY1IFbChdQXjfpWF8Dxr4muvIuXXriNTRxWYZpLJIhxAHGoOjFa
	wPOOdbXbqsJIkSUzZlx0FBB5/cG21j6T38eIZLUJtrHN5qad+FDxTcCzExWXABvE/yNqEMLxTnS
	bAuipCl/Ls8ds7dGHILZIYjn5pm9ofq2TjUK6eAaOV+0b8zL2SVRUjPLzFYhiyb9VlUN4ssCXrO
	aebv2PE+JuVrIDTrAENyY97YDBjLj7MKnOULZhQAYnm3ML4HCNPRVGL1kl9TtHMUITv5KNVuspy
	jHiemmrEGLaaKdNF++nkVtkl8jSuxB4eGdj8A0/hu1Wglwva+ITbQbgpXSFvfJ5sYINeQCnU8mU
	skoVFcyXl8Vtsg1uLCSDgZpUgpyZ0oMux2voT7KHirheROv7BMU27/nTCkmiY/RXOosBfWVbR7t
	Np3RaZ5z/MQdDdRpTE0zWPgJ1SdFtonFa7qWqXxWSdVw0qoEZptlR78DD+Bb0d2XMK5WZoTQl1Y
	SxuoyJ17AmWeifKKCWT4Bt9e7QXDP3G0kh2AKbqQXlG9SXeam6Uje3qsb5As+HW
X-Received: by 2002:a05:6871:7382:b0:4a2:4c5c:ff22 with SMTP id 586e51a60fabf-4a90783e6ffmr1897010fac.56.1793374749768;
        Fri, 30 Oct 2026 08:39:09 -0700 (PDT)
Received: from [172.17.0.2] ([4.151.199.224])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a9218ef39csm208973fac.6.2026.10.30.08.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 08:39:09 -0700 (PDT)
Message-ID: <6ae4ba1d.4076b79b.29942c.dfd7@mx.google.com>
Date: Fri, 30 Oct 2026 08:39:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8409720380208752672=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, jacob@teenage.engineering
Subject: RE: [BlueZ] audio/media: Fix build with --disable-hfp
In-Reply-To: <20261030090510.88867-1-jacob@teenage.engineering>
References: <20261030090510.88867-1-jacob@teenage.engineering>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8409720380208752672==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1196992/

---Test result---

Test Summary:
CheckPatch                    PASS      0.41 seconds
GitLint                       PASS      0.28 seconds
BuildEll                      PASS      21.04 seconds
BluezMake                     PASS      307.87 seconds
MakeCheck                     PASS      2.94 seconds
MakeDistcheck                 PASS      146.23 seconds
CheckValgrind                 PASS      157.22 seconds
CheckSmatch                   PASS      297.61 seconds
bluezmakeextell               PASS      98.87 seconds
TestFunctional                PASS      1161.34 seconds
IncrementalBuild              PASS      310.90 seconds
ScanBuild                     PASS      1172.54 seconds



https://github.com/bluez/bluez/pull/2736

---
Regards,
Linux Bluetooth


--===============8409720380208752672==--
