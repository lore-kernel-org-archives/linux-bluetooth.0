Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 509A1C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Dec 2021 19:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240623AbhLQT1g (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Dec 2021 14:27:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240622AbhLQT1f (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Dec 2021 14:27:35 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB2EC061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Dec 2021 11:27:35 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id j2so9272395ybg.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Dec 2021 11:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kCahGUhidLE3kuPHRlloa9GCpAycESM9Ccryl21WtHA=;
        b=ZFBf3jCGpXY3N8hg/aUWABTY763PW0O63O4AU8MtZwFaln35LfgY5FF06EM/5eJI3d
         6trbBt8ULo/2nbRnSCGD+IWpCGXhmF0CVqKJfnMzkxSMYx7hKTguydleJe75Fxda2rWe
         o0uuxMnNM0LZxnFqUAdmdIkXvhFqwl/IHptlS24tJMI/BOlV5p6G0u3+V0VPw01N7RXk
         5cevnXdkggyWv3x0fMW0QyIl1x6WuyzF8ai0Q5JHhHViAk54WTVhF2pBtzBeGbEcer1a
         zj3r1pbWMoO8PsvygCqIulsih6C8Nb4yshDisQtposttYlODVgI0VBaAk4xPp7xRsbx6
         HdgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kCahGUhidLE3kuPHRlloa9GCpAycESM9Ccryl21WtHA=;
        b=giQhNr/XMhwPZQqbt0695QgZ16Si4kNjQzwFpa8rJnyuiRCt3yOS51uvepeqiqwxVH
         ioOWdXsokvmpQUkBHqDPvp7a0rnxd8L33qv1v0v74+tZFiwXfxIlAbKOf/jg7+ruovbD
         jC+Y4IKukocHzdMUmRxs/t2FdlFHRFMM0PzH+GWdonbj6gAD1dbtEROeJmpwZYLqIc4h
         kQ7G9aelQpZrCoHCghE0TZqoLCZJJ5rEoE4Yg04LK0afoyTexiE5+j635HAKn/wjVJ+m
         dPpzE/fwMzeCaxvjpZDaqdXBIARqrDWITgPuZJ85PgM/eON60jqTdUqAwfrIdcucz9A0
         CeVw==
X-Gm-Message-State: AOAM532JwSUGDeG870dAwyDAoVchkGmOvTdZh2mx7oNtOB1+7RbJekT9
        1yaPuDVJ3iqWzuqk3pgiYjJHYKcecM0W0/G0IJk7VlfU
X-Google-Smtp-Source: ABdhPJyrmtE3cajk/ybzERpGwuMCwlZA+8+J+31iZ7vnbSvHvCM+SJ9GfCztE6klRKOWWuPszCMfrpc6/176Fr8i1f4=
X-Received: by 2002:a25:9bc9:: with SMTP id w9mr6252954ybo.398.1639769254583;
 Fri, 17 Dec 2021 11:27:34 -0800 (PST)
MIME-Version: 1.0
References: <20211216033453.9806-1-hj.tedd.an@gmail.com> <904d134a-a672-72a9-dddb-1c48d151e62e@molgen.mpg.de>
 <7bca0b8840cc1bab1c7ea7f25d8cca6ee41ecb04.camel@intel.com> <3ae32390-a8e5-9b65-6252-9e7f201bd08a@molgen.mpg.de>
In-Reply-To: <3ae32390-a8e5-9b65-6252-9e7f201bd08a@molgen.mpg.de>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 17 Dec 2021 11:27:23 -0800
Message-ID: <CABBYNZJSF6CEU+oJHeKtU5Z-pqL5rn_pO9CxaDwbuWeATBk-QA@mail.gmail.com>
Subject: Re: [RFC PATCH] Bluetooth: btintel: Fix broken LED quirk for legacy
 ROM device
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Tedd An <tedd.an@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Paul,

On Fri, Dec 17, 2021 at 7:33 AM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Dear Tedd,
>
>
> Am 16.12.21 um 19:38 schrieb An, Tedd:
>
> > On Thu, 2021-12-16 at 08:52 +0100, Paul Menzel wrote:
>
> >> Am 16.12.21 um 04:34 schrieb Tedd Ho-Jeong An:
> >>> From: Tedd Ho-Jeong An <tedd.an@intel.com>
> >>>
> >>> This patch fix the broken LED quirk for Intel legacy ROM devices.
> >>
> >> fix*es*
> >>
> >> Excuse my ignorance, but what are Intel legacy ROM devices? Maybe also
> >> mention the IDs 0x0a2a and 0x0aa7 in the commit message?
> >>
> >>> Legacy device sends the SW RFKILL while shutting down the device (lik=
e
> >>> HCI interface down) to turn off the LED by putting the device in asse=
rt.
> >>>
> >>> Once the SW RFKILL is on, it needs the HCI_Reset to exit from the SW
> >>> RFKILL state. This patch checks the quirk and send the HCI_Reset befo=
re
> >>
> >> send*s*
> >>
> >>> sending the HCI_Intel_Read_Version command.
> >>
> >> Is that document in some datasheet/specification? If so, please mentio=
n it.
> >>
> >> Also, in the commit message summary you write =E2=80=9CFix=E2=80=9D. I=
f it fixes an old
> >> commit, please add a Fixes: tag.
> >>
> >>> Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> >>> ---
> >>>    drivers/bluetooth/btintel.c | 13 ++++++-------
> >>>    drivers/bluetooth/btusb.c   | 10 ++++++++--
> >>>    2 files changed, 14 insertions(+), 9 deletions(-)
> >>
> >> I have a Dell Latitude E7250 with the 8087:0a2a. How can I test this?
> >
> > Apply this patch on top of the bluetooth-next (or current mainline)
> > The BT interface should be available after reboot.
>
> On the laptop, I do not have any problems with missing BT interface
> after reboot with Linux 5.16-rc5. Are not all devices affected?

If the problem is fixed for you please confirm it by replying with a
Tested-by line.

--=20
Luiz Augusto von Dentz
