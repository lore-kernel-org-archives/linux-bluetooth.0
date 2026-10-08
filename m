Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC38143B6FD
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 08:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791446903; cv=none; b=LQ3GfZOa3peWqDpz7s7zzbNuXtfnImNYAWO3i7WYZv7QKPT8XGZUALPuiJKQPl1EvyJh4Hm222biRV7mTeYHWSpNO6CmYkF+DGTbgu7yATH58NhCcappwOp6xILJpgUcoVbf62SaM+abfg0Bc7xH9PPqSJowlOFSusDHL0faoow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791446903; c=relaxed/simple;
	bh=1YIm9qMlmkwfDud3mHLIzKTFicriAOZd/mmNuvLjhEU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=iDnwCZc87PBLL8DaXFFN311AQ1OPNc4EKZ+2DZFrLV8QX9ShnkE3JPraLZ7dJnCJuIYYI4KvVBS1WtRt3cbRRdRl83hQY2krD/dzdW4nF7pLJlOD/KwqkMsBYCWdz1eVaK6C217oTpkRi0K2pqsIFUCWimoAoEYGQyjYMcKpA4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BmHAiys5; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmHAiys5"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5339381b46eso24660021cf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Oct 2026 01:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791446899; x=1792051699; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HOj6lk43GZgrXxNXtmZ4o2N0SZ8WJgFwF4J/it3bFj0=;
        b=BmHAiys5v+Pgk4w2ql8BAMxLSvcfRHajPG62QqHlj3FfOlNsdy1OYRj4GJrYRg37Oi
         sZitgXBwpVJQQBrDzbI+Sheak0GZkQk/ZmbIxSko73kwwlqN14AM+pzB48iSiPLfxwBK
         08KBa2yy2QdEecOneZHG2FWnPptFNY6U20EfWqTP5nASWR3sgmbYotn509SNwXPmyK97
         jWGwWrJIYGcONNBHQm127XFGoyEMhTsbn38drV3WDQpQB+YPHp+NnNr9UV+6zkBefkQb
         SckNN8+itxMg9NN5rwV2kS4YJxywGp7O0hc2ENcaJU0J6V55v5IbKgcuFrVVG9dVYLuZ
         XhVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791446899; x=1792051699;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HOj6lk43GZgrXxNXtmZ4o2N0SZ8WJgFwF4J/it3bFj0=;
        b=Fa0iVGGxjadevo2gUctls2+Q1o6yTmi3Z2NScYWUz+n+TVFBi2ootIgxyzz+doaB4G
         HfpVHd6Nvojwn77U9sQsGjWnB8DEi/+GX6Ji357UJ8aGwVWUVHM+iQKVjjh1Bsa9ymop
         XJGBXLLenkF/fO6vXpFiscg4j51C1767zLN0sA/o1z1p8eJRIUnUGISmMfcUnXtjlbzt
         HS+uXZuDbQ40x/SBgz5jsrRBIh1/uby+7xqf3imfrbPr0ZgeIf+kqIiG0Fz33rBn5N+0
         e5/1ao96Z0bQkEbWtFE2G/Y2NgVFA48C8/QnKqow2+2tUmqFxOHfsfk8suMWZNFDHVf5
         rY/g==
X-Gm-Message-State: AFuF++mO9Fgsv7cVEEZyhyjcphftr5RAPd5vY30bg9geOCH/ZITTjugq
	VpEiMST5QZSnhaL8FU0Go87ApkcnGO5EAROwc3D/RjXvTWsOyR/anRx/5dRtnw==
X-Gm-Gg: AYBFou3iuV4NjCAQTN5GkYgpedlRnGD3fTSBKmTeGMcSmlGuPpp7bmsmFrv57Mgtfg1
	zn/S8YuX9IWtb5maO1ihyUnryHDz/QG5LY0ik6oA/dQXeNIUNTUkVhvPurRd5B5ua9lYKdeIN7d
	0jqOpPV9tBSv1qTY7eIUagjHaGm1097Zr8I8UWk5hB9KsD40FIXzHqpeuF9CISHPl2th76RsWpv
	AsX7ux0iCutYtNdR6azOsV2t2Fd0zqxxAzVN4gVCOuooaQaKfhNeLIT89YJFeKaWLV6cMnEgpKB
	/P9j54U/U8/Q4ITtxb01M/nCbHOc2Izer7MpWtwnTkkzI7hdu80DK0saCyRhbWxMz5OwhYg504D
	zDg0PqnbYnoo9StCnijuxtZJDLsGAG/lbrJuarXvpcaheAS8aaquhyZtWmJ1HNZFgfi/amB4BjH
	9BNG9VBeQM4+xySZFjDrZ5z9aCs39Ois/upr0Po/nL7aKLXgWY0CXnmtZItc+3WpQ8UaPTK7HiN
	ByCecw=
X-Received: by 2002:ac8:5a48:0:b0:535:70c4:9a8a with SMTP id d75a77b69052e-53575778ac4mr76730911cf.64.1791446898751;
        Thu, 08 Oct 2026 01:08:18 -0700 (PDT)
Received: from [172.17.0.2] ([20.106.198.166])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-535720ea17csm38901781cf.12.2026.10.08.01.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 01:08:18 -0700 (PDT)
Message-ID: <6ac74f72.bfbe2361.2e8ba8.9590@mx.google.com>
Date: Thu, 08 Oct 2026 01:08:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5623328504506550168=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zzzccc427@gmail.com
Subject: RE: Bluetooth: hci_debugfs: Pin the module for open dut_mode files
In-Reply-To: <pm-bluetooth-objects-candidate-0251-v5-7e4e8154d66ac0e60df2@gmail.com>
References: <pm-bluetooth-objects-candidate-0251-v5-7e4e8154d66ac0e60df2@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5623328504506550168==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1181239/

---Test result---

Test Summary:
CheckPatch                    PASS      1.20 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       PASS      0.35 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      29.38 seconds
CheckAllWarning               PASS      33.30 seconds
CheckSparse                   PASS      35.97 seconds
BuildKernel32                 PASS      29.24 seconds
CheckKernelLLVM               PASS      34.87 seconds
TestRunnerSetup               PASS      778.98 seconds
TestRunner_l2cap-tester       PASS      12.84 seconds
TestRunner_iso-tester         PASS      10.64 seconds
TestRunner_bnep-tester        PASS      3.25 seconds
TestRunner_mgmt-tester        PASS      60.99 seconds
TestRunner_rfcomm-tester      PASS      4.46 seconds
TestRunner_sco-tester         PASS      5.86 seconds
TestRunner_ioctl-tester       PASS      4.66 seconds
TestRunner_mesh-tester        PASS      5.60 seconds
TestRunner_smp-tester         PASS      4.28 seconds
TestRunner_userchan-tester    PASS      3.17 seconds
TestRunner_6lowpan-tester     PASS      4.40 seconds
IncrementalBuild              PASS      28.31 seconds



https://github.com/bluez/bluetooth-next/pull/877

---
Regards,
Linux Bluetooth


--===============5623328504506550168==--
