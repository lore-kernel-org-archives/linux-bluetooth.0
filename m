Return-Path: <SRS0=Aqt4=BY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BFAC433E1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Aug 2020 10:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8351F20781
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Aug 2020 10:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TmsULxZk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbgHNK0Y (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Aug 2020 06:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgHNK0Y (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Aug 2020 06:26:24 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73835C061383
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2020 03:26:24 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id b14so7876537qkn.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2020 03:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=5mWMT1GNug/0Oyb2iDfnCIU7HkUgJEDm49qTfvOMAYE=;
        b=TmsULxZkdxqS3p+/5VpEC801kKyEOa4biFDkNfBGz2yFGEIyROYZZYcLfsIN03wd/+
         xzW0sESEletlDy0nuEoTMPJ80YoWLtkllnsbMCgToFRPINfA0WTcdoiIgZphtMv2LaUc
         22aVC5Z9vDksL2zSoP0WeWvdzDV5nHisdwI72TwFQHdmgOudEWDa/bk7DYsexER+5d4K
         JiAMogYAyryR0W/6YuPmP9uIyRlpaGLJ+OxZYK6JY9eDIxUPzW0sEVGoPtdYxoXbTCxq
         SlOP8bZBJ30DI4S7UbnIM5ij+cHIso2n6wjNtgI6XqH6sYIqY6e7PlDpKuXHF/mSGwMv
         Szqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=5mWMT1GNug/0Oyb2iDfnCIU7HkUgJEDm49qTfvOMAYE=;
        b=gzmIFFVOU/qQKKmlKt/33q7FnrZjuI90dF8cTTeSSPMlQ5n7y/ii8kaQNlI2ysrgOo
         wiLK3rVl0tJR9BdghXteIJJJYqk67pgVlzNZuRx35Yfb6IxCEbkjgMjDW0pjkyIqYF9k
         qWTB8MSzBP4ExvJIALrlk0Rl3rjyuZGADYj0WNKRLyoKxMF3eb5X06geq08an7e5SpqP
         +OmeXLbl9FiSBIYhT2h3Lb78ROuzVQrIeEwFHhp+KsDyw+ekXPyxdCrFAparrtFLYY9U
         C2h0N6VQxeRoS8Js2MECmNeDA4F07kMH6WqRoMi0A0xcuPdNJk7GqxItySVX+aqSBuPu
         NCKw==
X-Gm-Message-State: AOAM531+94/KerZPjUoOCLRoN1hLl/4CdSGA4EH20x1qwTBzi/SEJMqy
        HmkbNd5xRLYwfWp9I0tMfTMdQjeJHCOaKA==
X-Google-Smtp-Source: ABdhPJwG2pRCon3JYyxXjnzJz484nfFX/2pDTbwl9PmbXrGmGQyZZlrixYtH/daVg9FrM0gESE5E1A==
X-Received: by 2002:a05:620a:24e:: with SMTP id q14mr1345565qkn.482.1597400782923;
        Fri, 14 Aug 2020 03:26:22 -0700 (PDT)
Received: from [172.17.0.2] ([52.254.74.102])
        by smtp.gmail.com with ESMTPSA id a6sm8434144qka.5.2020.08.14.03.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 03:26:22 -0700 (PDT)
Message-ID: <5f3666ce.1c69fb81.4c7cb.1ba3@mx.google.com>
Date:   Fri, 14 Aug 2020 03:26:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3876638814309108230=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, 515672508@qq.com
Subject: RE: [BlueZ] adapt:Set property mode failed,memory leak This patch will fix a memory leak,when set property mode,it will send a msg, but if failed,the data'memory do not free
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200814095433.10654-1-515672508@qq.com>
References: <20200814095433.10654-1-515672508@qq.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3876638814309108230==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While we are preparing for reviewing the patches, we found the following
issue/warning.

Test Result:
checkgitlint Failed

Outputs:
1: T1 Title exceeds max length (161>72): "adapt:Set property mode failed,memory leak This patch will fix a memory leak,when set property mode,it will send a msg, but if failed,the data'memory do not free"
3: B6 Body message is missing



---
Regards,
Linux Bluetooth

--===============3876638814309108230==--
