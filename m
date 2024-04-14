Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1562421D
	for <linux-bluetooth@vger.kernel.org>; Sun, 14 Apr 2024 14:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713106097; cv=none; b=ZPA/xWpgBSjSR7zMkBo1uhkyAvOgLUiIpUbjSmdAQuRLwBCPUm9g4h+OVlBVMWIQbKH6HoG0iYg+0ocAGYJ5cXJgm2fk2zjR87Gn6Z2qx4Z+Eac4l2E5AyKCY/P2Jnr8EMCb8+o8TqX9tD4oDQ3UiNhwCXzIVr06ICRYNKp/CR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713106097; c=relaxed/simple;
	bh=21Wwpk2NwGKY+skHUZ5rryj90p7QE10B0JgajiOoSnM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=qmu0/7tKdszeDf32Z5VPywumwglSdcRyfQPpU0TsoYKH+MBy8z4N+L7/m8XnSiOfwMJOuVOeUoJ6eyT/pAqx1E8TpxdHhFYz/7IoEG3zsR3N1LijGdo6oh4BBSTV23fYPziSgZWC1O4INSM/5DsivbUwgvtuJVt1fLeC/uGDLrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mDBFi1YF; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDBFi1YF"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2a6fa7773d3so1323787a91.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 14 Apr 2024 07:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713106095; x=1713710895; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=J+l1vxtFOw+nrdOmk4LJHmusteuNnf9En01MGDHLczA=;
        b=mDBFi1YFlf48IwMri09nfFf5JlihwRCxKDFnBzSgLONugl0x++AAlOsCo33Em5ONPW
         T/LdKG+lV9fb7lhJdlmGq4JI+uAIGO/RMMRyvH5lnrbaaQNzVMPCgnjxi0rHHxWufcEL
         zOvZcuzmQHPAR2R0bKgPS1eS+xGRY3ihq81TbJQUUoSPbJBqrsR/HeL/auyWy4SQ2zbC
         m7Qr3ym+8Zz8xIFtBmhxuj9gp9C2/cHiby4MNsfRFd+7xC1+qGqbwehQsd5Y/aBbS4R4
         +xSmdF8Rm9a3mSmrpjMjBbl7SwOOyo+KUJZpekC20kyOEXkEQkEc5Zj+zS9EFm6mqG3w
         35UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713106095; x=1713710895;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J+l1vxtFOw+nrdOmk4LJHmusteuNnf9En01MGDHLczA=;
        b=Hg+8KDMd//6u78XsQJ/gYB2cmbKj7/7rWxnsyeg32bvOxgGheRjRoQt+4SswZeFOV4
         ZWWafRlieAYD/sqLgDvkYClGq/oTjL+G5VQz1L5nmfHJTeMQl91jubkNici9zu8D1lvH
         ZL7UYF867BohThJk9gdI3eCsVsb+eJVI5s1xVQpPFeTZuDDNSIXea2bIAsrcmiYzBa8C
         O6gDyLxfOOcLXBHGBZ0LPW8LCTYxSN5MzeH26ZqJLWHR6L6T/xr5KaxSQoAg7Es28SLs
         u1qu0OYhj+zbMHifjmhJnrZVPQtFWhhg7lbtCN0XQ9agx+Qtn6k6RxRibuE5RgmNNV49
         8ToQ==
X-Gm-Message-State: AOJu0YwZ3oFO1BItuXGpgZaFaHzQ0rZlDKFON3YwO1FFaz7qp3EnFoZf
	/VPzBGXWe2RZCQXaVmnupK3kJGDsyVtWt3B6oEam8X1x85VdmwykW6n0113U
X-Google-Smtp-Source: AGHT+IEFYlUPiWyfIggwFwBzCNLNseUeuQYjT2ZPRJnWAy3ShrGFMbhTPFafzyBa9wmGs6yUqXmchA==
X-Received: by 2002:a17:902:ba94:b0:1e0:a3dd:82df with SMTP id k20-20020a170902ba9400b001e0a3dd82dfmr6214136pls.38.1713106095473;
        Sun, 14 Apr 2024 07:48:15 -0700 (PDT)
Received: from [172.17.0.2] ([52.159.136.144])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902f7c600b001e4928c8026sm2399951plw.13.2024.04.14.07.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Apr 2024 07:48:15 -0700 (PDT)
Message-ID: <661becaf.170a0220.38f97.5969@mx.google.com>
Date: Sun, 14 Apr 2024 07:48:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3096379804928242773=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: QCA6390 enable failure debugging changes
In-Reply-To: <1713095825-4954-2-git-send-email-quic_zijuhu@quicinc.com>
References: <1713095825-4954-2-git-send-email-quic_zijuhu@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3096379804928242773==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=844357

---Test result---

Test Summary:
CheckPatch                    PASS      0.96 seconds
GitLint                       PASS      0.37 seconds
SubjectPrefix                 PASS      0.16 seconds
BuildKernel                   PASS      29.31 seconds
CheckAllWarning               PASS      31.69 seconds
CheckSparse                   PASS      36.62 seconds
CheckSmatch                   FAIL      33.23 seconds
BuildKernel32                 PASS      27.34 seconds
TestRunnerSetup               PASS      495.97 seconds
TestRunner_l2cap-tester       PASS      20.09 seconds
TestRunner_iso-tester         PASS      31.99 seconds
TestRunner_bnep-tester        PASS      4.53 seconds
TestRunner_mgmt-tester        PASS      108.20 seconds
TestRunner_rfcomm-tester      PASS      7.09 seconds
TestRunner_sco-tester         PASS      14.63 seconds
TestRunner_ioctl-tester       PASS      7.30 seconds
TestRunner_mesh-tester        PASS      5.56 seconds
TestRunner_smp-tester         PASS      6.53 seconds
TestRunner_userchan-tester    PASS      4.77 seconds
IncrementalBuild              PASS      31.05 seconds

Details
##############################
Test: CheckSmatch - FAIL
Desc: Run smatch tool with source
Output:

Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: net/bluetooth/hci_core.o] Error 139
make[4]: *** Deleting file 'net/bluetooth/hci_core.o'
make[3]: *** [scripts/Makefile.build:485: net/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: net] Error 2
make[2]: *** Waiting for unfinished jobs....
Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: drivers/bluetooth/bcm203x.o] Error 139
make[4]: *** Deleting file 'drivers/bluetooth/bcm203x.o'
make[4]: *** Waiting for unfinished jobs....
make[3]: *** [scripts/Makefile.build:485: drivers/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: drivers] Error 2
make[1]: *** [/github/workspace/src/src/Makefile:1919: .] Error 2
make: *** [Makefile:240: __sub-make] Error 2


---
Regards,
Linux Bluetooth


--===============3096379804928242773==--
