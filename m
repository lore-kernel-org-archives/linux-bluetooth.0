Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC9718F2C9
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jul 2024 15:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721056409; cv=none; b=RwQlgraGWtu18ODQM/a7NksrA18hzWAeZhj571vNieTbksEhxfxd5SxztQS88gb1TJ+Z6xKhxlUOp89iXfwu4z0baf1Ths8eKdNXHCBLd5lS+0+NF1WxLvYSd5Y1pjOsIjY3MXA865FPUYQgKT7tKbIjDCfMgJMhBIKh9mjNVeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721056409; c=relaxed/simple;
	bh=yl6HXAV8ZxhbmbZHp1jieRPZGOAgqPVk9EoYHjskqug=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=YeL+ZPKUOSsJQ1Ar0a9DT9SQCRoR32rtTsuJu8Wma9GyzgOhHUFzdTZ/1lGsLqhtnUCZdTkqiKTj/BUoW5HI9AR836v2oHlgT3ILLC9lp8hPxjzmw02yngQ53wCesLDe2rB7E1z9ccksAOsSxCvPmlxybO6N4fsriGz4anuAyiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OMn/o16P; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMn/o16P"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-79f0e7faafcso340421685a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jul 2024 08:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721056407; x=1721661207; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fcwKDOlYQjyIBuUNnJpakGoruArMrVfI7mAbzXjg+jI=;
        b=OMn/o16PO988gM2/UNGTuTPCPoKqN7bZblQ1VrJhO3i2yJ9/HC3sqboKS/zV3I5yJm
         38EohMZ0TErMW+LfRijGhiip2+VFiaFsDqOiSHcgK4Gye9yRe7FIF5BtGgdtxBBP0Tzg
         pa5xQ6J7oE/PMcNoylrfK8bF6cv3F1EMAvt/Juj476p++DNDMGHBStL6Y0xb+3dDeGo5
         HiocCiNORPjP0/ZjuuhpoHWw5gja+miwkoLn1E/3YVWO9FQUjRSsRHRjFxTwjgavgu+g
         VqTOdk/8sUBk8eafrL4RmAM9H13S0dDyH7xQKpgXdGM55xC9K4PZzMqCvfJ1iG6UWXL4
         tWlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721056407; x=1721661207;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fcwKDOlYQjyIBuUNnJpakGoruArMrVfI7mAbzXjg+jI=;
        b=Z/ED/Oh9iTcRS3wpjj7vCAu4x8dppZPvgPOYJBfH/tXqCyJYs4fg6RCoiURb7ZsDTv
         TSKXML2MNktpqKqgN3vMsRyVGx2PNZDrRfZnpf8mr/ed/puirfAmiBG3vI8OBVGuj8PL
         YpI0TKf96GesVGi0SgA3gIcUGHmVtgzVtAQwW+Wnd+Q35yqJk/X2z8dRycVcl6trDPM9
         STD0uSg3eA8PCc78H+4S1axMygbMGMqnCY/JW7l0PuMnjs7MPZCDnvqzG4u7auI1c4cE
         r9F1jHhNeokD+7N5v91+uvP1w72zW7tbxUi/PzTRfhWzG5EJJaIKOMD42rJZ1k0s4LpX
         0L+g==
X-Gm-Message-State: AOJu0Ywul/F4F8I/w8bxRxROhC2H027jbfXdXF6P6YixdGefkP1Wf+4M
	pFXuXYn260vs5ehgE+S6k1T211dpZ9YyZuo94NJATZ59aHKMnELGpIoktQ==
X-Google-Smtp-Source: AGHT+IFWV0Msv4G5LBQSeXoKfupBHC9PWgt4KdXqXHM2OBe34D99IouyY73zTvmhPwT6gwBEMaI0bg==
X-Received: by 2002:a05:620a:448e:b0:79f:bcf:9e70 with SMTP id af79cd13be357-7a179e72333mr7656085a.0.1721056406917;
        Mon, 15 Jul 2024 08:13:26 -0700 (PDT)
Received: from [172.17.0.2] ([20.75.95.110])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a160c63d2fsm206884285a.90.2024.07.15.08.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 08:13:26 -0700 (PDT)
Message-ID: <66953c96.050a0220.7d5ae.6fd2@mx.google.com>
Date: Mon, 15 Jul 2024 08:13:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2989731580104729490=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: hci_sync: Fix suspending with wrong filter policy
In-Reply-To: <20240715144730.311392-1-luiz.dentz@gmail.com>
References: <20240715144730.311392-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2989731580104729490==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=871404

---Test result---

Test Summary:
CheckPatch                    PASS      0.70 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      30.84 seconds
CheckAllWarning               PASS      32.00 seconds
CheckSparse                   PASS      38.57 seconds
CheckSmatch                   PASS      104.84 seconds
BuildKernel32                 PASS      29.16 seconds
TestRunnerSetup               PASS      539.09 seconds
TestRunner_l2cap-tester       PASS      20.03 seconds
TestRunner_iso-tester         PASS      33.41 seconds
TestRunner_bnep-tester        PASS      4.87 seconds
TestRunner_mgmt-tester        PASS      115.79 seconds
TestRunner_rfcomm-tester      PASS      7.65 seconds
TestRunner_sco-tester         PASS      15.16 seconds
TestRunner_ioctl-tester       PASS      8.00 seconds
TestRunner_mesh-tester        PASS      6.03 seconds
TestRunner_smp-tester         PASS      7.02 seconds
TestRunner_userchan-tester    PASS      6.12 seconds
IncrementalBuild              PASS      34.41 seconds



---
Regards,
Linux Bluetooth


--===============2989731580104729490==--
