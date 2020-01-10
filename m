Return-Path: <SRS0=nFDS=27=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA93BC282DD
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Jan 2020 15:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CF432080D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Jan 2020 15:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KuxypsG4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbgAJP5a (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Jan 2020 10:57:30 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37347 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728356AbgAJP5a (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Jan 2020 10:57:30 -0500
Received: by mail-lf1-f68.google.com with SMTP id b15so1847825lfc.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jan 2020 07:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GQrELnWaNkbLnu7iUJ4jRMfQ2doTqb0e3TTzK7hz9X4=;
        b=KuxypsG4o0WYLvoHQOJip6c+rFCPX4sH8OYCDw3WJw9xXNFtNvz/++UCftS/ouRJhV
         4izxEUiSMenhA/VWkeNmdv2L9CIsoXT5xuWhpb4pAElQ4zDL4TVhKV4qsMrCNcPg0bMo
         SBZXk+Gdznqu/gjQlpouDD0VFibQQilhWR+n1FnYmWHffIzaWSvzaZA+gMa0D74BzLU/
         WEXBw6Y7m/NBwlmMyyM+BEH4fHdNTS+cJNo1BAvtTLNtsPKNAFpIfRvzbu11VeKK19WY
         ts3Y5qmglNnG0Jv8qEJuLcP7c8OtInooSq+j0mBwIgD10K+wV8+YgpuaYAUTpFwOLyZt
         TVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GQrELnWaNkbLnu7iUJ4jRMfQ2doTqb0e3TTzK7hz9X4=;
        b=kUu1dj4N77j2E5WLJwQzEMYVpf+8n6XtiAk3Le5l43RUCepMjZdHllfIU821xIjdw+
         x6TE/PcgLCWRk1UphWW2sKqGnwAYiPML5VHvO1W8zg972dh9XFimMhHoYoVTR0GhuKiR
         rzDMMdo6o83eSi06jOA53nKU3mVNtnaSg47fQ8ja61gqrcabNhpMa5onhGtOo4F6tFtD
         hoO3VR5dALk64wqDkKMx0JepjzwJx7mwV+PEbSJrT3EXzSWboiTJmiDSibyGIHMwmu9n
         HrWPImjAW0mf8Q8ALAeiF2fC50p/B7UEmnOY+iyyPgqM1Sd+Ha5bKwfTlcM/Ao+tucHr
         oAOQ==
X-Gm-Message-State: APjAAAUDikC2WiAB7P6lGdf7lTia4XM4EJpJDAPj5bwXYv6qMqoUbP6r
        VOqla3aMZNczZbYNNim3G6MfrgD8fndjbNemUoUddBX+
X-Google-Smtp-Source: APXvYqx/Ly4JJSZbrhT2boSTdOUr1MtOkdN07Y3TrjYoCniz4L6CVJu1iucsxGA5nwtLIvrBUjOA2lzyE3mxcQcZH40=
X-Received: by 2002:ac2:5a09:: with SMTP id q9mr2779043lfn.71.1578671847105;
 Fri, 10 Jan 2020 07:57:27 -0800 (PST)
MIME-Version: 1.0
References: <1577163782-28759-1-git-send-email-ajay.kishore@intel.com> <1577163782-28759-2-git-send-email-ajay.kishore@intel.com>
In-Reply-To: <1577163782-28759-2-git-send-email-ajay.kishore@intel.com>
From:   Matias Karhumaa <matias.karhumaa@gmail.com>
Date:   Fri, 10 Jan 2020 17:57:16 +0200
Message-ID: <CAMCGoNydF4WNNDj6Egoz0MBnXVjr+bFKUY54gLHX+0LErHwOTQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] doc/obex-api: Update documentation
To:     Ajay Kishore <ajay.kishore@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Ajay,

ti 24. jouluk. 2019 klo 7.29 Ajay Kishore (ajay.kishore@intel.com) kirjoitti:
>
> This adds documentation with the conversation listing feature
>
> Signed-off-by: Ajay Kishore <ajay.kishore@intel.com>
Signed-off-by isn't necessary for Bluez patches.

> ---
>  doc/obex-api.txt | 94 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 94 insertions(+)
>
> diff --git a/doc/obex-api.txt b/doc/obex-api.txt
> index f39355a..8f27b40 100644
> --- a/doc/obex-api.txt
> +++ b/doc/obex-api.txt
> @@ -892,3 +892,97 @@ Properties string Folder [readonly]
>                 boolean Protected [readonly]
>
>                         Message protected flag
> +
> +Conversation Access hierarchy
> +==============================
> +
> +Service                org.bluez.obex
> +Interface      org.bluez.obex.Conversation1
> +Object path    [Session object path]
> +
> +Methods                array{object, dict} ListConversations(string folder, dict filter)
I think this does not quite match the implementation. I think
ListConversation belongs to MessageAccess1 interface. Conversation1
interface has similar method than Message1 interface.

> +                       Returns an array containing the conversations found in the
> +                       given subfolder of the current folder, or in the current
> +                       folder if folder is empty.
> +
> +                       Possible Filters: MaxListCount, LastActivityBegin, LastActivityEnd,
> +                       ReadStatus, Recipient
> +
> +               Properties:
> +                       string id:
> +
> +                               Conversation unique identification
> +
> +                       string name:
> +
> +                               Conversation name
> +
> +                       string last_activity:
> +
> +                               Conversation timestamp for the last activity
> +
> +                       boolean read_status:
> +
> +                               Conversation read flag
> +
> +                       string version_counter:
> +
> +                               128 bits version counter.
> +                               The 'Conversation-Listing Version Counter',
> +                               'Conversation Version Counter', and 'Folder
> +                               Version Counter' are used to detect if something
> +                               has changed
> +
> +                       string summary:
> +
> +                               Conversation summary
> +
> +                       string display:
> +
> +                               Conversation participants name
> +
> +                       string chat_state:
> +
> +                               Conversation current chat state of the participants
> +
> +                       string presence_availability:
> +
> +                               Conversation  participants availability
> +
> +                       string presence_text:
> +
> +                               User defined status of the conversation
> +
> +                       uint16 priority:
> +
> +                               Conversation participant priority
> +
> +               Possible errors: org.bluez.obex.Error.InvalidArguments
> +                                org.bluez.obex.Error.Failed
> +
> +
> +Filter:                uint16 MaxListCount:
Shouldn't this be MaxCount?

> +
> +                       Maximum number of items in the conversations.
> +
> +               string LastActivityBegin:
> +
> +                       Filter conversations by starting period.
> +
> +                       Possible values: Date in "YYYYMMDDTHHMMSS" format.
> +
> +               string LastActivityEnd:
> +
> +                       Filter conversations by ending period.
> +
> +                       Possible values: Date in "YYYYMMDDTHHMMSS" format.
> +
> +               boolean ReadStatus:
> +
> +                       Filter converstions by read flag.
> +
> +                       Possible values: True for read or False for unread
> +
> +               string Recipient:
> +
> +                       Filter conversations by conversation-recipient.
> --
> 2.7.4
>

Best regards,
Matias Karhumaa
