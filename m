Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7328C63777
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Dec 2020 04:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8795622201
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Dec 2020 04:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbgLCEia (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Dec 2020 23:38:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbgLCEia (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Dec 2020 23:38:30 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA4BC061A4D
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Dec 2020 20:37:50 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id h20so1064212qkk.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Dec 2020 20:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=VnSTWHJg5M6oRq/m9FoFYoXqHdm5a8URJ9x8UeEgfxk=;
        b=LYFA9kRmktB1Ej1FZDi/m86lWHfGHsokT1K67omnc9FfxWztqEqwOEPU5PpzRdr03Y
         9jpfTLunMFC4RVv80xLZqPFW88G8kDyly2g204SRHcPzSYN+x33X1YqJ/h4OqOIfYDM2
         bHTNQr16ibbSF6Xfl0QWkEZKIXI1pcvovCjxVVMGA40Ql7ciyjte1SBz0+nYVIBDwaEN
         JfgbMEC+NHVB0aqB+X4YlPfUWU9EnbB4dcWaanbF2YjZPYiKz3YCnfqxmjDxBK0r8l5D
         CHCZxmAOrGvgVfM++OLEFOEf8+NiAH0QCxadTb2EOYJYNyLafpPyIYJIG0eWPA1M4WS8
         nGbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=VnSTWHJg5M6oRq/m9FoFYoXqHdm5a8URJ9x8UeEgfxk=;
        b=kSGWadR//3J8+8C7Jzl690PX+8Fyhw5jt3RY0PU1o5gFO8FJRuy4oJtLIRG2JyMqXZ
         WTa2oVW7G2M8vCwqhDc91XjwixrY6XerHjL38nOseugVCRqZDV4r6j/+76vQLk+QmWsf
         m9MNf/39eRSSY5BkfXo+xEnYbzzdR1bsetBcfNM4ogk9KuCih8xEQIsq7AXJ63XB9o3w
         yXACg9DFL50QHW0qKY9JYWHQ9hG5ALWmB31H+WgfQZi/c7YuE8HwIXdI+9IBOkMhNjBn
         OHQtF7lZdQZY3Zn6Q6HK0NgpdQOt9nlPQWqSQxAv7NbQFXaY45vNMWaWZtDWJaYtt0cR
         Klvg==
X-Gm-Message-State: AOAM532ajM7roitnUkI8jGxqopzjNPxD1q7eu8KD8XEQTabcPqPE+6ym
        JAy3AOlHfzOrKCl0S2GI/39xYrfhdZENiw==
X-Google-Smtp-Source: ABdhPJzEFkSRLHXK9yL3YK0bCnTi4dCcIsY48PBA8bt1BXWTRqU5nmgzc4mvd3dmSIFgkBBg/byeog==
X-Received: by 2002:a05:620a:a90:: with SMTP id v16mr1190136qkg.479.1606970269652;
        Wed, 02 Dec 2020 20:37:49 -0800 (PST)
Received: from [172.17.0.2] ([40.75.24.37])
        by smtp.gmail.com with ESMTPSA id z8sm61748qti.22.2020.12.02.20.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 20:37:49 -0800 (PST)
Message-ID: <5fc86b9d.1c69fb81.42315.027c@mx.google.com>
Date:   Wed, 02 Dec 2020 20:37:49 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3855025872053549036=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mmandlik@google.com
Subject: RE: [bluez,v2,1/2] adv_monitor: Register client app with app-root-path
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201202194547.bluez.v2.1.Idce75740a54d8a860450da8a7a21d55777c87ae9@changeid>
References: <20201202194547.bluez.v2.1.Idce75740a54d8a860450da8a7a21d55777c87ae9@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3855025872053549036==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=395121

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


--===============3855025872053549036==--
