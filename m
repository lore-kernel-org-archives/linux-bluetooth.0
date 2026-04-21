Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729A0377023
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 18:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776796036; cv=none; b=DZGtT5tr/iBc3VAm0pFGXx1FRMblqD5TY8ghoZiYpUUILhYcEXO2mHCVgcMr5vWzg/AJ78al/9exEW1eU/+nHIw9jbBeQUo1djmNFL7Q78weBqGf3R0tQFOV6iAAnWKJLD9cxUmCm4J77dJQE7pNojmCQOCe8x4pzCjvE78LyWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776796036; c=relaxed/simple;
	bh=HE2+eLkQOOvnI/jNxAARo5BMBl1vtTI7e66uwuLKxy0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=NUF2EGm+1zexPqqMc9TyhC97NrrVXo5aHk+useIQgKw6NtkVTnZOBI+nL27/gILaLtT7NV9kbS0Oqi8BYUQ9EMCqIbYspug2PnsDqx9tbP0jqQUv9Y1utJNJuEWLuy5WYZfk/s+zItK0oLQ5k2y6QcneXz5g5Df6k7PNxxPNtoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4vFRHFJ; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4vFRHFJ"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-50e614fdb42so22185101cf.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 11:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776796019; x=1777400819; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xm0ea2YWu8Eci5IT46a5t6WC1syL6xScXEIx5Bk1I0U=;
        b=O4vFRHFJMAXHu7TYfpI7E+8NU9dXL3fx1H2nJt5htgRp/+NYZPBYm262mxD1C2U5Li
         hOWZeQIGzZEDovwGrYpxL/4p4WwM0O2sR/JI8pepc44HacSdlCx5ZZqgKw9yiHJosk4c
         d326rTMSMpIFMJ4998gsCnL/ESbgZUhVIVr17JzUzLvxtqsDr2ey6WBLDo52Syx9otI2
         0XhgprG9rF5Kc6uF6iZu/33kTsTWsNSqo7OJLTjQHIWYrOhcf1eJinW7GO73EIkDQptP
         F0KhKF9e1ixlPruVr2SxHnGDYGN11IpGAhXDE/pP5Th4zuv1Nc3IK8CcO6oso7JDbe7Z
         Z5xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776796019; x=1777400819;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xm0ea2YWu8Eci5IT46a5t6WC1syL6xScXEIx5Bk1I0U=;
        b=D+ZCDin3p9K7Tp87/pjSgwgpa0Iko+fQm01VVDcIn5qS7LjohgJ5+eg8uunFaTGh8v
         5XZDRzBm468QBbMCIzYtUN9ggqlCRiNDDy6Wc86Izbaj0yxRcWxnSI/F2KzBWgJjx1XB
         jgSSTrbAKP6H1bQZ/pl5o8A6dIOK0ASJRAjBTilw1J7fPD3O7WqMOOYfmOaL55Wt3HCv
         MhjRFgeLSxPButpChErAN2PlppNjvPP6B63mfMUF0OeFVTv0vY/RrfGUnEljM0sWVZuj
         absOZ97C96pmXLjy4e3AH4kPnBJPg8jvOwCW/T/Ox5w4kPISlLs/P6M9vLn/xteZDIrX
         N9vA==
X-Gm-Message-State: AOJu0Yx37T9wFB5KNOjFnNhbZvqYpeCuSJ4Xfvut7HFpbHX2jne4qMd5
	EVbjHIXlE4AWaoDOGaxGU8oNwalqpMrtEm6k+KQ3s3LZNMnl3xcUOUj5ic5lMA==
X-Gm-Gg: AeBDietdI3frW0OS9SP9r57HiEm9Rll1m9PpnvoZGmy4KyGtTm/fnXJqSHmEmVDXLfq
	IhSiQBGegNhLZIiG6HJxjmswHpZQ45/a4yr+gE8mP/i/Y/Cl8mlSUFoV8ph8HfnSdvCt9XwBx8e
	zvnMiXhCW96kr0JeknGOwePLKocOqRi6+qV9O8/oX+i7DUsP5J/+fVf6T4D3cUQYezyzMpBPhLu
	oFO19KRv04dlgOkJv4hiEiBgKOFFgA2pTDMLiGtVXm8wcsZxcCo3aSc89EVjLF8R2IAbA9FIrm3
	i/ZbObrhTZaEv5WGDKJAJqQvW2P8daYg8S9LA1wROD8XgXjr2Zvhk2RaoUVJgge0oP8xVQ1b4Za
	0lkxO4zPjzhKbsE9TfC+5JBQFDo0YvV5vqOVgaXdjnjT16DNcm2TYCYz+tW/hZvmVjjUx8wPgac
	82yOy1J23DpaU+7bpBXB3/Vw/g0xhDvtKh4wweO84x
X-Received: by 2002:a05:622a:2612:b0:50f:bc35:ac3 with SMTP id d75a77b69052e-50fbc350e78mr29579051cf.36.1776796018927;
        Tue, 21 Apr 2026 11:26:58 -0700 (PDT)
Received: from [172.17.0.2] ([4.236.159.149])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e39487921sm111826151cf.24.2026.04.21.11.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 11:26:58 -0700 (PDT)
Message-ID: <69e7c172.050a0220.1f731b.ea52@mx.google.com>
Date: Tue, 21 Apr 2026 11:26:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1839337623380634176=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, michael.bommarito@gmail.com
Subject: RE: Bluetooth: virtio_bt: harden rx against untrusted backend
In-Reply-To: <20260421170845.3469513-2-michael.bommarito@gmail.com>
References: <20260421170845.3469513-2-michael.bommarito@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1839337623380634176==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1083952

---Test result---

Test Summary:
CheckPatch                    FAIL      1.47 seconds
GitLint                       PASS      0.81 seconds
SubjectPrefix                 PASS      0.25 seconds
BuildKernel                   PASS      24.88 seconds
CheckAllWarning               PASS      27.06 seconds
CheckSparse                   PASS      25.95 seconds
BuildKernel32                 PASS      24.12 seconds
TestRunnerSetup               PASS      520.13 seconds
IncrementalBuild              PASS      24.74 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v3,1/2] Bluetooth: virtio_bt: clamp rx length before skb_put
WARNING: Non-standard signature: Assisted-by:
#141: 
Assisted-by: Claude:claude-opus-4-7

ERROR: Unrecognized email address: 'Claude:claude-opus-4-7'
#141: 
Assisted-by: Claude:claude-opus-4-7

total: 1 errors, 1 warnings, 37 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14532816.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v3,2/2] Bluetooth: virtio_bt: validate rx pkt_type header length
WARNING: Non-standard signature: Assisted-by:
#140: 
Assisted-by: Claude:claude-opus-4-7

ERROR: Unrecognized email address: 'Claude:claude-opus-4-7'
#140: 
Assisted-by: Claude:claude-opus-4-7

total: 1 errors, 1 warnings, 42 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14532817.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluetooth-next/pull/113

---
Regards,
Linux Bluetooth


--===============1839337623380634176==--
