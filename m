Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E067C2D0A3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Nov 2020 13:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F71E20936
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Nov 2020 13:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tzS7cx48"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbgKLNxQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Nov 2020 08:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbgKLNxP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 Nov 2020 08:53:15 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A22C0613D1
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2020 05:53:14 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id f8so1324322oou.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2020 05:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U9q+U2tc/r5mBx+RFfNYTOA/BBF4NcJCzTG+bLRcO/g=;
        b=tzS7cx48dntJpkVtQUrcCqlmK7oExgN/iFemqaMA8odAerDTvgq5v3m9WmTRNlmqRL
         Cqk0+blvf5lWieC00H/yiCDdUG/hDNX42MaC/MrptM6fUPe/DwH0eEeIs8nLJVX/crSi
         cUezoTiTAeIdbf48AWgsiXHn65dlI3qxqdx71vlAiGCQR3RujHxZ1oOT6DxMCFEqerGN
         GkPkPMM5bTpiIRU1dJQYAueUW1B0hmmzO4JposgiqxT1IX4q0HWxGAFuMgyiB32D+lrv
         Th6CymgdsRJc+go4A7Iug/nFGZS8+gKujuVMjH/bagexgkb8t7zcDchD3TdNA33TO1sy
         yHwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U9q+U2tc/r5mBx+RFfNYTOA/BBF4NcJCzTG+bLRcO/g=;
        b=edf8gCA3llmjDwcseR4DErNiQzcLb6S9DTgEHOaOJsvEk9XRoEMgOr11s8vDzJYC4a
         4+FgxtBv/nvhEbnhX+VLMwqxQF56F6AOuZdrDMlOr5Q1quF4X1gBdauPyvsYBg7IB3Ji
         WGz+OCC+3IBPAQWOjOJ2Ei6aCWPYHlXvN3NO8B0Chwf3WwRSXEulDK7/7PqoLvwb9TdW
         ZDJVjtgVcDtD35si+ZZShN0cT4wd8+G0zakfAz9UlrAoJddZMdZxAasFR7/H99wnBHjO
         FeU4x6ibUlBVhDYErGKV5nGsVDtHCVdgxPWH4zx2MOwMJbcbKOHQtdPyV9gT6h129Uew
         mgBw==
X-Gm-Message-State: AOAM533cOHj7KdvL91foQb282tckUkxdBQLxDuM30RGhhoe2WDJ0UrkV
        iGzSXUsrAkwe2a8UepywZdnlIwor/a/yyHjWe8TNoWbDch8=
X-Google-Smtp-Source: ABdhPJyqGzrvkqcJeL9eVzN9Egf6OtURTALvDo+dlOzA2nsBJmxVK47SWhYGjPYXGK4jRaBcIoxC1ycW/sZ3LB6aP4A=
X-Received: by 2002:a4a:694a:: with SMTP id v10mr1003382oof.46.1605189193439;
 Thu, 12 Nov 2020 05:53:13 -0800 (PST)
MIME-Version: 1.0
References: <d343e320-b368-e85b-d428-d5c000eb69df@doubly.so>
 <b86e5449-d784-deee-87d8-4bcf1b4b6308@mnmoran.org> <d2ebb802-3bb6-63ed-de42-e1a2b0c38f36@doubly.so>
 <CABBYNZKh2FBwVamTqznqaEO=1ksuhY=K9D4pQTbDszneLg1dag@mail.gmail.com>
 <cfee49fe-f4c1-e37a-64e2-94e2df927999@doubly.so> <CAO1O6sefGxgwcesfu8qEFSX_HDRFFf8NW7ugyvXT=rSBVUMGYw@mail.gmail.com>
 <20201112121614.c5kko4iofg32ckxs@orac>
In-Reply-To: <20201112121614.c5kko4iofg32ckxs@orac>
From:   Emil Lenngren <emil.lenngren@gmail.com>
Date:   Thu, 12 Nov 2020 14:53:05 +0100
Message-ID: <CAO1O6se6UF9Ao516xudciGBYtA9j=i-PMEbrsAhjga10ujxacg@mail.gmail.com>
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

Den tors 12 nov. 2020 kl 13:16 skrev Devin Bayer <dev@doubly.so>:
>
> On Wed, Nov 11, 2020 at 11:00:32PM +0000, Emil Lenngren wrote:
> >
> > It would be good to see the complete log from when the "Reset" command
> > is issued, otherwise we don't know in which "state" the controller is
> > in at the various commands. Also widen the command window when running
> > btmon so we see the complete names. :)
> > Seeing the result from "LE Read Supported States" would also be nice.
> >
>
> Hi Emil,
>
> below is the complete log, starting with the the reset command. It
> includes the "Supported States" call too. Let me know if there is
> anything else I can do.
>
> ~ Devin
>

It's as Luiz said, you're mixing two different stacks and hence mixing
legacy advertising commands with extended ones. The HCI standard says:

"If, since the last power-on or reset, the Host has ever issued a legacy
advertising command and then issues an extended advertising command, or
has ever issued an extended advertising command and then issues a legacy
advertising command, the Controller shall return the error code Command
Disallowed (0x0C)."

After Reset, you can see "LE Set Extended Advertising Parameters"
during the `hciconfig` runs. Then later, when `python` runs, a "LE Set
Advertise Enable" is sent. This is disallowed behaviour.

One solution is that your python program sends a "Reset" command as
the first thing, otherwise you don't know which state the controller
is in. The other solution is to use BlueZ only.

/Emil
