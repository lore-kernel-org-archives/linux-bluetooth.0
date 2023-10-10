Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2198CCD8CAB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Oct 2023 16:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233192AbjJJQfp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Oct 2023 12:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233440AbjJJQfn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Oct 2023 12:35:43 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5E08E
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Oct 2023 09:35:42 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6c7c2c428c1so9897a34.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Oct 2023 09:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696955741; x=1697560541; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=g7TF+Itv4iJHtFYlMKUT/gIpHyMafUL3UPKB4reStiE=;
        b=XX3JIJfZoyuLt7YHvzkQ1KNjFiXzXOkEgbJqbSoGi5De5k2UqWFN7JjUdLQ3XuKVCE
         7lh5db5MXq1YofcAr5j5g4/OTe5lCa1ZVUo78qvbYxvhkWCXTy8h707acJl5pinQ4KCX
         EwJd6eE1Lwox4UnHrxIPqUZSXt8NrZSpgpYUna8XN0h13QARG2gTqCrxG1LtkSJCP5eq
         P0C0DzLNtm8C6/EIsHdQpoqZTwJOjUwq8yOYT8s9gXQwNTLsgKeQxxs4LgLjXIqyAcOj
         B3/jS0A/8CnZZimbzeL60ksb5wb+F4Ec1/Zx70w0P8COtH5ZOX2uVK9RW78sv7Hkhnn7
         oEMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696955741; x=1697560541;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g7TF+Itv4iJHtFYlMKUT/gIpHyMafUL3UPKB4reStiE=;
        b=dklDfvVl6w4f7sV4Llxsu4GrxhG/ZZAChqq9F/M6vvsWPT+6pMqUp+M1+15fdfH+DU
         6L10mxeS4Irye0bhJpqamg5lGIcfgmDWdxbLc9U0uVXTN0lq66Ox4wqbWm9YMdMyudIc
         ykHIT6Uri/aXmPi/d4YEoTEsppvnsMSXFxWESWv7pfn2o/sSc3ldz7QsjNM0ozItxH2e
         wU1CfL1dBIAVtxk3zCfdDNXRp4ZESQJWlS/IZsMt+Ena2BCFv0btQICdEg07wZoSeHKr
         NXx44maUtrD+UbDhAWQIM89knuAsXXCsGbkuN7SEPaLHzdOwl8CvusborWaRNRRR7E/l
         J5Ow==
X-Gm-Message-State: AOJu0Yxr9mq6vOZZOatiSrut75clXDAPH369xdGrCdJFLO3lUh4zWoNj
        aXQOGNcVmHGb6EpBnfUTQWu6TO1zQ5Q=
X-Google-Smtp-Source: AGHT+IGTtxXuZGXX8Qz8Wv4pj82HQT1FcvGs+ju6zXqWtjbxRaEG7VXD7aaz/JvdPBLrFwkqsHEYmA==
X-Received: by 2002:a05:6830:2b12:b0:6bd:62c1:65c with SMTP id l18-20020a0568302b1200b006bd62c1065cmr8483180otv.18.1696955741323;
        Tue, 10 Oct 2023 09:35:41 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.170.8])
        by smtp.gmail.com with ESMTPSA id h18-20020a9d6a52000000b006b9a98b9659sm1874950otn.19.2023.10.10.09.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 09:35:41 -0700 (PDT)
Message-ID: <65257d5d.9d0a0220.20eed.b670@mx.google.com>
Date:   Tue, 10 Oct 2023 09:35:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3600782108254490075=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, silviu.barbulescu@nxp.com
Subject: RE: Update transport acquire/release flow BAP bcast source
In-Reply-To: <20231010145243.4441-2-silviu.barbulescu@nxp.com>
References: <20231010145243.4441-2-silviu.barbulescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3600782108254490075==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=791844

---Test result---

Test Summary:
CheckPatch                    PASS      0.94 seconds
GitLint                       PASS      0.55 seconds
BuildEll                      PASS      29.34 seconds
BluezMake                     PASS      1032.60 seconds
MakeCheck                     PASS      12.40 seconds
MakeDistcheck                 PASS      164.78 seconds
CheckValgrind                 PASS      269.16 seconds
CheckSmatch                   PASS      361.45 seconds
bluezmakeextell               PASS      110.17 seconds
IncrementalBuild              PASS      1763.22 seconds
ScanBuild                     PASS      1091.40 seconds



---
Regards,
Linux Bluetooth


--===============3600782108254490075==--
