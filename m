Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD836C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Mar 2022 19:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbiCYT4K (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbiCYTz4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 25 Mar 2022 15:55:56 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8035B28F82D
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Mar 2022 12:42:40 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id k125so6815287qkf.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Mar 2022 12:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:subject:reply-to:from:to:in-reply-to
         :references;
        bh=7DpNqfs0CtbGspBcUmcnhdoilH6I0tNPHExg+X8jClA=;
        b=qr9RDQmo7jmbZhqt7ABEuHp9xlQwP1dA7PtCVx9GnHjnfn+Z8P0D3qR9q/7p3kuVNq
         rf/mp5kMBpEuSra7TG3s6edAC0mbF6haL3lY273ouTal1XKZYnD5srOZWHioCJCQTpmD
         CdqSJ3qxitBWVcXyAWzAUtapSAM2B1BIRd9OrXSRIcrlrkrKTALkYQukniSj3zcQvCPO
         HCWBkoQCGpTYzA0JW9I+pIokeif3aXBYJ0kwrF2bI6eiJQjiDR9CnU4dLwKCoq32vQVI
         7dD7gAwoGveLvssPqrVB1waWSjz3BoxEbP5bTwW900Pkir/dv2ef2yPt9bk/CNtMLbN6
         bJ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:subject:reply-to
         :from:to:in-reply-to:references;
        bh=7DpNqfs0CtbGspBcUmcnhdoilH6I0tNPHExg+X8jClA=;
        b=4w4aX+LMEX3G2w6JvyGSdebsPGGEWENvR9QK630+RwKG5UVR5oG+5GF4sl9xsWhLZz
         nTP0FPPSMQTpawu4no8I9RT9fjwCPsXbfHS/bkOV6j2r/Tp+aW9voDkvizRl2FHg9bDh
         ah0f3WBVeAdDVjXYrhPMnaK0rkNyfl4o7IcvAdpFYAPzaCJAIF4+0zytzltkNcsX6xVs
         QnKKM2IGShi0ntqjEf4BfP7BIIB2xrb5tbPbavA3pBdQq0n9XzmJ7Sxhe47yIKgdsOKH
         xmXf5nXvnTqi68mBt0E2ApWF2bfMrkaF3+xI24JmgwcBmlw36L9bEcepagSeXHjNnvLQ
         SrLA==
X-Gm-Message-State: AOAM532RWHXUqWwD1zLRdJqRfYlGH5QSfTBeV37APNOjjXWOoCsOwMit
        AQ35bdS66B4UXOBwZnb8w0p7Rsg/hSM=
X-Google-Smtp-Source: ABdhPJxCaGAUzWHwcjPxZwNHl6Edllk76KJvplZkyjunlmEUit4HAichHZPxzqQm6lvK19QaCntIqA==
X-Received: by 2002:a05:620a:2804:b0:67d:1e7b:b528 with SMTP id f4-20020a05620a280400b0067d1e7bb528mr8252968qkp.193.1648237341149;
        Fri, 25 Mar 2022 12:42:21 -0700 (PDT)
Received: from [172.17.0.2] ([20.98.224.64])
        by smtp.gmail.com with ESMTPSA id y11-20020ac85f4b000000b002e1e038a8fdsm5642484qta.13.2022.03.25.12.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 12:42:20 -0700 (PDT)
Message-ID: <623e1b1c.1c69fb81.3c792.0ff0@mx.google.com>
Date:   Fri, 25 Mar 2022 12:42:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1408826374799449125=="
MIME-Version: 1.0
Subject: RE: [BlueZ] mgmt: Remove mgmt_set_verbose
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
In-Reply-To: <20220325181617.332701-1-luiz.dentz@gmail.com>
References: <20220325181617.332701-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1408826374799449125==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: patch failed: src/shared/mgmt.c:50
error: src/shared/mgmt.c: patch does not apply
error: patch failed: src/shared/mgmt.h:28
error: src/shared/mgmt.h: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============1408826374799449125==--
