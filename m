Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XdmHkFBK"
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC5BD62
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Nov 2023 12:39:38 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6ce2eaf7c2bso2921622a34.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Nov 2023 12:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701117578; x=1701722378; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gLY1uq0OuX23CvHJIBT+vJbJEJget/T5uJ8DAatyhAk=;
        b=XdmHkFBKwP+NDM/gYYEIwo8rLtDGnhWHUazclqK/lS6PeyaEKlm/lHjgHqsrkxACy4
         Y/zLo4bOOnnZR3FawcYJS39FPg7DD5IBE4ZWe+BUlimC94L8joZvfDjEfM6rfOoilKTj
         /QJWNbhrnuP83fKP+lYuWKVxlsP9tm6FylUWHvmZ8u36x732R5AjeApxqFQPG+JHO1Hn
         +qlG2E2sdUoG2MmxSCjxJNVtgIKzVia9F0FFVvm+iqgd34U24i6qDnvDVze7o560066D
         eLrR4UsSHZH9WHzrmHbA6BoYcYRwe1eN/WBUWCIgW67RPlyf91BSu3MBg1TDq7AvDWB5
         rLJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701117578; x=1701722378;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gLY1uq0OuX23CvHJIBT+vJbJEJget/T5uJ8DAatyhAk=;
        b=Yd7KDOAQ17NsiM1DV0VA1HoXGSLjjgpQ+aBbXNaHxAk/uWq+tbRp2+3ZPzJlaftZfh
         FCw7tUTHko7bQLGjhbf3qDVsdhGGKHYUMDR+LdMml+LGCMyKV3Fb9qfCBS8muola4u/W
         kWT47YItUcaTYBnx6wZtqBw4rvRMGEHyr+RmcAv20/x88sYwKLmOcnzWiT1bEq04AlLR
         Tar6DDj1u6pC/dnaelRBLK5RlugPdTJwQHsDl7GO6TZya3H+I9j5i7RPeP0ExSDF68au
         yCkBuSBpkXFYJpn7M/39jHajYb57PbLOwAKWgfeGk7BBba47BMw026twpNrCA3TPps/9
         KGhQ==
X-Gm-Message-State: AOJu0YwNIMq1khTc+9OSvNuOE8QMI7vJIDdrtJF4EK6rnJxC2WZtIYN2
	RDdsdLg8XOfV/B5uTHkO4JpBjPXZeWE=
X-Google-Smtp-Source: AGHT+IGhAMB984QAcH9qay/hK+T6s+3MyiMKC46qVSTlLJgI+NpKvweu55aT2SdOjMKQO46HFn+lhQ==
X-Received: by 2002:a9d:7452:0:b0:6d8:1c20:85c3 with SMTP id p18-20020a9d7452000000b006d81c2085c3mr7690517otk.20.1701117577650;
        Mon, 27 Nov 2023 12:39:37 -0800 (PST)
Received: from [172.17.0.2] ([20.75.95.161])
        by smtp.gmail.com with ESMTPSA id k12-20020a0cf58c000000b006624e9d51d9sm4561663qvm.76.2023.11.27.12.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 12:39:37 -0800 (PST)
Message-ID: <6564fe89.0c0a0220.2c552.01af@mx.google.com>
Date: Mon, 27 Nov 2023 12:39:37 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8381887138588948880=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, francesco@dolcini.it
Subject: RE: Bluetooth: fix recv_buf() return value
In-Reply-To: <20231127191409.151254-2-francesco@dolcini.it>
References: <20231127191409.151254-2-francesco@dolcini.it>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8381887138588948880==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=804631

---Test result---

Test Summary:
CheckPatch                    PASS      1.76 seconds
GitLint                       FAIL      1.22 seconds
SubjectPrefix                 PASS      0.35 seconds
BuildKernel                   PASS      27.45 seconds
CheckAllWarning               PASS      30.18 seconds
CheckSparse                   PASS      35.86 seconds
CheckSmatch                   PASS      99.01 seconds
BuildKernel32                 PASS      26.57 seconds
TestRunnerSetup               PASS      416.78 seconds
TestRunner_l2cap-tester       PASS      23.18 seconds
TestRunner_iso-tester         PASS      45.81 seconds
TestRunner_bnep-tester        PASS      7.03 seconds
TestRunner_mgmt-tester        PASS      170.01 seconds
TestRunner_rfcomm-tester      PASS      10.95 seconds
TestRunner_sco-tester         PASS      14.68 seconds
TestRunner_ioctl-tester       PASS      12.14 seconds
TestRunner_mesh-tester        PASS      8.83 seconds
TestRunner_smp-tester         PASS      9.88 seconds
TestRunner_userchan-tester    PASS      7.36 seconds
IncrementalBuild              PASS      34.37 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v1,1/3] Bluetooth: btnxpuart: fix recv_buf() return value

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
14: B1 Line exceeds max length (110>80): "[    9.994857] WARNING: CPU: 0 PID: 37 at drivers/tty/serdev/serdev-ttyport.c:37 ttyport_receive_buf+0xd8/0xf8"
15: B1 Line exceeds max length (624>80): "[   10.004840] Modules linked in: mwifiex_sdio(+) mwifiex snd_soc_simple_card crct10dif_ce cfg80211 snd_soc_simple_card_utils k3_j72xx_bandgap rti_wdt rtc_ti_k3 btnxpuart bluetooth sa2ul ecdh_generic ecc sha256_generic tidss rfkill libsha256 drm_dma_helper snd_soc_davinci_mcasp authenc omap_mailbox snd_soc_ti_udma snd_soc_ti_edma snd_soc_ti_sdma atmel_mxt_ts ina2xx snd_soc_nau8822 ti_sn65dsi83 tc358768 ti_ads1015 tps65219_pwrbutton at24 m_can_platform industrialio_triggered_buffer drm_kms_helper m_can kfifo_buf rtc_ds1307 lm75 pwm_tiehrpwm can_dev spi_omap2_mcspi panel_lvds pwm_bl libcomposite fuse drm backlight ipv6"
16: B1 Line exceeds max length (93>80): "[   10.059984] CPU: 0 PID: 37 Comm: kworker/u4:2 Not tainted 6.7.0-rc2-00147-gf1a09972a45a #1"
17: B1 Line exceeds max length (85>80): "[   10.071793] Hardware name: Toradex Verdin AM62 WB on Verdin Development Board (DT)"
42: B1 Line exceeds max length (82>80): "Closes: https://lore.kernel.org/all/ZWEIhcUXfutb5SY6@francesco-nb.int.toradex.com/"
[v1,2/3] Bluetooth: btmtkuart: fix recv_buf() return value

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
11: B1 Line exceeds max length (82>80): "Link: https://lore.kernel.org/all/087be419-ec6b-47ad-851a-5e1e3ea5cfcc@kernel.org/"


---
Regards,
Linux Bluetooth


--===============8381887138588948880==--
