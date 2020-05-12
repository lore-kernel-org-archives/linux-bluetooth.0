Return-Path: <SRS0=//f6=62=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13E8CA90AF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 May 2020 17:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7424520714
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 May 2020 17:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GuOs5Bo8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbgELRhT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 May 2020 13:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgELRhS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 May 2020 13:37:18 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5D7C061A0C
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2020 10:37:17 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id n14so14494660qke.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2020 10:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:in-reply-to:references;
        bh=o0sGQuEH+xagYfPFZOQDOvYN3k1lL69VjB1GZkUsmYE=;
        b=GuOs5Bo8IHGemfPQWh56iCzIF7FJQpVQOw46PUJmfAX4sSz252t4FfSCj/2vp/nDSE
         sdZtinDUOW4uyQ5zYi7G4kCYmn22BYQsVHURgR/5gs2pYInAOn5GTMfi3gd2vLXbrCs8
         MXmiKsHdREgAEVAktusbhr2OE3O/gNig0FulT1REEHmyZN4mopD699LWe43987s7bPlQ
         WAGSebr+7TYUmeFtnIry0CbIk4PEuMXCfJF4ur9QNEt8Zj83qZRBz11nYOb28OLY/5XI
         F0eTKORwUE8I0Xw69G5bVtmGCme/BNXUu8yw/l6spGrvYFDTxYn6gcdTr4/7dytaRSu5
         Yq7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :in-reply-to:references;
        bh=o0sGQuEH+xagYfPFZOQDOvYN3k1lL69VjB1GZkUsmYE=;
        b=l6WeP5ZPgs37Q/xYCzS+qDScRSv8ckSt4/jpKIIjxmVFHiU01sE+7TCKDJxj2VGyMs
         97fY+D85hAFcuFKBPkn1zUNn4FeIjfF0yi56mZkFnm8cHCU9CQZOMLtVSpzpZLvwIaH8
         Gb+UGJuT2Y6Tp0+0Nh67nnAXmSFVndo5iNkmsq08Ps13vP3ue9GT7km4UcYRjxBcings
         Efr5KWtRrhqLlU0L6SsV1k3Qb5yco+4CqIL1IGgHLq8VLaSrJbShzVE9Re8zpDnWwa8G
         go14VBDRziIqrnBz64myXSfO8sXlTaPrgsvP4w3o3SGrYCSErjHm4+uIxNkQT/1XQc/9
         DMnQ==
X-Gm-Message-State: AGi0PuYse9vSswHf4zZ+cyJuKrb2V4LsfCOHR4L4vkqiT1XxJLq8slO7
        AJaldE9ad278o7aVJArnP49tYKedG6Y=
X-Google-Smtp-Source: APiQypKHM0tOX/JJwiU6r/YwIvoUb1JXI/OvFqxbBYEKCRLb8Wi5Vm56BhEOcF/U6ZL+CecDDRlNyw==
X-Received: by 2002:a05:620a:1414:: with SMTP id d20mr19412320qkj.160.1589305036281;
        Tue, 12 May 2020 10:37:16 -0700 (PDT)
Received: from [172.17.0.2] ([13.68.72.185])
        by smtp.gmail.com with ESMTPSA id j90sm12805846qte.20.2020.05.12.10.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 10:37:15 -0700 (PDT)
Message-ID: <5ebadecb.1c69fb81.e2432.2c49@mx.google.com>
Date:   Tue, 12 May 2020 10:37:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2780881462979455303=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pali@kernel.org
Subject: RE: avinfo: Print more A/V capabilities
In-Reply-To: <20200512165112.24006-1-pali@kernel.org>
References: <20200512165112.24006-1-pali@kernel.org>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2780881462979455303==
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
3: B6 Body message is missing



---
Regards,
Linux Bluetooth

--===============2780881462979455303==--
