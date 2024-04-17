Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA18131E33
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2024 12:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713357576; cv=none; b=CnyEy5vEt7/PQAV30zKyu00U56xnkdx4GWf8jlq2a4R3QjdLnA4ulnueKK+lS5ev2++LlpkeHScoiU9mvIRFeUCrNJ5rdHcOhdYT0J56si+Hyc7qKcL7DOesaPOOL9GipzLZ4T2SjWYIFlU6FbEmPFW/gVUPH0V9hqX3+2RMpIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713357576; c=relaxed/simple;
	bh=588tbKkLd0RMgvwsGBZZhWtgWagSC+XplFLZW0p4eDI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=HjLEGTwAHSSXHf9AW/OvyHze1CG4+YyXCKijvKOWMyrwiYzINDN9I2j5G2tpcFd2AAuWYIgVd2zVp5lubYCBT/SA6MBlkQ7SjeJOkOG87OgVjgqFXRnr/7V6iKszwbrx+U7B8CPrUbz7/knmVwDOE0esUglkS0cMaA7dqI4/hwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DSsAe1HO; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSsAe1HO"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-69b10ead8f5so24664326d6.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2024 05:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713357573; x=1713962373; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GyfiX0dZwA/5NBxsPDphxMHgmoA69C8/r3xnOzaKvwQ=;
        b=DSsAe1HOHCatMtszNSSfopiVuaY/plRxe1yK12Obxr89tVFvRDx2LswUbKajOvRjgV
         QOemeoZe8QzsBG9APWYtS9NASee7YqLs+SaVVxsjZlPhqZcc6ynbxkFfJlM80OnDP/Gz
         RUonlQKJSmjhIqoIyhwQOnzRou5I6Y2rQ2bqa+6t8VWacSGhh/76gIqb34ka898zofby
         YApndGaFTKC9FHQMay8WhdhDaThFX3Lxy7jSf5ncrcVSGcV2981F4EM4Y0rMLDHZGDo0
         mAxHRkqdjFHHhrG/QM/CRBohGoL29vZGSeUVkwMjdrGw5m/Dl7Np5sxGz/v65KCBj1C1
         K4gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713357573; x=1713962373;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GyfiX0dZwA/5NBxsPDphxMHgmoA69C8/r3xnOzaKvwQ=;
        b=IUJsc1pYXJRdtOa0ynf6FH3eYoWrLRTCNUPCcIDdTQUaudXUFelG+Z1toqk7vK4ILb
         7J8ipPVZtdVwGF7XQSyCTWpA7WIKR5yi6w5A8nQ3J6jXZFUx7R2dfmBCj1ywEc7Ua8DD
         NedXgvRbId+8jVHc2SLq+BlJg/nn9FWhPrKMLaFHfROd/e9WAhP4K6dp28waZ5CJqiuw
         1h3hwYwa7rRhPcWeY2T/uTc5fxHe+zc0N/KNw1V4IyF3jxEHkYV9YiAm8yvBoblVGJkD
         biGMgFXlPkMVT4Htna4dd5sHbLyunGkcY6vayK/6hRWYOJ3GJYV1lOCXd69tJ0EtWlAk
         o8dg==
X-Gm-Message-State: AOJu0YxZqKtOu/bpXwUoaKYa4/e3iS9hPN3wbQPFTqRTjE4D3YG+7AVC
	fvx49X6r2HdDrsYPgpJ1274cNgw9fg5gPc07EomwVGhH9ixWQMVonhJY9w==
X-Google-Smtp-Source: AGHT+IEtL5DECtBF6fXgclTfeQ96KePHpKg+OGf61FHutrRsKdROuRz1JFGBiDZx08r/QeJleEQlRQ==
X-Received: by 2002:a0c:e8c3:0:b0:699:2212:3b33 with SMTP id m3-20020a0ce8c3000000b0069922123b33mr16324635qvo.19.1713357573037;
        Wed, 17 Apr 2024 05:39:33 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.52.212])
        by smtp.gmail.com with ESMTPSA id r3-20020a0ccc03000000b006969f5d3159sm8273828qvk.50.2024.04.17.05.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 05:39:32 -0700 (PDT)
Message-ID: <661fc304.0c0a0220.95080.6393@mx.google.com>
Date: Wed, 17 Apr 2024 05:39:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3098372055641031761=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: Revert "Bluetooth: hci_qca: don't use IS_ERR_OR_NULL() with gpiod_get_optional()"
In-Reply-To: <1713354823-17826-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1713354823-17826-1-git-send-email-quic_zijuhu@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3098372055641031761==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=845417

---Test result---

Test Summary:
CheckPatch                    PASS      0.64 seconds
GitLint                       PASS      0.30 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      29.80 seconds
CheckAllWarning               PASS      33.20 seconds
CheckSparse                   PASS      38.40 seconds
CheckSmatch                   FAIL      35.17 seconds
BuildKernel32                 PASS      28.95 seconds
TestRunnerSetup               PASS      525.36 seconds
TestRunner_l2cap-tester       PASS      18.53 seconds
TestRunner_iso-tester         PASS      33.68 seconds
TestRunner_bnep-tester        PASS      4.76 seconds
TestRunner_mgmt-tester        FAIL      110.69 seconds
TestRunner_rfcomm-tester      PASS      7.38 seconds
TestRunner_sco-tester         PASS      11.07 seconds
TestRunner_ioctl-tester       PASS      7.61 seconds
TestRunner_mesh-tester        PASS      6.73 seconds
TestRunner_smp-tester         PASS      6.70 seconds
TestRunner_userchan-tester    PASS      4.85 seconds
IncrementalBuild              PASS      27.83 seconds

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
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 489 (99.4%), Failed: 1, Not Run: 2

Failed Test Cases
LL Privacy - Add Device 7 (AL is full)               Failed       0.194 seconds


---
Regards,
Linux Bluetooth


--===============3098372055641031761==--
