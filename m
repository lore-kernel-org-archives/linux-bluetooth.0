Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6ADEC001B0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Jul 2023 14:04:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbjGXOEr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Jul 2023 10:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbjGXOEq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Jul 2023 10:04:46 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62AF1E53
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jul 2023 07:04:45 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1b05d63080cso3453295fac.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jul 2023 07:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690207484; x=1690812284;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qJX4lpwyET0yhYfZ0qapPYlt2YgtmyO8vDHEtQq4ELA=;
        b=dusb6IfAI0cfyzenFPH6ryjXN1u5IrbdyLd9wvcUwYRUdqRgvPY/kf+eih7FpcDxk1
         EkoUOG0l6gU/maj9EwTXAJJhF2RZzmovaAMpRZA7nuPn4MZ0URgn+Hf435zy3wmmiNEx
         k/PAk8dRqSN50s8OVpO1R2VVYyqrIT+BYmwAIsyJCK31pxFAEoKZ1j3s6FXDNXZTCr/w
         v3FoKENJGlCkw+HLPotKDPjNfxsg+7xHo9LfTWZYReIm+yr3pxoBYetWjNLHdyo0Rydi
         TdE+BOWACkAjkNMhlFmuAg5CWmHEs/6zjPv3N+QxNDtgBZxuDns8GzIrJES3EzT+mfXu
         I3FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690207484; x=1690812284;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qJX4lpwyET0yhYfZ0qapPYlt2YgtmyO8vDHEtQq4ELA=;
        b=hsMB4QI0os5M3GcwTQTyASvrKt7x6QiWemaw5r5JzsQQ1gN8M4Oo52ha1lQYag0CZU
         pZyMhETkF/MopgTWye69OKp8sdkMwgJ21W8p6J57saR5j1z9yZ7M/7QP/jR6LjZBiLn6
         6KM5a/4+SdIvoHbl/ycIqXQRf/SvRIXGzhKuRCWiLDQZ6r1aWMYCT4CGM77+20xGfzT5
         XbP7KYgq2Q64c8nBM7OIha4BDCVJYYRldv+09FwZaIMn1abYoZ/wufdNTe2n/nCeuT5o
         HkLqx4udfZD29WiuoPbWlKrg63Azol1wNsKRJAQZfyehEyvPL883neuA2fIjiYBMIUcK
         2+jQ==
X-Gm-Message-State: ABy/qLbGOxOyvpY0mD1CQjh4yoTg9GlHc1v0eELnJWEB282rPjKs8crR
        I/EWAigGo81oz1G1+sbH86VoEMcSPTE=
X-Google-Smtp-Source: APBJJlGtjL0iTVBY+LNLKCwqyDMhtN7gNRooUho/VYf06eC3wxWgfH0JUN6Hf3WJNm9OJT05Ute5iQ==
X-Received: by 2002:a05:6870:4708:b0:1b0:4253:64de with SMTP id b8-20020a056870470800b001b0425364demr11456450oaq.11.1690207484525;
        Mon, 24 Jul 2023 07:04:44 -0700 (PDT)
Received: from [172.17.0.2] ([65.52.35.16])
        by smtp.gmail.com with ESMTPSA id dw18-20020a056870771200b001b05c4b3b3dsm4321856oab.31.2023.07.24.07.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 07:04:44 -0700 (PDT)
Message-ID: <64be84fc.050a0220.f9f1.677c@mx.google.com>
Date:   Mon, 24 Jul 2023 07:04:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2609287481952760991=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, nitin.jadhav@nxp.com
Subject: RE: Fixed the crash observed with VOCS
In-Reply-To: <20230724122908.42409-2-nitin.jadhav@nxp.com>
References: <20230724122908.42409-2-nitin.jadhav@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2609287481952760991==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=768882

---Test result---

Test Summary:
CheckPatch                    PASS      0.51 seconds
GitLint                       PASS      0.32 seconds
BuildEll                      PASS      33.95 seconds
BluezMake                     PASS      977.84 seconds
MakeCheck                     PASS      13.43 seconds
MakeDistcheck                 PASS      196.12 seconds
CheckValgrind                 PASS      317.14 seconds
CheckSmatch                   PASS      418.65 seconds
bluezmakeextell               PASS      129.27 seconds
IncrementalBuild              PASS      811.74 seconds
ScanBuild                     PASS      1304.39 seconds



---
Regards,
Linux Bluetooth


--===============2609287481952760991==--
