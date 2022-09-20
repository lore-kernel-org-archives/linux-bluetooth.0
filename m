Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C097C54EE9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Sep 2022 03:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiITDnu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Sep 2022 23:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiITDnt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Sep 2022 23:43:49 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2233440E28
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Sep 2022 20:43:49 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1225219ee46so2457475fac.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Sep 2022 20:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=RHd375WMntIbKPlcWVB1fCNAZUQhCHHlMrP6RTIChyw=;
        b=COYHbBCFSU8Yr7c0XDV3yByRwDHOdScQ+bn2DN8NYVn3Ffn9TkqpErWKrLYrrJFDi3
         nlpX+eB4BGZl6Yw/kKsl8BcNSl8qzzI8wZbAiV1pjWzPZ8XbUzPlXtbbK7S1INflKyaT
         o6lzowKCt8kehwf32HY08xYO5qvQwQF6UfJRYObFBOElKa62I0OIj+84jxodsmco2Ffp
         jrJHZUG82G9zznUM5HZOjIXCzQjaE8eTohlPVcXB0S0Ou9ITxJ2CWrOSQ2idiUmY3Suz
         X65lC7uXcTmwJFtdByXqyD7W7/0TE1D95njdkmZN9/7vkuImlk2qBJCaGXZODVKTX5AK
         4pgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=RHd375WMntIbKPlcWVB1fCNAZUQhCHHlMrP6RTIChyw=;
        b=JIDwRQ35lETYsjGPtPTVNKjHvXUH+VecksaNXQx+a7M92Q79X0grvjyei/hZj8N8bO
         pvS44nmujPbilKKmW8j+zL+09VYyawL67XzYCAFPe4sNzFzApbXeD82DBM9uaNv3RSeQ
         x/+dHzDhiTyTm+VAFmNHtHENTQhec0sGdEYeizpqJVvtWD/iOIhBRPuMEfA2Cjzcln4V
         ox8/Jlq4nD0FOPrx/ywr0711J5N+bLIb3fYUNAK5GU6jkcCP0FT4nN/v+7JzadtPmbs9
         NVyD6pS3f3g3LEC8ClAl3BzhIIzRIJ6l+PbrpxGGGC7Mb7lFKRZhlWBPSP1xt+eHWZfM
         BDZQ==
X-Gm-Message-State: ACrzQf2OcyV+N77QuNAovv/h+M2zQvzhMC4gKBHrGVIrd0zMVoXG8HPb
        9H+0fOizpX/HY4G3f+VqOBOaIozIJoPBzw==
X-Google-Smtp-Source: AMsMyM6wbqDb8yqaFR42wEUhctgi2Ytb9mqxCudWl3bv7F/sXy8GcyiEUtVe21FcXapYMg5TEaWBRg==
X-Received: by 2002:a05:6870:33a9:b0:118:8dc6:300b with SMTP id w41-20020a05687033a900b001188dc6300bmr886137oae.60.1663645427877;
        Mon, 19 Sep 2022 20:43:47 -0700 (PDT)
Received: from [172.17.0.2] ([20.165.40.240])
        by smtp.gmail.com with ESMTPSA id n26-20020a4ac71a000000b00476091effd9sm152465ooq.24.2022.09.19.20.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 20:43:47 -0700 (PDT)
Message-ID: <632936f3.4a0a0220.8c56b.05f5@mx.google.com>
Date:   Mon, 19 Sep 2022 20:43:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6958263596769629946=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hanyihao@vivo.com
Subject: RE: Bluetooth: MGMT: fix zalloc-simple.cocci warnings
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220920031958.3092-1-hanyihao@vivo.com>
References: <20220920031958.3092-1-hanyihao@vivo.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6958263596769629946==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=678455

---Test result---

Test Summary:
CheckPatch                    PASS      1.86 seconds
GitLint                       PASS      0.81 seconds
SubjectPrefix                 PASS      0.61 seconds
BuildKernel                   PASS      46.58 seconds
BuildKernel32                 PASS      40.20 seconds
Incremental Build with patchesPASS      60.07 seconds
TestRunner: Setup             PASS      675.12 seconds
TestRunner: l2cap-tester      PASS      20.67 seconds
TestRunner: iso-tester        PASS      21.07 seconds
TestRunner: bnep-tester       PASS      8.17 seconds
TestRunner: mgmt-tester       PASS      130.62 seconds
TestRunner: rfcomm-tester     PASS      12.84 seconds
TestRunner: sco-tester        PASS      11.81 seconds
TestRunner: smp-tester        PASS      11.98 seconds
TestRunner: userchan-tester   PASS      8.70 seconds



---
Regards,
Linux Bluetooth


--===============6958263596769629946==--
