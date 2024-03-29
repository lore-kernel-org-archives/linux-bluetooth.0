Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A2A1E893
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 Mar 2024 17:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711735055; cv=none; b=RT901wmIvzafCHkjNuQ2bRUtRFOsNhx9ZBMGttoSVtU/WcBZHRZhlUMUI7ajVmcFl7O5QzL9svIMmSGufa0PgtoD82njfY/7JLs+ocmmTZ0yQTl8+jeQsdMfJ4atbgNtvt24Zbd4Uq7lKtR6zzjd/ADLTtlwS87MqjFk7CgETco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711735055; c=relaxed/simple;
	bh=s5DKnhxUC2Jce0L/or8W59+8StAVb4eKeWBolM51a8Q=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=g75Tzy/mdaI6jA1FbfwXH8UDekCcwbvRGlVUbOwJi9nqpLoGorTtGGD8QREkept8QKRxzhGg3XXoDoSVIDFs9mrl/QbDnX7WmVaPj3zH8LAgx7oIpVEbp27ka2w2+oZWsHMuaOLQ99Pp7DL12x3JTgIvgFxI+SeOYsDjC9i17WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dIJbaSAy; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIJbaSAy"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-696147fb5a7so17823106d6.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Mar 2024 10:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711735052; x=1712339852; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PCMnUt4Wqt/FPyHtsej/tmiHuZqVAysyOqkeatVzouo=;
        b=dIJbaSAyONMvwRQQLMvhznE4gh83ahQx+mw9X84ejS1VFxMMWmZTsNr1ZCJgm5Sexb
         RvO0Bd+VHzQR/BrKvMh9TURjKXXyh/7sisLF2Ewr5rNSe3fDQU2bPyC4n7rE/OlZRA5p
         fWFFs/lUVAul3rjvdWPI5BEzNNCZDR4135+igFzz7vgO0SUZCzdZMJHfikrRzjCR47oQ
         KXGqqBxBv9NFow/nZSZDZ4XYerm0AK8g34MWfEyouVKx2uwqwd849KpewnvVYche1Z+u
         yg1DBcVSxrlGVxJiDVyseo7sYoINlOyQ61syULyFxkhFHVYp8mV9UGvk5JSZUlp07sAB
         3rmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711735052; x=1712339852;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PCMnUt4Wqt/FPyHtsej/tmiHuZqVAysyOqkeatVzouo=;
        b=bZxs3ZZplMmoeX2lANSMTUgdvNkKHI5eVeUMZUcmX73WZTQTkr68cqHwtMnbGPKvSG
         SjSC56eqqIOAJrQpw5eGiv8eOx9ZeoMa9M/oO3C4VyhVgthpwEdXPbSJ7o2vsYizQlJq
         aF5sl1HW231B04Hsqyow2fRdFhqQlVhzkiZVMYMABatA2RcZIHFafHLm0c0k27gGeysO
         8bK7VEaRubFv9nN6/DjyXMJvkVnchLw/7n3UW+N5os2xw/SLzI2dPbGNz/h6rPmTgysi
         SaEoqDDxVW3JYVB1PJSgBHpBP9tY6UmPQmIpGRgo1wlSxHG2X8ZGUe3uaYchf1jcv98B
         Xjhg==
X-Gm-Message-State: AOJu0YyTljvcHRS2iJ7Gy2EKRNToIRjjUOfaDAfNyv30jvPYgjSbprgo
	0Ckv5E9X7lEGb3Q0vCCSF9FRAQtETLrTVdt7bCGfCqzO753tCY9LuDO/mw0K
X-Google-Smtp-Source: AGHT+IEk+QdVAm0wAO0hnryl4WC1L7gu9Symua+7eFQmZfsWIwqkAyUq+q42y98HoYB17rzqThW5Ww==
X-Received: by 2002:a0c:f303:0:b0:696:7617:2c12 with SMTP id j3-20020a0cf303000000b0069676172c12mr3040541qvl.24.1711735052469;
        Fri, 29 Mar 2024 10:57:32 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.14.153])
        by smtp.gmail.com with ESMTPSA id gg12-20020a056214252c00b006986d9c6b6asm1828485qvb.112.2024.03.29.10.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 10:57:32 -0700 (PDT)
Message-ID: <6607010c.050a0220.66e87.c673@mx.google.com>
Date: Fri, 29 Mar 2024 10:57:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0205271284827306202=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, krzysztof.kozlowski@linaro.org
Subject: RE: mmc/wifi/bluetooth: store owner from modules with sdio_register_driver()
In-Reply-To: <20240329-module-owner-sdio-v1-1-e4010b11ccaa@linaro.org>
References: <20240329-module-owner-sdio-v1-1-e4010b11ccaa@linaro.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0205271284827306202==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=839853

---Test result---

Test Summary:
CheckPatch                    PASS      4.61 seconds
GitLint                       PASS      2.29 seconds
SubjectPrefix                 FAIL      1.06 seconds
BuildKernel                   PASS      29.05 seconds
CheckAllWarning               PASS      33.45 seconds
CheckSparse                   PASS      38.27 seconds
CheckSmatch                   FAIL      34.67 seconds
BuildKernel32                 PASS      28.48 seconds
TestRunnerSetup               PASS      514.63 seconds
TestRunner_l2cap-tester       PASS      17.94 seconds
TestRunner_iso-tester         PASS      29.71 seconds
TestRunner_bnep-tester        PASS      5.63 seconds
TestRunner_mgmt-tester        PASS      109.04 seconds
TestRunner_rfcomm-tester      PASS      7.30 seconds
TestRunner_sco-tester         PASS      14.92 seconds
TestRunner_ioctl-tester       PASS      7.76 seconds
TestRunner_mesh-tester        PASS      5.83 seconds
TestRunner_smp-tester         PASS      6.77 seconds
TestRunner_userchan-tester    PASS      4.96 seconds
IncrementalBuild              PASS      53.91 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
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


--===============0205271284827306202==--
