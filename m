Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEDD12E73
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Mar 2024 08:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710318910; cv=none; b=NQaDm/1IljUKl/SEuMknsNM8STwuShm5BCNF9gQ2WiPmgMFSDCuZvdI61Jt0MBxNUwjmriABCakbonE57LylJaayvcDAAa+csgv46bCjPnTnCJZz4fHDLTqORLNh0cGrUAhxzyKFLpkWZDaJ+iqXjoGoPkWjhyfNPukl0Rh2GgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710318910; c=relaxed/simple;
	bh=d5PT0FmjCxmgNBnb6Ml0ySSgvVKWY75qPfVHVeywwt0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=DQ4JX9V49KEoDu8P4Bf2e1KVIM6HzOt6bjsIiMvDMPgL/Y94JnM7D719a7U7FIQnSHPyH047HbuLjfSQ4VMQWHPxXS9WDA1Uv2zfbA7LBaX1iqfG2fjUHSsKHtdnbtfPxwfl6n4V//SR5iSzsXvBU3i0Ph3qJ6oMOuRwVaN+2WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G30mUF/p; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G30mUF/p"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-607c5679842so66320817b3.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Mar 2024 01:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710318907; x=1710923707; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JnU+72I9COx3Gv9o7zKBpDLAtbVRSGfWtfM83Zjw74I=;
        b=G30mUF/pnpAuqAE97yho5bnGGuP/ZMj+GVqFL6zfwMJ00pqsd1rwnCRZOiJIWi17wE
         Ffgwg/lx4y/r2EoSdW7iUZo/gOFgy2CKLHIGUjJlbnWbo0zDIRgmjxY8u2c4ps1ktvbV
         Am9dm4tXi0FVb+QB9RCoJcCDb1BHXaxujbyQTWeVnfZPvqIHNwVM1J+yPgQXBlouVLt5
         YbI0GjD6YouTmvoxdTlhwbQrtDXv/zV3fMMxBxqv1MuJ9o4f86pF+PEyiRzCFjSKk3na
         u8T/69jGdQiACiNMvkds95kfBzx93qDk4Sgdrz9Rm7r4NbHwRmPWr+K1AiSUbepsbbE/
         BgBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710318907; x=1710923707;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JnU+72I9COx3Gv9o7zKBpDLAtbVRSGfWtfM83Zjw74I=;
        b=aCMGcw3ISIq0n2W6DU3Ww/T0U8uKIs+5N1qwN1r6e7Upd2hTY418phc7lg1yQxT3gi
         pE45UQufj/CpiClmDm06paxBYhaHS3cFcWuGieRIoo/yt8c+Wnwn36OGOAIvLtxOmFF5
         UD+erIydDjGan+2iDnhXD0P/nnli90441nyGqivfuERgZht6b2rE1tXX+3Rhbi6FQuQH
         CYSx+MGSJmKee97uEJx7JQiTin/sj6gE/HsdnoS36KGeDGCwc+uPbTplz+4n3/rnoXfp
         iAyIVCWrLDG+hoEwMhRgeDQF94ILt40aruz7Ij4H1OxCW2TOXXIfD+aD5N1jXzhrxtMG
         ejfw==
X-Gm-Message-State: AOJu0YzP8XSlCKK0sGsZXjZRpnRCbeIZExCxolQYyCqXMrFiES5QMPkt
	zWFwpu9YzyKXET2B9PLhXDBYGnq4tlu1i3HNqEz1/OsnLeAN2SAQXAG08zqm
X-Google-Smtp-Source: AGHT+IHe/N5X++bdb7oV835b/ei32Qd0L6BHdXyl6XKBzYVcPlQYSNdhSS+CYaQGaqwVBTNwk3SaVg==
X-Received: by 2002:a81:4843:0:b0:60a:17a7:6996 with SMTP id v64-20020a814843000000b0060a17a76996mr2032332ywa.42.1710318907598;
        Wed, 13 Mar 2024 01:35:07 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.132.75])
        by smtp.gmail.com with ESMTPSA id l11-20020a05622a050b00b0042c7d11e280sm4521887qtx.90.2024.03.13.01.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 01:35:07 -0700 (PDT)
Message-ID: <65f1653b.050a0220.c5070.1c97@mx.google.com>
Date: Wed, 13 Mar 2024 01:35:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0952309051114677028=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, youwan@nfschina.com
Subject: RE: [v3] Bluetooth: btusb: Set error code in btusb_mtk_hci_wmt_sync()
In-Reply-To: <20240313074358.427090-1-youwan@nfschina.com>
References: <20240313074358.427090-1-youwan@nfschina.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0952309051114677028==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=834873

---Test result---

Test Summary:
CheckPatch                    PASS      0.59 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 PASS      1.71 seconds
BuildKernel                   PASS      28.26 seconds
CheckAllWarning               PASS      31.08 seconds
CheckSparse                   PASS      37.14 seconds
CheckSmatch                   PASS      100.28 seconds
BuildKernel32                 PASS      28.41 seconds
TestRunnerSetup               PASS      514.97 seconds
TestRunner_l2cap-tester       PASS      17.99 seconds
TestRunner_iso-tester         PASS      30.41 seconds
TestRunner_bnep-tester        PASS      4.75 seconds
TestRunner_mgmt-tester        PASS      112.65 seconds
TestRunner_rfcomm-tester      PASS      7.31 seconds
TestRunner_sco-tester         PASS      14.96 seconds
TestRunner_ioctl-tester       PASS      7.80 seconds
TestRunner_mesh-tester        PASS      8.13 seconds
TestRunner_smp-tester         PASS      7.76 seconds
TestRunner_userchan-tester    PASS      5.06 seconds
IncrementalBuild              PASS      26.63 seconds



---
Regards,
Linux Bluetooth


--===============0952309051114677028==--
