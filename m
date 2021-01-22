Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8697BC433DB
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Jan 2021 01:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 331EF239EE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Jan 2021 01:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbhAVB6t (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Jan 2021 20:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbhAVB6s (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Jan 2021 20:58:48 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADD3C06174A
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Jan 2021 17:58:08 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id l14so1988839qvh.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Jan 2021 17:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=QxHTpCzjVyT1iSkHDnZVDWSaYQGvbA8qlbg83/CE9c4=;
        b=hvnDlQE4Yiky/dqtWVc+lLAEbBSK6CbizMIRk/mObI4n1Frq3WAGhCCUnLh5VCGVNK
         scN2SOGuOiNP3BofBpYv6X0NHKc094hucFjOJ/Wd03s9y5DNp7HB6rziU3CPIEo7mJ7U
         mPrfcjBicGaGWcECXBmVhp6cCNyaEx0LYohPHAdOBVzm8HPFMUjvIwet1y286x6j36xW
         FZvdEiUUBJoJBbOvxkPvzgwhV8RCedugviExcqaO0hG50xJs5Hex6H/Ir5HOUZCuLhdW
         7zWuCgKeK0QPot3bN2Cv1lnThh24oM7uywYPB9jzQ7n2sVuObOPNnPXd1neoF5NFmlZo
         wOgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=QxHTpCzjVyT1iSkHDnZVDWSaYQGvbA8qlbg83/CE9c4=;
        b=dw9oZAxkUD4IqbSrOfH43vlzT9w8yT3/J1Da/V+DPo0Z4G2pSejznimTnGTYniHiYu
         i4B6Vpyy+JM0FhAD/dCWOhapV/evIaGOtmVGl8FFHfB4V8LakzdRGMZJBT2Bw7ZIqp5p
         MeXyK16NQYg1nCwuVi1743cZtPqQJPVqn8Vl4cCAltYI8GTEmkVnYTyDlAv0vJoj+15S
         YfPiMK1FuHIBmulD6dnxl11vOrx8g6YFR3Z0lje6P/zmqWr7gEKAhRT3UD7K8bjfvfLp
         YsAzhU6usa1S+g8HlIcfAldh81pY//g9veVaXAaAcvLEC+72Jrxg+ZgvwqwVTdLDiaEQ
         hmug==
X-Gm-Message-State: AOAM531DNvs47uM05iPeL+1w9Yhsb0HJ3rROfXRcaq8O9pYqxkaO2K+a
        lNnJX1Pe/VFG+dIllGdPZipRRADtG8w=
X-Google-Smtp-Source: ABdhPJzRJJKDxOKtnUz1B22iAgvhetOaUz9DjVwVLmrQ7VoFfci2WMZqFJ+8++mpCH8Afno5b/RvSQ==
X-Received: by 2002:a0c:ac43:: with SMTP id m3mr2313679qvb.37.1611280687476;
        Thu, 21 Jan 2021 17:58:07 -0800 (PST)
Received: from [172.17.0.2] ([52.251.91.58])
        by smtp.gmail.com with ESMTPSA id j188sm1119722qke.67.2021.01.21.17.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 17:58:06 -0800 (PST)
Message-ID: <600a312e.1c69fb81.17e4f.687d@mx.google.com>
Date:   Thu, 21 Jan 2021 17:58:06 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6051377308529981109=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sonnysasaka@chromium.org
Subject: RE: [BlueZ,v2,1/2] input/hog: Fix double registering report value callbacks
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210122001326.14263-1-sonnysasaka@chromium.org>
References: <20210122001326.14263-1-sonnysasaka@chromium.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6051377308529981109==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=419555

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============6051377308529981109==--
