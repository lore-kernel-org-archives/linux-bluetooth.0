Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1EB5CE7A81
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Sep 2023 21:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjIVVyh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Sep 2023 17:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjIVVyg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Sep 2023 17:54:36 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205B1F7
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Sep 2023 14:54:30 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id ada2fe7eead31-4526d872941so1452404137.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Sep 2023 14:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695419669; x=1696024469; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sLDkgoOJBcZTEXI0TpB4/47M2qTKEkykMrxpcxSm++g=;
        b=NuZee03zduM+lkiwWD0lyamtD6xTz8U7J31fKId+qlYhpdVVW21hmoL52e5wIwwTup
         yLAcwmxq7eUd4Cp3BesjqjpkPYoVE+lOV2WsaQOMbLqawWmV1eOdTcV75u7vGRypM3kk
         2gctbhMt/baTiVsLNJyygTFgNGoxQ9LB1qYI5xxEZYeBUoSC76fw967v+VLthadYp4qx
         MfFdvQYmaa/SVRvc2oUwaYnL4oM9LXL+nWrrkLR+Wz8RtxYaRaEJpNcYn+RM6aWU+dRf
         ML1jVKN8QwZu88i1DDuq3rhftOz6473ILHddSIQ7A0P4iIhVLjUFXtKMx/+b6h33AWYq
         WPMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695419669; x=1696024469;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sLDkgoOJBcZTEXI0TpB4/47M2qTKEkykMrxpcxSm++g=;
        b=t2LoazY71Pbe/ADAK/9/Y/8y4wr2ARbFoGRF58se5WeGMeFG6CT4hZVV4kGEUbVata
         uK+LgQ+r/TssltdhmVUbpVK2DeMqBAXBv2yjJD3gEr3fM4htdCiO/9VSTSuWALAeLEyg
         G1oI2ugWMlki7LYDZ2Kvf5UOwYmt9I4I3tE+oqBNcWV5g/5DTwBXK2seFXLb3B5+kEqq
         /cCAocPfa0eqZ3R7e7IkE85qZkwOIKYVVRSU7i4gK1MpDdQlttlhoHmm2nI8oAKQ46qJ
         eH4nstT147+up5IkVif4F6fnwM/aU4TZsMeEUp1pB2aBAedNgsXXG++pTwNnNX25ydj2
         7eQA==
X-Gm-Message-State: AOJu0YwtHZc+6eVyOmvmr5xy+O11dcbfSsHhkAtlmyHvQxRRfkyoIIuo
        1u4r68WvYfhd072n34PGLr0p9lQwj7c=
X-Google-Smtp-Source: AGHT+IFGuMO2iRXc3kKkIH4NouUtrD2bMupUylVGU49adFtAcii/4JDmR4Txsx/iwOp/zrpaT8SDpw==
X-Received: by 2002:a05:6102:3a6e:b0:452:84fd:4a0a with SMTP id bf14-20020a0561023a6e00b0045284fd4a0amr812905vsb.17.1695419668982;
        Fri, 22 Sep 2023 14:54:28 -0700 (PDT)
Received: from [172.17.0.2] ([20.51.128.141])
        by smtp.gmail.com with ESMTPSA id bs24-20020ac86f18000000b0041072408126sm1786137qtb.5.2023.09.22.14.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 14:54:28 -0700 (PDT)
Message-ID: <650e0d14.c80a0220.97078.7598@mx.google.com>
Date:   Fri, 22 Sep 2023 14:54:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0819114637224901333=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2,1/6] media-api: Update to reflect the last code changes
In-Reply-To: <20230922192335.1060601-1-luiz.dentz@gmail.com>
References: <20230922192335.1060601-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0819114637224901333==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=786884

---Test result---

Test Summary:
CheckPatch                    PASS      4.24 seconds
GitLint                       FAIL      2.39 seconds
BuildEll                      PASS      28.66 seconds
BluezMake                     PASS      1020.76 seconds
MakeCheck                     PASS      12.07 seconds
MakeDistcheck                 PASS      163.66 seconds
CheckValgrind                 PASS      265.29 seconds
CheckSmatch                   PASS      358.10 seconds
bluezmakeextell               PASS      109.72 seconds
IncrementalBuild              PASS      5193.51 seconds
ScanBuild                     PASS      1080.16 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2,3/6] client: Make transport.show to print QoS property

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
10: B3 Line contains hard tab characters (\t): "	UUID: 00002bcb-0000-1000-8000-00805f9b34fb"
11: B3 Line contains hard tab characters (\t): "	Codec: 0x06 (6)"
12: B3 Line contains hard tab characters (\t): "	Configuration:"
14: B3 Line contains hard tab characters (\t): "	Device: /org/bluez/hci0/dev_00_AA_01_01_00_03"
15: B3 Line contains hard tab characters (\t): "	State: idle"
16: B3 Line contains hard tab characters (\t): "	Endpoint: /org/bluez/hci0/dev_00_AA_01_01_00_03/pac_sink0"
17: B3 Line contains hard tab characters (\t): "	QoS Key: CIG"
18: B3 Line contains hard tab characters (\t): "	QoS Value: 0x00 (0)"
19: B3 Line contains hard tab characters (\t): "	QoS Key: CIS"
20: B3 Line contains hard tab characters (\t): "	QoS Value: 0x00 (0)"
21: B3 Line contains hard tab characters (\t): "	QoS Key: Framing"
22: B3 Line contains hard tab characters (\t): "	QoS Value: 0x00 (0)"
23: B3 Line contains hard tab characters (\t): "	QoS Key: PresentationDelay"
24: B3 Line contains hard tab characters (\t): "	QoS Value: 0x00009c40 (40000)"
25: B3 Line contains hard tab characters (\t): "	QoS Key: Interval"
26: B3 Line contains hard tab characters (\t): "	QoS Value: 0x00002710 (10000)"
27: B3 Line contains hard tab characters (\t): "	QoS Key: Latency"
28: B3 Line contains hard tab characters (\t): "	QoS Value: 0x000a (10)"
29: B3 Line contains hard tab characters (\t): "	QoS Key: SDU"
30: B3 Line contains hard tab characters (\t): "	QoS Value: 0x0028 (40)"
31: B3 Line contains hard tab characters (\t): "	QoS Key: PHY"
32: B3 Line contains hard tab characters (\t): "	QoS Value: 0x02 (2)"
33: B3 Line contains hard tab characters (\t): "	QoS Key: Retransmissions"
34: B3 Line contains hard tab characters (\t): "	QoS Value: 0x02 (2)"
35: B3 Line contains hard tab characters (\t): "	Location: 0x00000003 (3)"
36: B3 Line contains hard tab characters (\t): "	Links: /org/bluez/hci0/dev_00_AA_01_01_00_03/pac_source0/fd0"


---
Regards,
Linux Bluetooth


--===============0819114637224901333==--
