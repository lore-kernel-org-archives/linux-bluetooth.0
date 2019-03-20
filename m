Return-Path: <SRS0=+K9s=RX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B24C43381
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Mar 2019 11:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F232C2184E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Mar 2019 11:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VIeXqdpr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbfCTLQ7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Mar 2019 07:16:59 -0400
Received: from mail-vs1-f42.google.com ([209.85.217.42]:34897 "EHLO
        mail-vs1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727612AbfCTLQ7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Mar 2019 07:16:59 -0400
Received: by mail-vs1-f42.google.com with SMTP id e1so1229897vsp.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Mar 2019 04:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=IVA1+RYQKYtpIGtVIziP0jHDp/GRMFH3nMi37S9Hqm8=;
        b=VIeXqdpr2Nx2T+kxF1a9jmvIq44UASG1Xd0RKxvf2XVVrSwQYg6LTvYWNz6NFGSE/n
         q0vNjxLo9SyM1TlSUmNEx2oqCAsGnG/qUB+tT780kwdTlUr7lszNgArLy3iQCIl17fJK
         bkdNH9kytlSWp8Mw+hl37mJvpH/+jsAnc/2Sog+Bdh0hQO/3p5r1N7vl/ftQyMj8MYlX
         kQoHS3qwjsT29bCpMfQfPQvpdVjSn0x7VHCdd4YqOt33nPTr0OLDFkzb2vg7bB0IcGlq
         YYrMS3/ttrLtLgoKyiM1/aXvi3xeuzuSMBgIOnfFZmv932WIAiAk5CSqelRIJ2pFgYdt
         65xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=IVA1+RYQKYtpIGtVIziP0jHDp/GRMFH3nMi37S9Hqm8=;
        b=BLupSxAd9vjU+CQt0K56YONDt69N3vOn8i1qUfZtttkTbkJ2LSVHhIoKFVTrc6Re3s
         XlbcxiB0npDqcOjfsY92s4IS8y7D0NUP68566/ZNqSxrBI1oEp++T0n0o8UB3PeUPcvB
         HT3Vj24AOAx81c9PhacuYpGNw7b/EMNt+reNfQG/tIIitUPo7dd4qUOc4snvJ3nYPEpI
         Jjdxnht2eqAYKSJJnN+AKQ3MiWFZZeHOAr5sb8KAfBGYudshXsyZMU1EYnSom0dqvSIc
         IxnXeGqMYiyAz1G/H9b7I0mkBEjkg851MjZS/QM8GMxhueBEXls3Q2uiKToeN+/XuH7l
         4iOA==
X-Gm-Message-State: APjAAAUsYM3ci8Vpt8bth+5KyiKhwfWf5sblJiP+48H+7UBVR3D9GmQN
        AYZWmCMXBeuWdN/B1psMODXW4se2yuDuGUv0Ch1v46uH
X-Google-Smtp-Source: APXvYqxf4HCctDBU3I01gC3G5Qg46+5iRPgXk2+yZ7emcrsgSCh5G4K2Tb3vxHKdFFzRWgsPIBQdg56JqNgC1luDFHE=
X-Received: by 2002:a67:6441:: with SMTP id y62mr4419505vsb.57.1553080618429;
 Wed, 20 Mar 2019 04:16:58 -0700 (PDT)
MIME-Version: 1.0
From:   Christoph Schweers <christoph.schweers@gmail.com>
Date:   Wed, 20 Mar 2019 12:16:43 +0100
Message-ID: <CA+5PdQZ19gL9Rc_mDZ+kOOfyucA8oOLOtdjoNNoD=+Dx=zLxyA@mail.gmail.com>
Subject: Disable 'Filter duplicates' setting for HCI 'LE Set Scan Enable'
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

I would like to disable the 'Filter duplicates' setting at hardware level
with the HCI Command 'LE Set Scan Enable'.

First I tried to tweak the 'DuplicateData' parameter from SetDiscoveryFilter
(org.bluez.Adapter1), but this doesn't change the value of 'Filter
duplicates' parameter. btmon shows always that 'Filter duplicates' is
'Enabled'

I also searched the debugfs for a proper setting without success.

Is there any way to change this HCI parameter setting in bluez?


Thanks in advance!
Christoph
