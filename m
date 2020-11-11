Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B26EC56202
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Nov 2020 01:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EECC321534
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Nov 2020 01:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3HicQCk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbgKLBc7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Nov 2020 20:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727673AbgKKXAo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Nov 2020 18:00:44 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F54C0613D4
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2020 15:00:43 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id w145so4113477oie.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2020 15:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ngHYUjSB4g69tZcY4bG1oVFhEeSmYSgtEYGGpu/Z2NA=;
        b=N3HicQCkN4A4OA+YKJw1iQliO6T1dM0Gw1ycoGv0qGp+/r33T7zCkcty00dpazE2cC
         zGfmy82mtqDNyPWvbZL/KcZYmmVD8sJglPI1/wDjFAFweBea41mCucQ4rpM3Cjgf0ir4
         7ucmTTlALXt16FRzMgiPJ+Z7H2YlsJ/G0X48D+ienEgSC8LNIDPfdmdSINtwPDBWMw+g
         8PZ+SSYpwG+LofU4L+xOT9Y/dkMgT1JlmjBXWpaSZxUvCp8SKpvWP2o+cVi+f9K3RQLH
         C2Z0+Z0dCIVYIsfMstOkRVx7MGRRXhx/3Tq6sUuem3x3FA4IVRL02e85HGWvyH2TWEqV
         LhSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ngHYUjSB4g69tZcY4bG1oVFhEeSmYSgtEYGGpu/Z2NA=;
        b=GskvxB89VgS1qSMNQ3fkY33mvbbfXcHMD91wRdpi9G8lQzRqf6jga/Qn8zSefAe+HK
         0GlsSGagLa2auZB7U1UgkjCC2OS5G8+S2DmJA68TIP/EoxlZrlNeyWZtinIFFmo2Hcut
         IzAJQek57n0W6AevSJx3FU6HecIJv/ftVcyWekgCZ+4Cc0579Gw6kvh9DDmjammVXYJz
         xz3ryjwVGlJY//i/eYL1VOtzlmTnvcYcxe1W/3U5IccPmoFJ/l2Co7G09CCEphPXTxBJ
         saiFr8plV5vRBrzHoapgQ06V04qa/uCltb0niPxyp9630GwqY3kxxed33hxW5EB2/DkW
         wJfQ==
X-Gm-Message-State: AOAM533S2JWVfSQRavZ+2s1bMCWxDfRbBZ1aKOnj3hBTmQ4joRuo+Amu
        Lq0vHxMNIDRj+9jzSy0AY0c7ftSKt6ksAGD6b4o=
X-Google-Smtp-Source: ABdhPJyBC2ODeIZLFMhgXrLaO4J3qlX6vsk80bTidOK3n7nRRWrWTKLintI2opdJdgTAluP7xvFT0u38o0ehQm6gVsk=
X-Received: by 2002:aca:90c:: with SMTP id 12mr3712584oij.15.1605135643170;
 Wed, 11 Nov 2020 15:00:43 -0800 (PST)
MIME-Version: 1.0
References: <d343e320-b368-e85b-d428-d5c000eb69df@doubly.so>
 <b86e5449-d784-deee-87d8-4bcf1b4b6308@mnmoran.org> <d2ebb802-3bb6-63ed-de42-e1a2b0c38f36@doubly.so>
 <CABBYNZKh2FBwVamTqznqaEO=1ksuhY=K9D4pQTbDszneLg1dag@mail.gmail.com> <cfee49fe-f4c1-e37a-64e2-94e2df927999@doubly.so>
In-Reply-To: <cfee49fe-f4c1-e37a-64e2-94e2df927999@doubly.so>
From:   Emil Lenngren <emil.lenngren@gmail.com>
Date:   Wed, 11 Nov 2020 23:00:32 +0000
Message-ID: <CAO1O6sefGxgwcesfu8qEFSX_HDRFFf8NW7ugyvXT=rSBVUMGYw@mail.gmail.com>
Subject: Re: LE Advertising: Command Disallowed
To:     Devin Bayer <dev@doubly.so>
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "Michael N. Moran" <mike@mnmoran.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Devin,

Den ons 11 nov. 2020 kl 21:09 skrev Devin Bayer <dev@doubly.so>:
>
>
>
> On 11/11/2020 21.53, Luiz Augusto von Dentz wrote:
> >
> > You also need to ensure you are not mixing with extended advertisement
> > commands, iirc if the stack does send
> > BT_HCI_CMD_LE_READ_NUM_SUPPORTED_ADV_SETS it would already prevent the
> > legacy version to work. Bottom line here is, either use entire stack
> > or switch to user-channel with a proper stack, mixed handling won't
> > cut anymore, and for the most part we should be covering all the
> > advertisement features over D-Bus if we don't please let us know if
> > there are still gaps.
> >
>
> Hi Luiz,
>
> I am not sure what you mean about mixed handling, but I am not using bluetoothd.
> As you can see the entire log, I don't see any indication of
> BT_HCI_CMD_LE_READ_NUM_SUPPORTED_ADV_SETS. Could that be a default from boot
> that I need to disable?
>
> BTW, what is "user-channel with a proper stack" ?
>
> My issue with the D-BUS API is that I could never get reliable behavior of even
> basic discovering and connecting; it's not about missing features.
>
> ~ Devin

It would be good to see the complete log from when the "Reset" command
is issued, otherwise we don't know in which "state" the controller is
in at the various commands. Also widen the command window when running
btmon so we see the complete names. :)
Seeing the result from "LE Read Supported States" would also be nice.

/Emil
