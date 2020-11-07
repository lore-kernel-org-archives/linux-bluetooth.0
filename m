Return-Path: <SRS0=aRPM=EN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883ABC388F7
	for <linux-bluetooth@archiver.kernel.org>; Sat,  7 Nov 2020 17:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CB0F208FE
	for <linux-bluetooth@archiver.kernel.org>; Sat,  7 Nov 2020 17:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYp4snQa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbgKGRse (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 7 Nov 2020 12:48:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbgKGRse (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 7 Nov 2020 12:48:34 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE50C0613CF
        for <linux-bluetooth@vger.kernel.org>; Sat,  7 Nov 2020 09:48:34 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id h15so4212259qkl.13
        for <linux-bluetooth@vger.kernel.org>; Sat, 07 Nov 2020 09:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=7JLt1dx/fMC7josmqv/DioQ92kyDg7OmQm52GlsIyg8=;
        b=QYp4snQa33Q5wC0hoWR2ohXttIDT1T0YgKtRo3axSDj+juac4AJ0s+5nh56+b31ylL
         fko//HuO47OnjByOhnocl5jmTimgO5YkrBsEB9iFwrNXVjwWZBrTr0i3K+lDW8BvTmig
         Dwy+3fuaLFD8JKQEwWvOjd8Ba5vTWNGi4maH/LCFLE1UKtMo9fNbt6btKBXeKO3z+cwJ
         +7c8/IQC2Q+aOL3dcCNZhlwRvTdXOF9fBO9vWDxHcJlo395WVBkrNiX+oB3trTj88rAn
         jp5j8JMkJk2vI7qoDEtLfOwauHD762igZpA1EJiqvWLNBcpu7InU76C133LMUvMTXwZW
         akzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=7JLt1dx/fMC7josmqv/DioQ92kyDg7OmQm52GlsIyg8=;
        b=Tf9AKKANwxFL2CIooDGeJQ/krSL1dSOTQLW3zYwsPqxt9JtivFnzzr2HN6DTrMfPaq
         kLj0Ncosw/NcG6iF1wvJnA3M8avK4mZRJ5CvkVdZo8+rKkfggTPoIFa9FHysdBXLHaOT
         cIJykyPc4YehmPibxlqZMvIOm3dkMSrktotD4uQPyOjrzM2CgKorBk+aHLlij4ak8rDp
         PKtuHNMjs6lhySnv5I5a6ewtnxqKJklCsQFalhyzzhEPi/hlcRbp/sWOFyvSS4C5zOAJ
         v0nUGCjUjLDVJXgRXmm5xvbGlIiQWHQ41KOXRpCmQrP/OLsif18t2E5FYfXkPZ3Q/w0c
         vofg==
X-Gm-Message-State: AOAM5322eLEH8m/74SqRg3iaaRQ4bntk4HNwXoXXIgJR3NbkmqayRA/+
        CUmsJneBahAjp/gcg+JFqk4h9ydDQBAvZA==
X-Google-Smtp-Source: ABdhPJwmnl6LoCJWONUcMRAcZqcTrj4GmuAEMIJL8NjLZvZ8W6AQpD8sM3PwPMOQ6YJWkjY4f5FUwQ==
X-Received: by 2002:a37:4e8e:: with SMTP id c136mr6777250qkb.462.1604771313349;
        Sat, 07 Nov 2020 09:48:33 -0800 (PST)
Received: from [172.17.0.2] ([13.77.104.25])
        by smtp.gmail.com with ESMTPSA id x72sm2336718qkb.90.2020.11.07.09.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 09:48:32 -0800 (PST)
Message-ID: <5fa6ddf0.1c69fb81.48e29.f445@mx.google.com>
Date:   Sat, 07 Nov 2020 09:48:32 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0602865746557940013=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, ap420073@gmail.com
Subject: RE: net: avoid to remove module when its debugfs is being used
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201107172152.828-2-ap420073@gmail.com>
References: <20201107172152.828-2-ap420073@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0602865746557940013==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=379653

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - FAIL
Output:
net: set .owner to THIS_MODULE
7: B1 Line exceeds max length (90>80): "Fixes: 9e466250ede3 ("batman-adv: Prefix bat_debugfs local static functions with batadv_")"

mac80211: set .owner to THIS_MODULE
15: B1 Line exceeds max length (84>80): "Fixes: e322c07f8371 ("mac80211: debugfs: improve airtime_flags handler readability")"

cfg80211: set .owner to THIS_MODULE
7: B1 Line exceeds max length (90>80): "Fixes: 1ac61302dcd1 ("mac80211/cfg80211: move wiphy specific debugfs entries to cfg80211")"

netdevsim: set .owner to THIS_MODULE
7: B1 Line exceeds max length (87>80): "Fixes: 82c93a87bf8b ("netdevsim: implement couple of testing devlink health reporters")"
9: B1 Line exceeds max length (85>80): "Fixes: 4418f862d675 ("netdevsim: implement support for devlink region and snapshots")"

wlcore: set .owner to THIS_MODULE
8: B1 Line exceeds max length (84>80): "Fixes: bcca1bbdd412 ("wlcore: add debugfs macro to help print fw statistics arrays")"

iwlwifi: set .owner to THIS_MODULE
7: B1 Line exceeds max length (83>80): "Fixes: 5ae212c9273d ("[PATCH] iwlwifi: add read rate scale table debugfs function")"

iwlegacy: set .owner to THIS_MODULE
7: B1 Line exceeds max length (87>80): "Fixes: be663ab67077 ("iwlwifi: split the drivers for agn and legacy devices 3945/4965")"
8: B1 Line exceeds max length (96>80): "Fixes: 4bc85c1324aa ("Revert "iwlwifi: split the drivers for agn and legacy devices 3945/4965"")"

ath10k: set .owner to THIS_MODULE
9: B1 Line exceeds max length (84>80): "Fixes: 844fa5722712 ("ath10k: debugfs file to enable Bluetooth coexistence feature")"
11: B1 Line exceeds max length (85>80): "Fixes: cc61a1bbbc0e ("ath10k: enable debugfs provision to enable Peer Stats feature")"

wcn36xx: set .owner to THIS_MODULE
7: B1 Line exceeds max length (86>80): "Fixes: 8e84c2582169 ("wcn36xx: mac80211 driver for Qualcomm WCN3660/WCN3680 hardware")"

cw1200: set .owner to THIS_MODULE
7: B1 Line exceeds max length (85>80): "Fixes: a910e4a94f69 ("cw1200: add driver for the ST-E CW1100 & CW1200 WLAN chipsets")"

b43legacy: set .owner to THIS_MODULE
7: B1 Line exceeds max length (89>80): "Fixes: 75388acd0cd8 ("[B43LEGACY]: add mac80211-based driver for legacy BCM43xx devices")"

b43: set .owner to THIS_MODULE
7: B1 Line exceeds max length (83>80): "Fixes: e4d6b7951812 ("[B43]: add mac80211-based driver for modern BCM43xx devices")"

mwifiex: mwifiex: set .owner to THIS_MODULE
7: B1 Line exceeds max length (84>80): "Fixes: 5e6e3a92b9a4 ("wireless: mwifiex: initial commit for Marvell mwifiex driver")"

Bluetooth: set .owner to THIS_MODULE
8: B1 Line exceeds max length (87>80): "Fixes: 4b4113d6dbdb ("Bluetooth: Add debugfs entry for setting vendor diagnostic mode")"
9: B1 Line exceeds max length (87>80): "Fixes: 300acfdec916 ("Bluetooth: Introduce force_bredr_smp debugfs option for testing")"
12: B1 Line exceeds max length (89>80): "Fixes: 134c2a89af22 ("Bluetooth: Add debugfs entry to show Secure Connections Only mode")"
14: B1 Line exceeds max length (93>80): "Fixes: 6e07231a80de ("Bluetooth: Expose Secure Simple Pairing debug mode setting in debugfs")"
15: B1 Line exceeds max length (81>80): "Fixes: ac345813c4ac ("Bluetooth: Expose current identity information in debugfs")"
17: B1 Line exceeds max length (95>80): "Fixes: 6b8d4a6a0314 ("Bluetooth: 6LoWPAN: Use connected oriented channel instead of fixed one")"


##############################
Test: CheckBuildK - PASS



---
Regards,
Linux Bluetooth


--===============0602865746557940013==--
