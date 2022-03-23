Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27FBDC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Mar 2022 08:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242863AbiCWIu4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Mar 2022 04:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242799AbiCWIu4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Mar 2022 04:50:56 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE95710E0
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Mar 2022 01:49:27 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id j21so627673qta.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Mar 2022 01:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:subject:reply-to:from:to:in-reply-to
         :references;
        bh=1N0OTdAUK/ih/C1UJ5j/X5sQTilvUzKvll8M7JJKOV8=;
        b=cmyP0B/u4+GTUEX8ICzdhWw4whRX/7gbJjdt8DjNAc6l/ZjSDoKaCI7EaDaApN+hxr
         OfogfBXJ3CD5G4AWInW3TinDH9vXo2aov2FcCT4US0cRnkh7AzNCkTJHhK+BDOCT9ARF
         AoEG/9rv/cwuCgivt/kEksjqtqjsc6EYAEnq0GYfhNLFQNnKh4npNZpC+7t3aq3CS+wx
         ozLh/PKARs0MMPQVwo2x4Bc6/tRzRPFjutH/RT+5x+jNs5RrrEKfMYVaQBj6c8yLZcEq
         KBAcyyyk3/ts6LNcTjLumMf8YlObZHxkoyLn1KEQRrTbImd1zzkPAJawCKVqjbUeRo6W
         0yCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:subject:reply-to
         :from:to:in-reply-to:references;
        bh=1N0OTdAUK/ih/C1UJ5j/X5sQTilvUzKvll8M7JJKOV8=;
        b=fcFcFn7OT1kDojMuqYq6GEGg3jEYp63NGrcM9Gs5/RdVliOfWsFP6qFcQ+J/uEDb9R
         s6GV4u0rzOtqJaqgKlJx1BxxLOKWNbptGkODEP4SYeyboUDLLEtv4hnBQ7d4nAd/+WgG
         07g7FJZt9kDboiD9XlpAtgacO2QdA0QLqu4oAOEN21GxktPyo+iuu9iCLYGR7Jo+uYij
         RKwqj6J0ftcs4PBWIjPBB+EwqOwWAZer6It0nY+EUx1fSu3d5mcXkVgVA77QnsXgHb+i
         gV+k4y6Y72NCW9muv/hcwVKUi1WH8C3q8Ofv6Bq7hQ8l4Y6kztbZqYPGsAlWTh2ySWse
         4Ulg==
X-Gm-Message-State: AOAM530GAh13MffoleS2YF2VbRESD+6gFql1RnHAGT0h21hMS+K2tGwn
        bYTlo2TDg2na1dcuELXpt8//x8+r72nKAg==
X-Google-Smtp-Source: ABdhPJwEhOOwsA48EvTzRVcgnKxyyh+24W7lnxxTIPzFdIQZoOPJILepzcVlA+yuQ0zauoXZgUo31Q==
X-Received: by 2002:ac8:5d89:0:b0:2e2:74e:f1bb with SMTP id d9-20020ac85d89000000b002e2074ef1bbmr15827575qtx.219.1648025366298;
        Wed, 23 Mar 2022 01:49:26 -0700 (PDT)
Received: from [172.17.0.2] ([20.97.241.109])
        by smtp.gmail.com with ESMTPSA id j11-20020a37a00b000000b0067b436faccesm10337179qke.122.2022.03.23.01.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 01:49:26 -0700 (PDT)
Message-ID: <623adf16.1c69fb81.b9a8a.713b@mx.google.com>
Date:   Wed, 23 Mar 2022 01:49:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8264654461799639748=="
MIME-Version: 1.0
Subject: RE: Bluetooth: mt7921s: fix a NULL check
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, dan.carpenter@oracle.com
In-Reply-To: <20220323074830.GA4639@kili>
References: <20220323074830.GA4639@kili>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8264654461799639748==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: patch failed: drivers/bluetooth/btmtksdio.c:961
error: drivers/bluetooth/btmtksdio.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============8264654461799639748==--
