Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4BAC4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon,  5 Dec 2022 18:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbiLESjJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 5 Dec 2022 13:39:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233000AbiLESit (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 5 Dec 2022 13:38:49 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE99A22294
        for <linux-bluetooth@vger.kernel.org>; Mon,  5 Dec 2022 10:32:02 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id mn15so8773751qvb.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Dec 2022 10:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cgn3yFOnzu+MZcEDLcX08TJiBFQQbM5uZLF6jxVVF5M=;
        b=gRGUqCoxmLNia3zFgl/WLjjTQH8QRBcGLxrmY5k9WOWKQhlBTVMrmrkBk03gB8kc6w
         M0tF2bujHwOQ2rD4+p1Pdx6CP0HJEb+a0GHSBjhJWxcPgk5WzhfBc5TYvphelQMT/ijv
         6BMnNekP/+gj9zMnofPO6027zvHbqaanbcPNrdqIubkfwAOhh1OQwDXaPOlDyyjitmRy
         QsDYoF2QYaBIKTd8hqUoL9xLMYZWaONwnGA2Ga62gQvS0LD+7C5kKSZRdlTCml5GFud6
         2X8pZSviBA4xbdGAMEMbqBRn9MNMSzb1wpCD0EAigM45zfzJ2czKIdpIy2XMIO4tHC74
         5L8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cgn3yFOnzu+MZcEDLcX08TJiBFQQbM5uZLF6jxVVF5M=;
        b=jHCU5RMoU3YbzF6SxbfU8fnFen4cf6J2hV4k8oekCsSAcE5G0hGtgGgiuD8zpB/Vpr
         sHuCqn5K3AQu8qvK3V+zoTiyWnjs/uGOGGiNayUk9DAf+tFNt1WlJ2Au7hrocwLUQjU5
         ltKyyeiOUAbI7swBDCGc1yJ+yahqxH/AZZF4Q6CYrL8j8rqe+4mA2eUW4z6Z1T2NCBgx
         qqdaW4fwKC7GEje5XyAoXDJg8va07iCj+cFDO14QYk5uqUK6l0TzIBI3wG422ZN38pyV
         Gvy7LMjlXvvDJ4ByrwsS3PPUe7pefG80/lzwFBn+1uC1Yzx1/D2I0z/wN0p5I+M1K9mK
         iqHg==
X-Gm-Message-State: ANoB5plZ2Jip8Hnl+XQvTDdzJfN/II/xoEgNOTlkQlUDNo2W49ZFtgBb
        8/Wa+G5rwXlujAGpe+vO2FZHuhNHRcg=
X-Google-Smtp-Source: AA0mqf43tQoQhSyrRMvEk733VwFBCSRzrs0vt/zD0LGzm4AVaqy2kgch8isLwjy0SZzFOyFp5+FTug==
X-Received: by 2002:a0c:ea88:0:b0:4c7:87f:f11b with SMTP id d8-20020a0cea88000000b004c7087ff11bmr30033420qvp.115.1670265121776;
        Mon, 05 Dec 2022 10:32:01 -0800 (PST)
Received: from [172.17.0.2] ([20.114.138.110])
        by smtp.gmail.com with ESMTPSA id t27-20020a05622a181b00b0039cc0fbdb61sm10380049qtc.53.2022.12.05.10.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 10:32:01 -0800 (PST)
Message-ID: <638e3921.050a0220.9514c.dc05@mx.google.com>
Date:   Mon, 05 Dec 2022 10:32:01 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============9161369711916655584=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: btusb: Fix new sparce warnings
In-Reply-To: <20221205175016.3340062-1-luiz.dentz@gmail.com>
References: <20221205175016.3340062-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============9161369711916655584==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=701905

---Test result---

Test Summary:
CheckPatch                    PASS      0.69 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      33.98 seconds
BuildKernel32                 PASS      30.57 seconds
TestRunnerSetup               PASS      425.75 seconds
TestRunner_l2cap-tester       PASS      15.69 seconds
TestRunner_iso-tester         PASS      15.36 seconds
TestRunner_bnep-tester        PASS      5.36 seconds
TestRunner_mgmt-tester        PASS      104.02 seconds
TestRunner_rfcomm-tester      PASS      9.19 seconds
TestRunner_sco-tester         PASS      8.69 seconds
TestRunner_ioctl-tester       PASS      9.90 seconds
TestRunner_mesh-tester        PASS      6.75 seconds
TestRunner_smp-tester         PASS      8.48 seconds
TestRunner_userchan-tester    PASS      5.59 seconds
IncrementalBuild              PASS      31.46 seconds



---
Regards,
Linux Bluetooth


--===============9161369711916655584==--
