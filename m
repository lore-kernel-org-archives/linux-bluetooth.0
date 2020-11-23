Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125FDC63777
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Nov 2020 18:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DA9B20702
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Nov 2020 18:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLl895mv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729877AbgKWSuS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 23 Nov 2020 13:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729739AbgKWSuR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 23 Nov 2020 13:50:17 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D74C0613CF
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2020 10:50:17 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id l7so7838940qtp.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2020 10:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=suZAwSQbJDuy84PuoKRJALA0GZ6Zkxw0LISztCCyFqA=;
        b=KLl895mvAhDbmJmFob8XfZ0yi37edDrLgGD/NAGaNqTeK4px73GojBJq/SiDAAg1GC
         bNrPNFtSU9WVjq9ohoSbDzHHH1je4Zi76ziHuaEnnLqs5tNxv+bxdXNR0sUIEscoNQhI
         eUQgTB7V2ZoM0TELiZBp1f0+pxY9ynTljfB0xw1H1NEQskTyum5SVVUNi8jOZION22sr
         a7mPDFlusrfAQ6Utj4qX+QWG9OMyGexmDj1icRwTsNWJyEie4JNoDAsRkzQP0Ju21tSl
         xQ3Qox335Vy/IuSP6swqw9NCDi4+nmOm+78VJwbIfGx/GpOSgwC/jQ3fW1em8z9/lGw/
         a83w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=suZAwSQbJDuy84PuoKRJALA0GZ6Zkxw0LISztCCyFqA=;
        b=H3b5vDHnwcwaxGu57ivMHvSSh/uhp5RWXX80uyPltaO6s9sny5q4IYpMo/feQiJ8xm
         b6+ypdVlw5FktEQz1A08eJP8ct+yvjeXYiYnDU8eGWWwFTEep6CAqV3kYiKXYY5Nlnqw
         1aris8E6svugOXABp5tms5Ix9y7pShDBLT+MEgW7FL8NLFoJkoKT7xxSNj2z/Cm9vbzH
         Pel+8MnZNUg2NakDU+Kn962IEmz2yRcr8Ofe6zfJohqTCXaprMH/UPjv/sj9fRGShZlu
         m2E5Fmtb3xBW1Ugja6lWfAEnAfXZkh+FD1T4P8sY/NoehHaySiYpMb98uPMZ5+KO+vz7
         zfiA==
X-Gm-Message-State: AOAM5318Xc8WXmUIAgd+EhLbc+i2II8pU5F6RQBh20PVPLCNINri4YJk
        PqgHPkeR8UivpiU0nbLkO+C+H0G3gkO1dg==
X-Google-Smtp-Source: ABdhPJypjtnDTw/Y31AaCzmhMFPtOY2Ib++iWrg8dV+8nDOgBY7+36LXbinnDdK+HUlY9nBZkYESlA==
X-Received: by 2002:ac8:5b82:: with SMTP id a2mr561265qta.178.1606157416337;
        Mon, 23 Nov 2020 10:50:16 -0800 (PST)
Received: from [172.17.0.2] ([52.179.179.79])
        by smtp.gmail.com with ESMTPSA id h13sm1694538qtc.4.2020.11.23.10.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 10:50:15 -0800 (PST)
Message-ID: <5fbc0467.1c69fb81.1d1e.7124@mx.google.com>
Date:   Mon, 23 Nov 2020 10:50:15 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2527023736017131220=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/2] a2dp: Fix crash when SEP codec has not been initialized
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201123183440.433677-1-luiz.dentz@gmail.com>
References: <20201123183440.433677-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2527023736017131220==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=389671

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


--===============2527023736017131220==--
