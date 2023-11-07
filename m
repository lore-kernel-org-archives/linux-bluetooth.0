Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6729231584
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Nov 2023 14:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2QeLcbV"
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DD2FA
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Nov 2023 06:33:07 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-77891c236fcso401350985a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Nov 2023 06:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699367586; x=1699972386; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UFNwBDjW9pPmG2wO5iFT5XzGGrMzUSR0ADsaFREk7JM=;
        b=j2QeLcbVwMUM3oTO74O48K5tD0O0E3nCCaZZ+xijMM9fHFLuzjUcSGss+JTGW5YRoA
         ROw4Cm8oQqJphGi/eEJxTQeneaMUa33k1tTjx7KLrnPomsOMVK8DqK9pK+yDLdK6Vuzx
         M7oCpIemauEsgzj+I99tKmFCOAD4YD3qau12Y9d/KWGAYWENXv1aca36N7eL+dX4b2Cw
         vKMOG5ix5Qbnajj8jFX7Zz77ktGSITbVlWwUahvaf9EmgUB6TOhllWeseC+YeqcXDI7s
         IV8wEhfdUIsjMfoF7VPkzLSVRxdY3CwJm1RUR33ijbugpHKnOsVm+v9XrLKPwvHe7nFL
         B2OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699367586; x=1699972386;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UFNwBDjW9pPmG2wO5iFT5XzGGrMzUSR0ADsaFREk7JM=;
        b=AH/KiDVywkz7a4BeBYDcFFANDY8BRCQm/GylaWb1LYfReam7XmKV96JXjwUhquORgv
         Z/BputomgNWiZF/Cdl7pTMJYgW1MabPcTBI3ep7KU+sV5vhrNqWICbbSq/0dqv5TsPYz
         +VQt60FxsK/gBAlgfQ7bG9Hmhm0c/yAu9DCNmnNR+MkNtnpNFhzz/9YqouQlociCat0d
         gns4xOc7fH0fOmpbLigmg4avuf7871WFRn412DIVde9dYkkv8mPmWQFLYFF25glNiIGN
         Hy9yzIXm9AxtWP+gfOsUzdz6gy/Rq8Q8sKHFtxc3VsTa/D+zDVR+sOTimfIpXo2DHwlG
         1R1w==
X-Gm-Message-State: AOJu0YwtEzbnj48mAhHMi2VUXz67aor0WsS+hx+QZaWwdB685ofGGsJ3
	dx35PvruJFXmuIHpDHBGflAzZaMAkGZg/g==
X-Google-Smtp-Source: AGHT+IHnRsF7JoVPknVHjO1x6CWsS+MFwhy+rxkLXxhwAyTfj7gWM3duNJ6QvGnAmCV9n5gpS/zNpA==
X-Received: by 2002:a05:620a:2589:b0:778:94cc:723 with SMTP id x9-20020a05620a258900b0077894cc0723mr36260991qko.1.1699367586287;
        Tue, 07 Nov 2023 06:33:06 -0800 (PST)
Received: from [172.17.0.2] ([40.65.196.146])
        by smtp.gmail.com with ESMTPSA id po2-20020a05620a384200b00774309d3e89sm4238748qkn.7.2023.11.07.06.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 06:33:06 -0800 (PST)
Message-ID: <654a4aa2.050a0220.da763.307b@mx.google.com>
Date: Tue, 07 Nov 2023 06:33:06 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2113754779430457715=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, mmandlik@google.com
Subject: RE: Bluetooth: btusb: Return when coredump trigger cmd fails
In-Reply-To: <20231107054609.1.I4c7ab22148e168e3cde00f27b89748ff4bc651c2@changeid>
References: <20231107054609.1.I4c7ab22148e168e3cde00f27b89748ff4bc651c2@changeid>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2113754779430457715==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=799445

---Test result---

Test Summary:
CheckPatch                    PASS      0.62 seconds
GitLint                       PASS      0.31 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      27.97 seconds
CheckAllWarning               PASS      31.30 seconds
CheckSparse                   PASS      35.53 seconds
CheckSmatch                   PASS      98.27 seconds
BuildKernel32                 PASS      26.39 seconds
TestRunnerSetup               PASS      414.20 seconds
TestRunner_l2cap-tester       PASS      23.07 seconds
TestRunner_iso-tester         PASS      44.26 seconds
TestRunner_bnep-tester        PASS      7.05 seconds
TestRunner_mgmt-tester        PASS      171.48 seconds
TestRunner_rfcomm-tester      PASS      11.08 seconds
TestRunner_sco-tester         PASS      14.66 seconds
TestRunner_ioctl-tester       PASS      12.12 seconds
TestRunner_mesh-tester        PASS      14.57 seconds
TestRunner_smp-tester         PASS      10.12 seconds
TestRunner_userchan-tester    PASS      7.48 seconds
IncrementalBuild              PASS      25.79 seconds



---
Regards,
Linux Bluetooth


--===============2113754779430457715==--
