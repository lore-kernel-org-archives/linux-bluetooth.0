Return-Path: <SRS0=QCqs=4V=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE634C3F2CE
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Mar 2020 18:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8047820870
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Mar 2020 18:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UeuRNCHk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730068AbgCDSuL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Mar 2020 13:50:11 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]:36264 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729600AbgCDSuL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Mar 2020 13:50:11 -0500
Received: by mail-oi1-f170.google.com with SMTP id t24so3192254oij.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Mar 2020 10:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cBD0U3iz4JM38a2ZoQ5M+qZRNjxUdu5mGHJw43sHqdY=;
        b=UeuRNCHk/9RVSEAYO2LYay0iuDGAjEw2S6EVGBx3sSXc1MyEBSptyymJbtZkGzd6DW
         ozmAOyNHoE4Qxqe3/PtS6p76DXlvR9PSddXCLxVuwri7Bztxv24b/l1jkaysoYiwCSA5
         o6gshLW1o7DwpVbU7iItGybjf5RrVXgoqVZZ23Z4vETP08MuZSm9HVuHQODknsN/F7PQ
         OTkmLf8603RxIOdRpfzqJJTzNFTn1q8G/vuwUy4LsCNFbybbKpDQMwcd/gD2/+vM6eOh
         aOD0yAUP+t9PYeEqicKI/Re0xjPa9uStHA/gzNdzucjkwG452mfzxm84kFUJOy872RZA
         or/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cBD0U3iz4JM38a2ZoQ5M+qZRNjxUdu5mGHJw43sHqdY=;
        b=I84vH0idHkmDPc8jNuRqoiMaC4vjQCvojTLTVZI4/FfTbPVCs0bUEMAXh1+sfwUsse
         b9XrG87Il9jclx6iSwCenZZixs4gv8zERMO2bUqRaUjQpGkVE57JRzps4D0qMPxnK3Dw
         SCi5SCxaBxrXSp93TlF4g1MZLefXGs650E+Kbc9EKJz0M9tVBq3u6QOxPOruqIGrmhjl
         gypwmJdoQIWKtgyD0oxOM+rQ3V/qPX2J9C3g3j3JYM8jL4q4t5mvnn2VDWooBFmA6DR/
         GXd7JX4Aw4K6x3iqkteoqU/ZNE7f6ZNcyA5nVx1QZkoyG1HiXY+xPY323O/BakxkoT0F
         tZFw==
X-Gm-Message-State: ANhLgQ1rkSpECIdIwfO7MuDxhwEKakS/ZUUKQgj1/yKL7796tnIbdhpY
        Q5kBQBmXNxadUDwKsOYyoP+434qQddeAFwnkgwq99Q==
X-Google-Smtp-Source: ADFU+vu2dXsZUDCEXxN9CgQDuydAMi7FDoP3k02X40O94aM8z3z085wdiqiV8neG9YL0Rd416lxm0ZkuOn5v5eJXvFs=
X-Received: by 2002:aca:56ca:: with SMTP id k193mr2851183oib.133.1583347810186;
 Wed, 04 Mar 2020 10:50:10 -0800 (PST)
MIME-Version: 1.0
References: <CAO1O6sdGJeAKTHBVyDSUa7-Hp_ULYmfOHJEbb6=-B6xuPHvffQ@mail.gmail.com>
 <CABBYNZKtxPmTUn2fw9-dy1V9M_Pb996O6VmHkg4NrAr-=t+-4A@mail.gmail.com>
 <CAO1O6sdke-2J=eYHS2SoG83v-hMJDBu-gasufJYDyHK+1R+w5g@mail.gmail.com>
 <CH2PR14MB3658759A2701FB52A2D6573BE6E50@CH2PR14MB3658.namprd14.prod.outlook.com>
 <CAO1O6sfwcEswTkuuntoBM_S5oFkQv7mCP1GH8Z0S0vgHk2Bp5A@mail.gmail.com>
 <CABBYNZ+2v5Z05dSD+TrzioGYVWugZJGpBnq+2M=MO-smuVgXbA@mail.gmail.com> <CAO1O6sfWgqnduM8_UuO_1W8KjnEvoetbk6bcaA_ATFUaXLtB0w@mail.gmail.com>
In-Reply-To: <CAO1O6sfWgqnduM8_UuO_1W8KjnEvoetbk6bcaA_ATFUaXLtB0w@mail.gmail.com>
From:   Emil Lenngren <emil.lenngren@gmail.com>
Date:   Wed, 4 Mar 2020 18:50:00 +0000
Message-ID: <CAO1O6scSRkpToMRbNwGHSzmPcm=Vqg2mBEsZz+TUM4bPLZZmRA@mail.gmail.com>
Subject: Re: Get negotiated ATT MTU?
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Jamie Mccrae <Jamie.Mccrae@lairdconnect.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Den ons 4 mars 2020 kl 18:47 skrev Emil Lenngren <emil.lenngren@gmail.com>:

> So if the peripheral sets its receive MTU to 48 and the central sets
> its receive MTU to 517, then 48 will be used in both directions.

Or 64 here, since 64 apparently is the minimum allowed.
