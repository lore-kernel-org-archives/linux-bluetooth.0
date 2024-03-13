Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1321A38DB
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Mar 2024 20:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710361970; cv=none; b=AS1C96jOE+tCrhDXgy642430PVyJnQaO+4nl39E52kkSticRnTFXFOheHI6RNnEYoznV8+yVRJFJPYyjSEBpMYzHm93k0zb/WXb0x4tYCm0U2bw0xrkpUQjmS7gxpB2q4NFMpAzl6y4vFViSWuubgV62ZLa9g2WoCqdbgOTy6AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710361970; c=relaxed/simple;
	bh=frznBwv9fSy86uSPsvDGwmuDCKSMrTP99OaiBgNcyBI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=owUbveKFw9eQjL4FrYEspUv+njJbm4ZQPS2D9SAD8tyTGQaAMR19znsHqTGml7DM3b1eTAYX1d72dzGtEVdyA/uZnub7Rvo7s+WVKXo2Owrd2XHHCUY1AJbsSpat17PFDH3tOpO+S0RzQ7plGZIk5TXL/7OeteKjnU4shn723Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FgdX+1MX; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FgdX+1MX"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e6ca8c8be2so42450b3a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Mar 2024 13:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710361968; x=1710966768; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4vrFW11pE54XIYUUpJLkSPwwaMuJEUEACewxpGm7ewI=;
        b=FgdX+1MXFSkci2P/7I6niBgYp+UEmYEdbRvBenYF+HaQs6qA3bsLC7rB7GWwuAFLrQ
         En/ss7tsQWIJZRuU+APeF7WD0X8Vg4SHsD8/Kqv/8Dww4S0hRW075pZzn/CHyDPjpbc1
         J5hZjA4neJ6zrWtuksMC8yVLaTD1ZyCYE5raDu5N3L8en/xeqj+VzeKVt8u2kFl2XrCA
         rAkSrRScpR1JjNfA5co6xo9N2T6LCmgfhf3NO+sFDJI/9c9ZsFbUtxpzGBCtbznH2OE0
         /GoF/x0cn3MS2JOIQoMHOE66nAsc6xtL6EBf0lMPQ243nh66D8ys1rsBRtfAMIQ0EnPO
         IDSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710361968; x=1710966768;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4vrFW11pE54XIYUUpJLkSPwwaMuJEUEACewxpGm7ewI=;
        b=n9j9f0U+Dwrmqp+8vMsTLFINcWkV9mf11Dpb69cjz6qLdylb+Jd23ICKv1NMn2a/j2
         KkKrZomqHgUyFmE8dkTxmw60FW5Q+9L6YuAeHzLmnCKie13AoxBOIsA7ldzVWjnDxADw
         z0it+LEXqo/6s7xVhcDuVNTeJccqkuMZIhw8+8fmoIFR1HMN8GniHBgy561OR5eWxP7r
         G5Fz5/H67EC+6LiBsONO/yJv73F783QFc/ra0uxFTGOFcn3+YbeT1CNvQChpuX5oUZR9
         fvRXtoXW5s3LzrjQQvFvXrQ0lVRtcHu+yN2w4OlI6o5ebA09jtBke+MyoN1l6YhxKXP3
         MjCA==
X-Gm-Message-State: AOJu0YwHomkdz1fPDtXuN+dMeeYHtmoTMIMFpHr1dJNpV2sjIt5iqkpz
	AI5xKeBiG7julpiArgWiU3gMA2vS4yiwFvx3QXQjMEHG1RdeML4RL4d1mrxA
X-Google-Smtp-Source: AGHT+IH3wRdyVYTmf2B8hoqQWQ4mHGvqPoDMQKCN4dwMXGuqsp2VLm4buSZeMKdV3yxTOtD51UOnug==
X-Received: by 2002:a05:6a20:e0a:b0:1a1:8075:725f with SMTP id ej10-20020a056a200e0a00b001a18075725fmr35621pzb.24.1710361968144;
        Wed, 13 Mar 2024 13:32:48 -0700 (PDT)
Received: from [172.17.0.2] ([52.238.25.48])
        by smtp.gmail.com with ESMTPSA id s20-20020a62e714000000b006e4d8687f44sm20984pfh.102.2024.03.13.13.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 13:32:47 -0700 (PDT)
Message-ID: <65f20d6f.620a0220.ef31b.0173@mx.google.com>
Date: Wed, 13 Mar 2024 13:32:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9207494930045064516=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: ISO: Don't reject BT_ISO_QOS if parameters are unset
In-Reply-To: <20240313194318.1397153-1-luiz.dentz@gmail.com>
References: <20240313194318.1397153-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9207494930045064516==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=835082

---Test result---

Test Summary:
CheckPatch                    PASS      0.46 seconds
GitLint                       PASS      0.18 seconds
SubjectPrefix                 PASS      0.05 seconds
BuildKernel                   PASS      27.83 seconds
CheckAllWarning               PASS      31.07 seconds
CheckSparse                   PASS      36.62 seconds
CheckSmatch                   PASS      98.60 seconds
BuildKernel32                 PASS      27.05 seconds
TestRunnerSetup               PASS      512.43 seconds
TestRunner_l2cap-tester       PASS      18.05 seconds
TestRunner_iso-tester         FAIL      31.24 seconds
TestRunner_bnep-tester        PASS      4.91 seconds
TestRunner_mgmt-tester        PASS      108.55 seconds
TestRunner_rfcomm-tester      PASS      7.44 seconds
TestRunner_sco-tester         PASS      14.93 seconds
TestRunner_ioctl-tester       PASS      7.78 seconds
TestRunner_mesh-tester        PASS      5.88 seconds
TestRunner_smp-tester         PASS      6.89 seconds
TestRunner_userchan-tester    PASS      4.94 seconds
IncrementalBuild              PASS      28.37 seconds

Details
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 117, Passed: 116 (99.1%), Failed: 1, Not Run: 0

Failed Test Cases
ISO Connect Suspend - Success                        Failed       4.188 seconds


---
Regards,
Linux Bluetooth


--===============9207494930045064516==--
