Return-Path: <SRS0=YdAw=6E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896DEC54FCC
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Apr 2020 22:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53B3120B1F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Apr 2020 22:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJIYGA72"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbgDTW7S (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Apr 2020 18:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgDTW7R (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Apr 2020 18:59:17 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D196C061A0E
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2020 15:59:17 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id i22so9657829otp.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2020 15:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NQTmlljZciYmMenfJyuMSFloBg60EF9NOPyLSKDSVbs=;
        b=TJIYGA72+11gkUmcqt5P4uAexBo8feTbagPFpVpChrSU7Ysbp2t4sKdpV3S8CgEHjn
         1ZDCXkxgasa73zwMxO6vSoe7riJJBE4z42EoLRkweLGGkf/2HH2CJJ1munlasUTe2GuL
         HnlIEftktUvkqAw1ff8+B/FYSeVFA/A/8CBny1UGPHyFlb4u/RxZMOak7Xes+KY6Q5nX
         T5IMpLrzRJTyJgLlOMQoS44jEHmnNWSxFG3H1obcm+iNJkPxcDHKX6McevbVLHJnJ5vf
         glXoKD6jnGxpL7Bj5zM8auEBohrVXesRq1ZXB+ZelGDM+74Ac65rM12sy1kHOU1yyyH1
         k+lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NQTmlljZciYmMenfJyuMSFloBg60EF9NOPyLSKDSVbs=;
        b=uIbFsmsEdknUbAMItyWyQru0gL49u1Ep5UEFRu0kY/g0RMWpJhUsmSOvwh1P88pIdT
         kqeAqURjuTv4oTczar9/1wV1Eo0zRrskB7dJueLpo59Gvvr2M4+yB/avnnfqecN0F8ut
         NxdNI9NyjzAXQGtDXEiGdtDmrynlTaiXmU3ANrWkK38wQ/bbWL+PB2fQYqNA3MBOnBWD
         hMZdDde/X8RB5ykSdwddwpbXW8SiShpoIs5LvseD+Sgzx58J1Nm1hXiI7USP8pmg7Je5
         rTjvdlbzMxf/EqD1G3XCSOfrzkq8fPinNZNrg/V6eHXsyYkfTkoMRE+e4vblY9gGVCnT
         QKFg==
X-Gm-Message-State: AGi0PuYx4FEAOjwFmfTQOKdsTuwvnxvK4B7YlVFXstCCkWZFXe/I517u
        3RYO+fcey22rS6NF3+KlFrh4IzFwEsw34h+6iy6LohZg
X-Google-Smtp-Source: APiQypJB++wdb+PpJpL1u07QT82zeGew+Rgd9XhfmcFoBu4iKWelrT5l0jDGivMc1HV5cKOtXtJFVynbcDWT2I4NteY=
X-Received: by 2002:a9d:4699:: with SMTP id z25mr5038398ote.11.1587423556990;
 Mon, 20 Apr 2020 15:59:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200419211058.31987-1-pali@kernel.org> <CABBYNZLO+o1XiY7bo0epOt-hOQ+SSFKBiCjcKv4e+xkTfBYWGw@mail.gmail.com>
 <20200420224306.vmtydk5ylubs2dvk@pali>
In-Reply-To: <20200420224306.vmtydk5ylubs2dvk@pali>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 20 Apr 2020 15:59:05 -0700
Message-ID: <CABBYNZKN=T0Be0PQ6AFW6vXVnuCjPFQ+H01ihV_btHpuFatQYQ@mail.gmail.com>
Subject: Re: [PATCH] profile: Fix reporting error message when connection failed
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

On Mon, Apr 20, 2020 at 3:43 PM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> On Monday 20 April 2020 15:38:43 Luiz Augusto von Dentz wrote:
> > Looks good, but lets have the btio changes as a separate patch.
>
> Hello! Do you need from me to resent this change again split to two
> separate patches? Or will you apply it directly?

Please do the split, it is always a good practice to have the author
do these changes since you are more familiar with the changes, it also
makes it simple in terms of authorship since then I don't have to fix
the author manually and risk having a typo there.

--=20
Luiz Augusto von Dentz
