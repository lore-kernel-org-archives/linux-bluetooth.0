Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C202C7EE32
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Mar 2023 14:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjCAOOS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Mar 2023 09:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjCAOOL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Mar 2023 09:14:11 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16E3410AA
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Mar 2023 06:14:07 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id y10so9619211qtj.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Mar 2023 06:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677680046;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BQCPTWp+IAglP7VNGWpTI4h2YbhwW5QQ8IZWLpNvIuQ=;
        b=CghaAY3oQ7GuOFwCjhUXsPZVmcNaxD0oYE/QXnghxVzGTu73k7G0P/JkUlnxOo19SQ
         gNUi0uVVrEgnqmufafR0OKlFIj32QOkUKbkuo2ElHadDDeqyPjYAOevNFZD/FiT1Yp7B
         Sw+QNDOMfZJdhSFf8QBrR42BwP0GyZQEgRRFyr/nHtnrghlcGZMoadk8ISNlifoXI0x/
         GyZh84LbN2dI5G21xj/EVtyNXL+ak3leVpHnKW8a9FP3b1GhNyaiSsKdgYnRqBpVRZ+7
         EQv4mGahxk164Hnsf4p4F4wd5VX4JQPsA55XhKoanCYdtTJ2f7mvySpnnXj/7D2f0RK3
         8t/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677680046;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BQCPTWp+IAglP7VNGWpTI4h2YbhwW5QQ8IZWLpNvIuQ=;
        b=kFXndG8LZWDoJEAZzdtkQtwiFUT/WV70c/AUjZOtsHVTJ95uha34t/OQ0056bcbWpf
         NOzg11nW0zHlrqhoxWXsIsYZyRf1mXcdjXxvwMyGbHVh/I2rzTBwl0FkzydblbF4FPc9
         6W0pxENkLgO2RMpJRoO+q75l8ApvgHVF+1mb0niHZd9/IX36dbsp8WmLQV7fsfdVmMQd
         cOVHN0Alzl5NjWlmLKSTrF+j5FdI8eELwGszj3Z3tp54Y0stPCTkMhXZyKyu2dGEbzHw
         MhPrIq4SfNovifTpPM9oof5KexdiAwnEzhF7LvNT0c/XS+I7CINLYm1OWWKfhDZLfoUn
         odKg==
X-Gm-Message-State: AO0yUKXcAiEM6Zo5yTZBDYj3DU1uDrnz6mk1dKvv0VoBxSDAc7lzE10l
        52nxQ7B+zTbjJJPBPPw0WQTX4vT1J2Y=
X-Google-Smtp-Source: AK7set+HjEiBHlIZqkOS/Gl/IGlMvdJ0TsFWDuez+5FYMT+yGdccEVylVYXTZt15mTCiK3h68vRIDA==
X-Received: by 2002:a05:622a:1a95:b0:3bf:b614:bcba with SMTP id s21-20020a05622a1a9500b003bfb614bcbamr10950681qtc.42.1677680046487;
        Wed, 01 Mar 2023 06:14:06 -0800 (PST)
Received: from [172.17.0.2] ([172.176.217.66])
        by smtp.gmail.com with ESMTPSA id j26-20020ac8441a000000b003bfc355c3a6sm8275206qtn.80.2023.03.01.06.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 06:14:06 -0800 (PST)
Message-ID: <63ff5dae.c80a0220.41f39.c562@mx.google.com>
Date:   Wed, 01 Mar 2023 06:14:06 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4855754411113395185=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: Add initial BASS support
In-Reply-To: <20230301134207.10924-2-iulia.tanasescu@nxp.com>
References: <20230301134207.10924-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4855754411113395185==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: src/shared/bap.c:108
error: src/shared/bap.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============4855754411113395185==--
