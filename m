Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290F118EB0
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jan 2024 20:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LN9F2H9G"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-4b71b86ef81so1644933e0c.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jan 2024 12:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705352231; x=1705957031; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CBrvomtL8B3nbzAKZ1JDN0n+R4+p5m9nXf2IC08pFlo=;
        b=LN9F2H9GhGwggpOcFllTZw4Dwevjfb4OIQVSOZIXAt6VxLV3tTlc8Wa3ipeeZdEBfK
         AjKVr5RFGQyEC1YdCtiPHoHLJGv4FDtLwv//g4y/cGEIYjW9rCkPQYWGSqXuF/gLQzvb
         ZSbzms03igrA2AkdQ35H77yelIGH2dnhMKRhvOFPBLvi3OoMnhpAUQWhjKrzj5YqdWDS
         3RSUfJDvNVIZ+LmMRKP6AxhS9f0Z+Dzt0GsUOWiRO3swnH/EKUD+7X56N+CDBaII3Huw
         ZXaAP/24g7eDWt2lJpemJB7XV8RApYV5J9DzYBZ2hd8CuNNRrW2PxLudiCBtrIaEnYsc
         ocGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705352231; x=1705957031;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CBrvomtL8B3nbzAKZ1JDN0n+R4+p5m9nXf2IC08pFlo=;
        b=g7Zqndj+bexLmpv3tCheEHyOM1CV9XHsVn16350SVYW/5NilCErs9cN/EjRp283nZF
         NWvquicZIiiOkPuU6Y73EG8JtFXafe8B8FYK8cAk29L9SMz9cgn31dBoG9DkWSbpUqA7
         7GFxPGZfyl8sh+JjhR2vxy6TiCchbQG2Y5V/fe0WrkSAQuFYJbFtiNNFjbJEqWLS3gM6
         mU/RuineF96X23siA/B5kIse/agxu1rV9fHpzMgSCCV040gnnriZSOBnXI0X2a1IjJnr
         mOtfODZe0oe4PhCi6SyYUG7XLsWH5Q2lYd5FsdtgXriDPHFPqIO/MVb84mR7LIr/mPao
         tXmw==
X-Gm-Message-State: AOJu0YxtOwkiccmUG/E3EzRyPU5hyu0wsWvVdMnGEKc1TZDCff5d2z3j
	Lfvh1O0/e9tHw0QUSKHMLekGW+i1qSg=
X-Google-Smtp-Source: AGHT+IHs6hAR+kj0ftWJOJLjselRTCH6x7ayrqHXOIjQMRwMnCeAjVCLE4S09HgK18EIMlGVfgsm7A==
X-Received: by 2002:a05:6122:1988:b0:4b6:e467:ec9a with SMTP id bv8-20020a056122198800b004b6e467ec9amr2979394vkb.16.1705352230795;
        Mon, 15 Jan 2024 12:57:10 -0800 (PST)
Received: from [172.17.0.2] ([20.75.95.36])
        by smtp.gmail.com with ESMTPSA id w12-20020a0ce10c000000b0067f70cc986asm3611106qvk.92.2024.01.15.12.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 12:57:10 -0800 (PST)
Message-ID: <65a59c26.0c0a0220.49363.ec20@mx.google.com>
Date: Mon, 15 Jan 2024 12:57:10 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1726580431904341237=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, christophe.jaillet@wanadoo.fr
Subject: RE: Bluetooth: Remove usage of the deprecated ida_simple_xx() API
In-Reply-To: <3b3523b475d0f5cadf81b3131bb1a38b7476b020.1705349526.git.christophe.jaillet@wanadoo.fr>
References: <3b3523b475d0f5cadf81b3131bb1a38b7476b020.1705349526.git.christophe.jaillet@wanadoo.fr>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1726580431904341237==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=817021

---Test result---

Test Summary:
CheckPatch                    PASS      0.78 seconds
GitLint                       PASS      0.99 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      27.82 seconds
CheckAllWarning               PASS      30.32 seconds
CheckSparse                   PASS      35.92 seconds
CheckSmatch                   PASS      99.05 seconds
BuildKernel32                 PASS      27.00 seconds
TestRunnerSetup               PASS      433.53 seconds
TestRunner_l2cap-tester       PASS      23.07 seconds
TestRunner_iso-tester         PASS      50.97 seconds
TestRunner_bnep-tester        PASS      6.89 seconds
TestRunner_mgmt-tester        PASS      164.42 seconds
TestRunner_rfcomm-tester      PASS      10.71 seconds
TestRunner_sco-tester         PASS      14.35 seconds
TestRunner_ioctl-tester       PASS      12.36 seconds
TestRunner_mesh-tester        PASS      8.78 seconds
TestRunner_smp-tester         PASS      9.76 seconds
TestRunner_userchan-tester    PASS      7.35 seconds
IncrementalBuild              PASS      25.77 seconds



---
Regards,
Linux Bluetooth


--===============1726580431904341237==--
