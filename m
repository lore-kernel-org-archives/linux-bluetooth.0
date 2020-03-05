Return-Path: <SRS0=x0qO=4W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C74DC3F2D1
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Mar 2020 19:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EB4C2072D
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Mar 2020 19:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nfkfu9gp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgCET7A (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Mar 2020 14:59:00 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34176 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgCET7A (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Mar 2020 14:59:00 -0500
Received: by mail-ot1-f68.google.com with SMTP id j16so131253otl.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Mar 2020 11:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KxwC4tLQfeP5d875XL/wkWB0a3DJ6GVzGhHeZk7jQnE=;
        b=Nfkfu9gpVB5vm3dSdK/zSTqebb7c0id6hYAUYnGUFnO7l+0fVDhcy61Ef74wVKAF/y
         9KHaRllY3YwPkjsi8HClYAO0YeEZ+W40ezqxhP7PD1Zz2JxR25MYfnzRzB/dDc7nFlBJ
         C/7WY5mEXPxQpXYCMOfWABUBRVqNSFW7GXzhSLpcT6nxlNwPH9ivZtfcPbancpF1IdU8
         iAENZRt5ZSTCD0+67I+5yA3WdxyMtd43fy1yWXkdN3moHnvhKy2FMbtAUb/Tsz/U8mbf
         wHMUzplT7LDWmw3QjQ0FC5lX5tt2vnhCPpH+2zEEVxPf8vYcwaX0T5Zn2+6bPsNY2EV7
         V5qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KxwC4tLQfeP5d875XL/wkWB0a3DJ6GVzGhHeZk7jQnE=;
        b=mIk5loFuT5vBvhNroitMrhRc8/Mz+8Mgb7kQ3Vc/I3U7aNLdIAKZv2+U1pSn74zA7P
         BWJV7KxDx+F9tsZvLIlH3vouFZwKiSPR7T2Hh1MQcD528Ban/i3aygaqihWnDZu/vBlC
         CQFTncDya/UnccN8krdO4M9exxvGrmQOkhSuClZYz3AhjSrwmTFXnny+/EC6C5oZbx+f
         m7yTHDcew3/fXgSL3q/qsY3Sf9GUHjQcWv2AVnepSlrKgnbQ/O2CYtrf93VjHKdc2SBN
         hz/UN3CH9WPt/rt+u+TKeQ50+nGoJKFDcnV7UM704NFlUtBPrN0IIeR9mjiaAS2SLOtM
         l1tA==
X-Gm-Message-State: ANhLgQ0eqkbnYtKs9AURkcBHysJ/xiLjmmdovWmDNJgnpTzCASNqjak6
        /g3egX+FNrfmQXL6WrPXwNp8JBP2TEujaf0v6mm9pWYi
X-Google-Smtp-Source: ADFU+vtfEM8vumMfzyr2FdOfUoiUxbsomEOGfDcZrn+s5A2pNqz8U3CChx1XWYvHSf2CU4PGrgQpAeAzpaKawwIQrAc=
X-Received: by 2002:a9d:46e:: with SMTP id 101mr116570otc.11.1583438339366;
 Thu, 05 Mar 2020 11:58:59 -0800 (PST)
MIME-Version: 1.0
References: <1583398524-18749-1-git-send-email-ajay.kishore@intel.com>
 <1583398524-18749-6-git-send-email-ajay.kishore@intel.com> <CABBYNZKUnVWpZxBVW12JnoY1ZV+_jwsO90+M8-kJNYjaA0kBDw@mail.gmail.com>
In-Reply-To: <CABBYNZKUnVWpZxBVW12JnoY1ZV+_jwsO90+M8-kJNYjaA0kBDw@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 5 Mar 2020 11:58:47 -0800
Message-ID: <CABBYNZJmONdE5-0mczy+RX3NwVKbM0evqChBzuCi97W+3UxthA@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] doc/obex-api: Update documentation
To:     Ajay Kishore <ajay.kishore@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Ajay,

On Thu, Mar 5, 2020 at 11:53 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Ajay,
>
> On Thu, Mar 5, 2020 at 1:21 AM Ajay Kishore <ajay.kishore@intel.com> wrote:
> >
> > This adds documentation with the conversation listing feature
> > ---
> >  doc/obex-api.txt | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 50 insertions(+)
> >
> > diff --git a/doc/obex-api.txt b/doc/obex-api.txt
> > index f39355a..ef81460 100644
> > --- a/doc/obex-api.txt
> > +++ b/doc/obex-api.txt
> > @@ -712,6 +712,44 @@ Methods            void SetFolder(string name)
> >                         Possible errors: org.bluez.obex.Error.InvalidArguments
> >                                          org.bluez.obex.Error.Failed
> >
> > +               array{object, dict} ListConversations(string folder, dict filter)
>
> If we are going to return Message1 objects this should reuse
> ListMessages and then use the Type filter to specify the types of
> message to list, if that is not present then it should list
> everything.

Actually let me take this back, the properties appear to be very
different so combining those objects might not be reusing much, so
lets do this using ListConversation and Conversation1 objects with
their own properties, that said the names I suggested bellow still
hold.

> > +                       Returns an array containing the conversations found in the
> > +                       given subfolder of the current folder, or in the current
> > +                       folder if folder is empty.
> > +
> > +                       Possible Filters: MaxListCount, LastActivityBegin, LastActivityEnd,
> > +                       ReadStatus, Recipient
> > +
> > +                       Each message is represented by an object path followed
> > +                       by a dictionary of the properties.
> > +
> > +                       Properties:
> > +
> > +                               string id:
>
> Properties should use the same format as methods in D-Bus, ID might be better.
>
> > +
> > +                                       Conversation unique identification
> > +
> > +                               string last_activity:
>
> LastActivity
>
> > +                                       Conversation timestamp for the last activity
> > +
> > +                               string chat_state:
> > +
> > +                                       Conversation current chat state of the participants
>
> ChatState
>
> > +                               string presence_availability:
> > +
> > +                                       Conversation  participants availability
>
> Presence
>
> > +                               string presence_text:
>
> We could reuse Subject here.
>
> > +                                       User defined status of the conversation
> > +
> > +                       Possible errors: org.bluez.obex.Error.InvalidArguments
> > +                                        org.bluez.obex.Error.Failed
> > +
> > +
>
> I though we discussed about this but it seems that the properties here
> have no relation to Message1 which appears to be the objects you are
> creating so you will have to introduce these properties also in
> Message1, besides we need to include a new possible value for Type
> e.g. "Conversation"
>
> >                 void UpdateInbox(void)
> >
> >                         Request remote to update its inbox.
> > @@ -799,6 +837,18 @@ Filter:            uint16 Offset:
> >                         Possible values: True for high priority or False for
> >                         non-high priority
> >
> > +               string LastActivityBegin:
> > +
> > +                       Filter conversations by starting period.
> > +
> > +                       Possible values: Date in "YYYYMMDDTHHMMSS" format.
> > +
> > +               string LastActivityEnd:
> > +
> > +                       Filter conversations by ending period.
> > +
> > +                       Possible values: Date in "YYYYMMDDTHHMMSS" format.
> > +
> >  Message hierarchy
> >  =================
> >
> > --
> > 2.7.4
> >
>
>
> --
> Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
