Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB061C2D0A3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Nov 2020 07:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7225320709
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Nov 2020 07:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKejoWLp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725923AbgKLHZl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Nov 2020 02:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgKLHZl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 Nov 2020 02:25:41 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319EFC0613D1
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2020 23:25:41 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id a20so4328003ilk.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2020 23:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=a/Yn1rHDftF3RFM+oJx/Yb5Z/WuOgaSVKN0tyo6OAL0=;
        b=QKejoWLpfgLQ7TRqq7MazSKH3132jKTi36FJrSvXCMc+mtPpI97irX0zjqtr2sbliI
         CrC3OhLKcTx0bI1/0B850XJ2VdE1poiiZXH5fM4alkJbYAL6ynnllaR688XxRnWbOhaN
         Sgv+1frl0CrNsBfPe+vNuGm+CCbJmvea7WgOedJFOs4QfGjrwyDrIDVfJpO0anUYF1HR
         RzB8eExDYjIPzugbauGIf/6ZhKjX3tAfKcyfQtdim++GXY2AlbyZlh0vDUqNtr6qo+mL
         f1wPdpgmMAE5nIWouC9NdAZeSOulQsBS2eJxEs9A1QYl7o+P7fDDjIDWvUCAOMtZdZ6u
         W6aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=a/Yn1rHDftF3RFM+oJx/Yb5Z/WuOgaSVKN0tyo6OAL0=;
        b=sbjjbkxRuTPEGeoSWXfKpxQ6oH92VRKdC4keYUKYu1yRzzODXIgtMdc03kDjLLmREW
         9sGXNIfH/p5oloIizVMs3g9UsWX2OiZWQddc3q1yN2UpKCq9Z5lYdKQ2ybvDQFBAJpMT
         XMoNbUo4iB7+iQ4gcoJ4HO2+Ke1j29wNvrUZra1jH0QRwuBjx4WcMfa5JBqHKbiwP9gn
         BIMLJraiZIOn5SvX5k+Qa7biqd/FBS26ufgkz1z/SNIPI38AVH53aVMFMMiKDTPla7P9
         mC20ZjH0gRJi1OcYJle71Nt2T9efevzVzDZUnFJtkyCptAbC1kwC5polbnlv1Ic2ocKT
         rSAQ==
X-Gm-Message-State: AOAM532NZvNRci2dx079/8OhcRrd7GFYYXkBw8NyBqv28oEc2Iy2dK8k
        r6pcnns/XtwaRboZ6LYA+Tn+Af/hLQo=
X-Google-Smtp-Source: ABdhPJz/iyJcJXuw0M4wfePHs1zqcsVafqZSOFVqSNQ0sX6rlENn3beNIyrRKAWAqi5GKjPvTfNHvg==
X-Received: by 2002:a92:c984:: with SMTP id y4mr18713340iln.130.1605165940149;
        Wed, 11 Nov 2020 23:25:40 -0800 (PST)
Received: from [172.17.0.2] ([40.79.59.202])
        by smtp.gmail.com with ESMTPSA id b191sm2263214iof.29.2020.11.11.23.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 23:25:39 -0800 (PST)
Message-ID: <5face373.1c69fb81.d0bd5.8bd1@mx.google.com>
Date:   Wed, 11 Nov 2020 23:25:39 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5981589719742597232=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, maitysanchayan@gmail.com
Subject: RE: test: simple-endpoint: Add support for LDAC
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201112070426.21050-2-sanchayan@asymptotic.io>
References: <20201112070426.21050-2-sanchayan@asymptotic.io>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5981589719742597232==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=382461

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


--===============5981589719742597232==--
