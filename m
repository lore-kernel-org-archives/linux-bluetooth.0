Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75362C433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 04:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A8EE6510A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 04:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbhCPEnA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Mar 2021 00:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbhCPEm5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Mar 2021 00:42:57 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F85DC06174A
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Mar 2021 21:42:57 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id x7-20020a17090a2b07b02900c0ea793940so712833pjc.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Mar 2021 21:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=RPoQCR6e9VXWucBSA8RoJyoNSUy/UdqLoHDhFjUzvMk=;
        b=Z+/pQaKfscQgwixQvbeKEByoN3nKyE3kgql5KW+hzRessX3ERqRhaB8XU3615RwfmN
         LrYwOeYo8R9QkxdbVfGBlRAnSA6RCZJapmAX7k8xT2l9ZZPqkw3ARb5ZLVspE0jRSCmM
         okSQmq9zG6AjGkNIlmGYzRZnnAHKOpg2Sv3GSomRi/MlVaU0aLCvxXN54Wq9Z4lXSkZy
         DLGhOUDANv0F77F2w3WV/tmktWoud8w1MNuorokSB9hhri01VQjONpEc8Hc+N8CVaNIJ
         XV5FZepTBIpbHK0rsAOiM48AbRfuyCWUu9Lz/j2OY8qkXdBkEk03Xgucg0XBhEnLZlwI
         ypUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=RPoQCR6e9VXWucBSA8RoJyoNSUy/UdqLoHDhFjUzvMk=;
        b=ug4REzq/F712xBJIAJ0BG1zB2kvPcIS1uYXBlwMRxnFGYQOgoBAxivlX5itjprxa/8
         nEBW5SUPp9yN8E13biIQ4Ak+rY1GpxDbprZNnPOdTCAmLfcIKQu8y6oNo+vgIXyYYNq4
         z8VjhCjtC4AW37njncmQ51eq6DlALe4tD3qnyW+LFMoLB+FJLRAhT/3hhjv4vK04X1kW
         Tm8FFnvvKjhU/IuhtNEJ08D2wds0B5MdqnQM65XdbpB4sn3iA0RvoECU7DiL587ryx2B
         4s+/ML8DVhJ7EWOEvEB1dPkEoUqOgCqe9cgpcVT2uTClgkptwS3/J3/aRC0RHOtRKzi5
         wTrQ==
X-Gm-Message-State: AOAM531jyyVndxn2pBmi6o2PnrzEUzcZCb6RBOWdPccakTw2ZjhuZYLc
        jyDu/WqB7sFndiAzDh3wwN+Dyez14xY=
X-Google-Smtp-Source: ABdhPJypdA0S/P0NtfNwkv7OOmbKwEtajOBb6aT8zHGrr5gngBUM/CkUOJi7WveogazjpXMQ7MXhXg==
X-Received: by 2002:a17:902:a610:b029:e6:5eda:c39e with SMTP id u16-20020a170902a610b02900e65edac39emr14795914plq.11.1615869776725;
        Mon, 15 Mar 2021 21:42:56 -0700 (PDT)
Received: from [172.17.0.2] ([52.151.59.247])
        by smtp.gmail.com with ESMTPSA id ft22sm1222197pjb.8.2021.03.15.21.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 21:42:55 -0700 (PDT)
Message-ID: <6050374f.1c69fb81.65694.480b@mx.google.com>
Date:   Mon, 15 Mar 2021 21:42:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4470519682022736465=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: [Bluez] shared/gatt-client: fix BT_ATT_OP_HANDLE_NFY_MULT parsing
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210316121212.Bluez.1.I92177a7c526b6d3e04c59f95d846ddfa79977b51@changeid>
References: <20210316121212.Bluez.1.I92177a7c526b6d3e04c59f95d846ddfa79977b51@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4470519682022736465==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=448757

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


--===============4470519682022736465==--
