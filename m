Return-Path: <SRS0=sa5O=ZF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23816C432C3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Nov 2019 17:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD1D0206ED
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Nov 2019 17:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BkC55SDN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfKMRrC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Nov 2019 12:47:02 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39621 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfKMRrC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Nov 2019 12:47:02 -0500
Received: by mail-oi1-f196.google.com with SMTP id v138so2568059oif.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Nov 2019 09:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F2W3S6fSAPS22Y20Zw1Fd1jjLpKo7b1BbZvmEmfJ9/0=;
        b=BkC55SDNjE8ltR+xlJKO+aB1udeYk1KGsJn5ilQN9mi+UqHLmjQ3LAsfvpuFEJRG96
         MkAnyIHNAi76nHi2aYM+W/E6yHaOf1r48BAgVe2vrUSL1cQzCgnChOX0dbR5tiZ+jUh6
         p+npxLRn5z4mI/wCwlzoShjpo8S1KjXod9C0fSAiAMXph73RCKbDv6bKbsyA3u47WTBG
         xQTC/6bEFmhXAlg2ybEoVP/tAj4DmwYyvsKn2st9BDcDrrqpcXF2H0bLtE89Hjgo9tiy
         Hc/r2Dk/d5y+hGUTPrysNvUQqfyraZtyd//CVz6mrZghoX0lwtBJl1wzLj3OfU68VVIY
         4bgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F2W3S6fSAPS22Y20Zw1Fd1jjLpKo7b1BbZvmEmfJ9/0=;
        b=MzAHp8FkZEkH3eCtlJdwMjh6ThlWeKJmE5qLNefyo+hODrS2QB0+pK0rGNOciz14bb
         YDstiEC5P7T7nWlQfWFZg2Vn+thAunLZ0tarj9BVnq+XbJM929J2xbZXYkX0qQ5JKfkG
         wUhdt7qM9bjSIF3NgOrpgpjdejSvKRPK4Un5TYF0gu7bVPX7g68W0hcP+W7wDEyPVnA5
         YHm8kcLtl8aQyvPJn1hvbHGIUNJisSFPSXPMfd+Ub7G7MOnZ8iyij589vtgGlBD+iDCw
         K098DtWbXnzTNWHCavdsMljCTcPV0UvhIrd8GpD0/EwffK06YD6yp9tBzvSDbIhJFKw1
         iVLw==
X-Gm-Message-State: APjAAAX6NOfTQpkDRfvpLCJ3zv5g8jppjH7PfsZqBGi5qQlOTB5z/CSZ
        wGxqXMzr1wqedDpXAAqxSr8j+p7BPE7LN0lN3fQ=
X-Google-Smtp-Source: APXvYqzsYLdxnZE3YQulsZHQkbnizJugTJk5dlhyAkUytbxwNcVQtk+d/7O/aZCBpwv4pr90EUHSP2rspBVtFco50OM=
X-Received: by 2002:aca:c756:: with SMTP id x83mr3667168oif.8.1573667221041;
 Wed, 13 Nov 2019 09:47:01 -0800 (PST)
MIME-Version: 1.0
References: <20191023054119.7712-1-inga.stotland@intel.com> <35ef6466f21e861809ddd89a04019d98ce869918.camel@intel.com>
In-Reply-To: <35ef6466f21e861809ddd89a04019d98ce869918.camel@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 13 Nov 2019 19:46:48 +0200
Message-ID: <CABBYNZ+UkW6-8tN3iypVhtLA312VV0cBKidv+QFdm8Qy4pu=tQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] shared/shell: Add prompt item to bt_shell_menu structure
To:     "Stotland, Inga" <inga.stotland@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Inga,

On Wed, Nov 13, 2019 at 7:33 PM Stotland, Inga <inga.stotland@intel.com> wrote:
>
> Hi Luiz,
>
> On Tue, 2019-10-22 at 22:41 -0700, Inga Stotland wrote:
> > This allows to associate specific prompts with main menu
> > and submenus thus providing for better navigation when
> > submenus are in use.
> > ---
> >  src/shared/shell.c | 3 +++
> >  src/shared/shell.h | 1 +
> >  2 files changed, 4 insertions(+)
> >
> > diff --git a/src/shared/shell.c b/src/shared/shell.c
> > index cfdcc76c4..a821c8d0a 100644
> > --- a/src/shared/shell.c
> > +++ b/src/shared/shell.c
> > @@ -1226,6 +1226,9 @@ bool bt_shell_set_menu(const struct bt_shell_menu *menu)
> >       if (!data.main)
> >               data.main = menu;
> >
> > +     if (menu->prompt)
> > +             bt_shell_set_prompt(menu->prompt);
> > +
> >       return true;
> >  }
> >
> > diff --git a/src/shared/shell.h b/src/shared/shell.h
> > index e14d58381..a9eee506f 100644
> > --- a/src/shared/shell.h
> > +++ b/src/shared/shell.h
> > @@ -53,6 +53,7 @@ struct bt_shell_menu_entry {
> >  struct bt_shell_menu {
> >       const char *name;
> >       const char *desc;
> > +     const char *prompt;
> >       const struct bt_shell_menu_entry entries[];
> >  };
> >
>
> Do you have any comments for this patch?

I recall experimenting with something similar, but the problem is that
sometimes there is already a prompt set, for instance we set the
address when connected on bluetoothctl and that should probably stay
even if you change the menu, perhaps instead overwrite the prompt we
could have another section so we append the menu name at the end of
the prompt or something like that.

-- 
Luiz Augusto von Dentz
