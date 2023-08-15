Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE40C001B0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Aug 2023 23:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240628AbjHOXjM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Aug 2023 19:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240752AbjHOXjJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Aug 2023 19:39:09 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C162AB
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Aug 2023 16:38:35 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-56cd753b31cso3271469eaf.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Aug 2023 16:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692142713; x=1692747513;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aRhJAQAsa3x9IZhHWk0HFDHre5uLZJH0jZ/LQTWvnyE=;
        b=inbCH0r1qlmPDvkIFNlMOSWQ3yl+jVXhW1x6hafNwjozW2fbJT45bBOhDgXRRS45td
         ti6S1+adPhsn42rc8y3WdqqpXuX0Tf4oqN94lbTkjlQ3zpSMB0vd7B2UZVcehjpHPhvD
         b1P0S1m9gpEpipWuLzoNk2gDb1FhFkN0sWfuq4AevbMqIqzOw9fk+qszWZ9LuD69KczH
         XUyHu28NrWdS6D1ysNqq3npjVA+1qL757MeC7qeXbdR2OACM7NjmEolLG1PaVZDmTyU3
         cIT8xEldaVNrU9vFss46vJ2GrBEeTUiEchLEGG1xtTDaRlBYIJRz88iQS6OGKqy1GOsC
         eATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692142713; x=1692747513;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aRhJAQAsa3x9IZhHWk0HFDHre5uLZJH0jZ/LQTWvnyE=;
        b=Vlyxplj7bmkgrJjkFfS7xNQM7PinDAKspuI+FVCNeXhEGw3vc4WndzzZrTq5V2dv7z
         AHxcR194bW4cr03m29iG5KOagd4uLYGB0a2eiZ0Ny+Jvo3PXfsp7NYLKIxqQgIunJPlD
         RkGjz+ErPgPRnrj8Y2vOHn/jqJfWkuxCJj6sTy1zuMt/tjU4YK+5MopHSv1Q9twqp12R
         E7e0EvM3RIiNEfY+BDFrxYRSbfbcGgQ/t0gea2jsVtoge7NLT3fLvao3JfmSGMUg5Ul9
         +eYl5oZW7CxnFPgdukPTrDZegz9C6X/3jUXvgyE/px65XNbyu5HX8d8SPtbM34kiznc+
         Zc/g==
X-Gm-Message-State: AOJu0YwhQlMj/GVQKKydAX4GMYEoC3lgZ4Vgr3nbo6lHtTsa1aocDNhh
        AXeCZDjinEjCWKKP4Q/D6JoUkEyJij8=
X-Google-Smtp-Source: AGHT+IE2eoKI/dzthEoKep0QLo0MUeCQ0nC294XM633P84q/XdtdjFgnqYHnfd5OS0ijAmybUGlA4Q==
X-Received: by 2002:a4a:3859:0:b0:56c:dce3:ce89 with SMTP id o25-20020a4a3859000000b0056cdce3ce89mr334732oof.5.1692142713348;
        Tue, 15 Aug 2023 16:38:33 -0700 (PDT)
Received: from [172.17.0.2] ([104.210.140.31])
        by smtp.gmail.com with ESMTPSA id f125-20020a4a5883000000b0055ab0abaf31sm6192641oob.19.2023.08.15.16.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 16:38:33 -0700 (PDT)
Message-ID: <64dc0c79.4a0a0220.29c73.301c@mx.google.com>
Date:   Tue, 15 Aug 2023 16:38:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7506505740461027969=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] iso-tester: Add suspend tests
In-Reply-To: <20230815221738.2491772-1-luiz.dentz@gmail.com>
References: <20230815221738.2491772-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7506505740461027969==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=776431

---Test result---

Test Summary:
CheckPatch                    PASS      0.52 seconds
GitLint                       PASS      0.29 seconds
BuildEll                      PASS      26.58 seconds
BluezMake                     PASS      1001.36 seconds
MakeCheck                     PASS      11.78 seconds
MakeDistcheck                 FAIL      9.10 seconds
CheckValgrind                 PASS      247.58 seconds
CheckSmatch                   PASS      344.92 seconds
bluezmakeextell               PASS      101.99 seconds
IncrementalBuild              PASS      859.38 seconds
ScanBuild                     PASS      1079.54 seconds

Details
##############################
Test: MakeDistcheck - FAIL
Desc: Run Bluez Make Distcheck
Output:

make[2]: *** No rule to make target 'doc/test-runner.txt', needed by 'distdir-am'.  Stop.
make[1]: *** [Makefile:11708: distdir] Error 2
make: *** [Makefile:11784: dist] Error 2


---
Regards,
Linux Bluetooth


--===============7506505740461027969==--
