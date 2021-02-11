Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3BA6C433DB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Feb 2021 22:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8558C64DCD
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Feb 2021 22:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbhBKWhc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Feb 2021 17:37:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhBKWhc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Feb 2021 17:37:32 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1869DC061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Feb 2021 14:36:52 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id v206so7010239qkb.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Feb 2021 14:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=+bIcKQbSFQ6ZVdLxWrqdhz/ygfFy88imXn8E/keKANw=;
        b=AIOH9g2mwHLAqbANVYKg+D1jlQ4DZ4YrQR4/ZZIkUFKet0wygzRawNkqQ67A3R5SDV
         2WJiDk6anSAKc/vC4CpZErFOT0ZTxQn8W7OJtcO6Bfnvaz36hCfm1n5RfaRksTJhrW7/
         0ObuGGAxdQd+CrdZFYxQUSVY+qcS9G5vQL1C208oKdri7b9qcDdHAQ7ikPwgKkfkaiMg
         bcMsBzXwAGIXwnaQYLY6hIJmmqDlK9QIfrRibslzLJDe/a+jvpFBG/E0i5WHSHT9HPFm
         Jsv4F7j10r+73YT+rr0+tcd53vLVI4s2nnllKK9bQvIo453DlCEf/pHPUtq2hYwsA9Hb
         PQWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=+bIcKQbSFQ6ZVdLxWrqdhz/ygfFy88imXn8E/keKANw=;
        b=djTyi9BUazr7KfIY5mLBTEX57ckRDlquvXaTZ390O1ihY3njU1+yR+rjgWPLRPsIJb
         qvBOm4LXTYfcZ6YddGOC1aqUT1TA4MUOA84p2pwKOaLXUp/hCYcAlOyHBSZ56e5k6vYU
         7qdjDkjr1KcyS1nhqTHqzPzgZWNb+jyYqBCi+BHcCjQSk2sSOvq2hJRskMHM3Txk94Yo
         UGOIWzu40NEcqFxe7AhfCKw75ib8oeI/BfUvr79QXExCKapxZDMeMfZjmc3T2ES+vdw6
         prgT9OGc7GvSQKwe+vbya+8rXseCaO0Rwhxw16NwkeRZw1uLYhcI7AFmyArxk3SRO1v7
         6Swg==
X-Gm-Message-State: AOAM531wfnYiHEr9M0gEEi2+deNPtmnbhFgj7Er9BbdT134l2ucy5PUw
        Gpm+pr4lOgap98Pu+HzIrUa2UkdxF30=
X-Google-Smtp-Source: ABdhPJy5lQm0YCRBhdIsgjGStY1uCYOjuIwNZiO/TB05gvzuE1s6Sv3vV8QBeT0rkrdslOD13IP8Rg==
X-Received: by 2002:a05:620a:13ae:: with SMTP id m14mr13608qki.35.1613083011059;
        Thu, 11 Feb 2021 14:36:51 -0800 (PST)
Received: from [172.17.0.2] ([52.242.91.177])
        by smtp.gmail.com with ESMTPSA id p68sm3959172qkb.69.2021.02.11.14.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 14:36:50 -0800 (PST)
Message-ID: <6025b182.1c69fb81.47d5f.9b6d@mx.google.com>
Date:   Thu, 11 Feb 2021 14:36:50 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0815216893528667904=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: RE: Use compliant UUID for mesh
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210211222143.39986-2-inga.stotland@intel.com>
References: <20210211222143.39986-2-inga.stotland@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0815216893528667904==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=432455

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - FAIL
Output:
tools/mesh-cfg-client:
1: T3 Title has trailing punctuation (:): "tools/mesh-cfg-client:"


##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============0815216893528667904==--
