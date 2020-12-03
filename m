Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1506CC63777
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Dec 2020 11:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B228022201
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Dec 2020 11:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388922AbgLCLF2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Dec 2020 06:05:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388620AbgLCLF2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Dec 2020 06:05:28 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECFA4C061A4D
        for <linux-bluetooth@vger.kernel.org>; Thu,  3 Dec 2020 03:04:41 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id x15so1525695ilq.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Dec 2020 03:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=9oMeuDDDcSV0MADVWsjgO/jGY9iFS391wpVwRA3LwAg=;
        b=VrW8EnnMXxCzz4uP6C6zdQCpVL7j2jOksAGY2EDJuBeWlvYagoHXxDSwiSujOJdgmv
         wNbawI9zf870ulR4Bp30SzxlvWJluKhU+Z8dw7KX2Tw++zMnIgQRe8UXc3DZCaVIbr95
         qTRDN39jVcoVwonfS1wFHwDQScA5CF+tfSygSnILIUlUwHhmkN1a9VoQjFOEQeBeyi+l
         J6DCA+x8hTnaUHvI/RH+mUBldn8AxUYCKbjHc6CI2lytnSjQuPmjirrcdqCE5p1yV35G
         uehbha7dwGKG9M1rNwBRQiRS01NZrzYR1EVaiEWdSgV1xq4+WvLXG+NGX3K5Tbab4Dw5
         8dtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=9oMeuDDDcSV0MADVWsjgO/jGY9iFS391wpVwRA3LwAg=;
        b=nOIH09KtMhctLX/6CEClijvivu74sJ3wFF0fFv/LnEm9rLUo2RqjKTLn0UGVGBGWwD
         S32huMh/d0cBDp4wYbbrdBK0nsXW1Md6JoEMJDun1ZGrNLTEMrg5Gz1IwgLJJYMV58dv
         1txr66uF5026Gv+THMllsGQq7IB0mhIw3TeKk/qifjWvNexT9bRK4qQ2bwmz8mzDZIWC
         ZR9YPw1OP0qQKPMixX4qaHz7+bRKjmEMcmcP6TUri46lJah0VypftWuIFPHNUkKWqQce
         cSLQsBfbIsIesxP0dgecnKK0Ls546Ufa96TFByyJXq/sWlc9b4iXtdMryxmpZNwjP9ie
         dE7g==
X-Gm-Message-State: AOAM532Bi7/P4jICZktSLWVaNd3qCLG4gRGdqOHpCccx1zkc7c46OF+4
        Js6MefoMkZ98dip0pd30iACL4l9F0kQ=
X-Google-Smtp-Source: ABdhPJzEF6wk1LlJg4jhl5O2L2KDrY7fX4eLFyrLO91EZaTDzw1vaEVOHxsbxNdYgyZG9hhl5erxwg==
X-Received: by 2002:a92:9806:: with SMTP id l6mr2645266ili.304.1606993481225;
        Thu, 03 Dec 2020 03:04:41 -0800 (PST)
Received: from [172.17.0.2] ([20.36.202.173])
        by smtp.gmail.com with ESMTPSA id q14sm672159ils.79.2020.12.03.03.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 03:04:40 -0800 (PST)
Message-ID: <5fc8c648.1c69fb81.856de.2112@mx.google.com>
Date:   Thu, 03 Dec 2020 03:04:40 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============9160893806575222331=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hdegoede@redhat.com
Subject: RE: [v2,resend] Bluetooth: btusb: Fix detection of some fake CSR controllers with a bcdDevice val of 0x0134
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201203103722.3745-2-hdegoede@redhat.com>
References: <20201203103722.3745-2-hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============9160893806575222331==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=395381

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - FAIL
Output:
Bluetooth: btusb: Fix detection of some fake CSR controllers with a bcdDevice val of 0x0134
1: T1 Title exceeds max length (91>72): "Bluetooth: btusb: Fix detection of some fake CSR controllers with a bcdDevice val of 0x0134"
17: B1 Line exceeds max length (98>80): "Fixes: cde1a8a99287 ("Bluetooth: btusb: Fix and detect most of the Chinese Bluetooth controllers")"


##############################
Test: CheckBuildK - PASS



---
Regards,
Linux Bluetooth


--===============9160893806575222331==--
