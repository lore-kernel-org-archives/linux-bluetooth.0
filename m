Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xa8AUEI3"
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B485BF4
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Nov 2023 09:02:32 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-77dcf6330f3so34535485a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Nov 2023 09:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701277352; x=1701882152; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5Y25xy15SWZBxhkTLXEc6xWcAtdgNsc1O4eBX9m5wig=;
        b=Xa8AUEI3Jshp18LWocvxAMmpNefRkwsP5u6a+5S9cX4wTzxdOQlMZwX/q+smdd26ze
         gR/vhGZY4X7dirhhshloilN4hWNXC8089hMdHMygRTpt9VPRByFBmTMJJZzCj5ZZ5buh
         AhPh4y8cZLnT4mvYpMrwrav7Obf7gchyIMMKLBpjaQcyIISYbkvg2wT9XD/PT2PGxGWn
         5Utfp618AbZNvV5oEqaAb5ugjcFc/5YLof3BpFcP/FhQoZvdxI1BfdyQitSXbOmV5kKk
         YNUSMO0o6PAcvkc/4byqRvGJlCtsPz01kQtc3Ki1lZGiUdYGdI084qPqdE6PAzF2ACoq
         usdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701277352; x=1701882152;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Y25xy15SWZBxhkTLXEc6xWcAtdgNsc1O4eBX9m5wig=;
        b=AJH7VXFhkMuvY30PYFnlBj3TAxfevmPrgUyofbHatEEgHSJM+2oHLVPdp4XOEMHM/i
         1QYY7Cv/tI9RaaOvT3TjPIFaXKinLxQ7SxvNCZIcz2xpIdtfH1SL8DNTgmMinb+CcrgH
         TAvf1rF5B8Q64yC889emUs6gTrv619Xl7DM2PQEZSQQWdwsUIYuFgB5+9CmcnucaOpgz
         L79UnLnPp2JCLqSAYrQsNMcZQeVvtgm+4Xs6VK0Na0yinWoTNdfNXrxPf8VbuXalqr56
         eOFdk+6hIXv+623YIJOyK1uU/3MYaAq26sq/Lg89hkVj66yBfyUopGX8Z2kvqVZUzDPJ
         yODg==
X-Gm-Message-State: AOJu0YwZRWEt+RMl85sdj3hEwfpSfQ/Xbj3snSYKLDLyZ7m2Mds1h/ic
	dUjAIxVtcCEG2bc925KFmM1ZHJF34Nk=
X-Google-Smtp-Source: AGHT+IFF3VELTY0ARRzv/jsMEnmS3yePwsS2seTVdpz6k+ZWvvRCdn2At7D624/KiDBg+t9foQGw3Q==
X-Received: by 2002:a05:620a:260b:b0:773:c4c8:2d58 with SMTP id z11-20020a05620a260b00b00773c4c82d58mr20100593qko.59.1701277351579;
        Wed, 29 Nov 2023 09:02:31 -0800 (PST)
Received: from [172.17.0.2] ([172.183.77.195])
        by smtp.gmail.com with ESMTPSA id rg7-20020a05620a8ec700b0077d8622ee6csm4399747qkn.81.2023.11.29.09.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 09:02:31 -0800 (PST)
Message-ID: <65676ea7.050a0220.39ad.4d4a@mx.google.com>
Date: Wed, 29 Nov 2023 09:02:31 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5199101190003863456=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: Bluetooth: ISO: Avoid creating child socket if PA sync is terminating
In-Reply-To: <20231129162842.3596-2-iulia.tanasescu@nxp.com>
References: <20231129162842.3596-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5199101190003863456==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=805346

---Test result---

Test Summary:
CheckPatch                    PASS      0.58 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      28.69 seconds
CheckAllWarning               PASS      31.55 seconds
CheckSparse                   PASS      37.23 seconds
CheckSmatch                   PASS      102.01 seconds
BuildKernel32                 PASS      28.54 seconds
TestRunnerSetup               PASS      431.78 seconds
TestRunner_l2cap-tester       PASS      23.66 seconds
TestRunner_iso-tester         PASS      43.48 seconds
TestRunner_bnep-tester        PASS      7.13 seconds
TestRunner_mgmt-tester        PASS      168.42 seconds
TestRunner_rfcomm-tester      PASS      11.04 seconds
TestRunner_sco-tester         PASS      14.66 seconds
TestRunner_ioctl-tester       PASS      12.37 seconds
TestRunner_mesh-tester        PASS      9.08 seconds
TestRunner_smp-tester         PASS      10.02 seconds
TestRunner_userchan-tester    PASS      7.48 seconds
IncrementalBuild              PASS      27.07 seconds



---
Regards,
Linux Bluetooth


--===============5199101190003863456==--
