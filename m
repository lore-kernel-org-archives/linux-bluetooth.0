Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B79C433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Sep 2022 21:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiI2VwN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Sep 2022 17:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiI2VwM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Sep 2022 17:52:12 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D761126B72
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 14:52:11 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id d1so1768060qvs.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 14:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=8pJ2EHHxhjCEUd7WVjSU1a6DHxtxKsSl/bwrn0bTk3o=;
        b=g6DS88ruzXcqfKXBmPpPhI/zxQCsaRdXE7mi12bDHAKZiVzEnvsKrN3XiQcEqPmK1E
         v7590UU9Q1WFxCKCEFHsZHVdlDm+YJZE1hLolrGr5lbn7/m0uTBRmnvNAKVFKw0qNjCQ
         kSFpFISPYmEGv+LIlYTMpLFGw8id4kE6AYOLa8DO6P5fiSv568YXbCUuN+/L7CXA0Qp2
         RGcEoAN+MypfcU/w7egjPSjQNg77vY+nW8UdOrafvcFgw/nXRNkzoB1+2GHLFxAUXFBt
         a//AF2XyKflM9kO+Cr62k9fRGleFv9TIYFbch36ibL75Tm60ly7q2pRkIXjXDduSfDWv
         ILbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=8pJ2EHHxhjCEUd7WVjSU1a6DHxtxKsSl/bwrn0bTk3o=;
        b=onu7Jy3i7BMy/COWw7/YEhT9nXkRVTGk9W1y+QetY2vNoaH1I4Qi0ycY7bBvfICHx0
         rrC7ny9VK0BfnHxSSHqDrgKlBLXAZXfr5/IyHibQt1nYzBxgnRCE/AaVVKmiFnaczIma
         l1cV263VDRNJ/HXF01coy3PalpIcNTVl0KNTOmB6vtHM+K8sJrxTWRLr7ls+LvjMhhOf
         N6k5pu1q3VJWvqzKW1mhx7Jo+rSbfzCv3AznIfeeRnY8t40VNt3frNmbcK0X3PtA8zxT
         EkKheJ1f984hA8GwwrltUSUB/dEfHOmtgsuRYJb8XbGiFr8e7+VVyHy8hfc4nqojijeF
         tCZg==
X-Gm-Message-State: ACrzQf0PZ3vfymlW2x+xaQD+0z0yqgZa0TKqTeCGls+2HwWC/ZDhijsq
        IYxLDwtWEDgRsoQiBUKdDguPqm9JGq5wDg==
X-Google-Smtp-Source: AMsMyM66EVpfD/XhBdHIUB5CX7fi6322RAdZiAmWqVxgJnHCIKqma4Oalbl8AfM8G8tIjJKYV99RHw==
X-Received: by 2002:a05:6214:23cc:b0:496:fa7b:2503 with SMTP id hr12-20020a05621423cc00b00496fa7b2503mr4322596qvb.38.1664488330271;
        Thu, 29 Sep 2022 14:52:10 -0700 (PDT)
Received: from [172.17.0.2] ([20.7.70.189])
        by smtp.gmail.com with ESMTPSA id w6-20020a05620a424600b006c479acd82fsm621018qko.7.2022.09.29.14.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 14:52:09 -0700 (PDT)
Message-ID: <63361389.050a0220.8f31b.2000@mx.google.com>
Date:   Thu, 29 Sep 2022 14:52:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4863967800741767149=="
MIME-Version: 1.0
Subject: RE: plugins: Do not try to autopair with Nissan Connect devices
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, florian@ubports.com
In-Reply-To: <01070182f561c630-852e0333-6f04-448b-b064-46a2f000e860-000000@eu-central-1.amazonses.com>
References: <01070182f561c630-852e0333-6f04-448b-b064-46a2f000e860-000000@eu-central-1.amazonses.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4863967800741767149==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: patch failed: plugins/autopair.c:66
error: plugins/autopair.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============4863967800741767149==--
