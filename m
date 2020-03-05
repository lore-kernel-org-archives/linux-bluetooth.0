Return-Path: <SRS0=x0qO=4W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A72C3F2D2
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Mar 2020 19:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16FBD2072A
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Mar 2020 19:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mzo+Z9kt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbgCETx3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Mar 2020 14:53:29 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37572 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgCETx3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Mar 2020 14:53:29 -0500
Received: by mail-ot1-f65.google.com with SMTP id b3so93344otp.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Mar 2020 11:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rO7gpdouzEadijwOIOJCnHkimDQ32X9H1EfGtMe2aQs=;
        b=Mzo+Z9ktnuI9fEQbTxkvx9oI+2vpVZ9wRkqSY57/lkX7ggW2YD7AwaclWfDJUPQmst
         oAnMfShkP7OUiOBpu03DDXnJmLVhYJJyl6abd+BIHhVahXtz6X9aDFG3arxLAWR8wnDv
         ROXVVs+4R0s2RL0WIQ+vW/ZrXt62PZyVssmT+sgbwRnpF5Z22neCpejxdgi23esfPWcB
         atVXZXq9zm5oRTCwnMmR0K7pXaD9hlGYvSKDkH3uMDwJlaXrpq6gZjpQgud8amEvLM9r
         tV+xDlyvfO1AKzzzP48S5piRQ7xsNEkc0OdAnDD3nocd9W/SJpnzMCPMqoNYNoXG/A11
         Mmtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rO7gpdouzEadijwOIOJCnHkimDQ32X9H1EfGtMe2aQs=;
        b=I3ZIomcPVXctpTFpEMEKkNEZVsAGB+dYLNyilGS4YThMsWobbcXLJVQ17XJK2iSb0Q
         66q+0FFM46xgTLwczAkmmBGdvwmhj4oTMcZLYGT7EpmUqgPMkFint9wBgG4GP4IaUu8v
         AIlpIJhreZ6bLw1VgBo4n3aTQrvLz93SMgw6FJqv0Ty1ptfmecDqUKDx2vmz62WmMQIj
         y3vYWHLZmlG2jTY08N3UwEfxOpLkl48UC/TdDCMc7eRMOO5Q/B/VA4mNCZUOOzv8fURj
         a1z5A8JI0NokI96Ago78E7zyibaYj3ECMOw7X+9PEnEkRgV694cmkHpL2ZIXLYfLto91
         gETA==
X-Gm-Message-State: ANhLgQ3VRB9TguswcU1nVEi4DJXPICgjTUAce7NgWTxzP8DR11WcHj0Q
        71xW1yL3gAQMNsZJjspRpHNJ15s6+2WwQ+wuZ7BVInxeRcM=
X-Google-Smtp-Source: ADFU+vtpxM/1KPJsFzRThmp6a9naaPXhE/b/GjMIkolu1r8zBp1+b2+WvvzQL37luXbUpwcVWLNgnOzMOzeXn5f3pF8=
X-Received: by 2002:a05:6830:1503:: with SMTP id k3mr143333otp.28.1583438008510;
 Thu, 05 Mar 2020 11:53:28 -0800 (PST)
MIME-Version: 1.0
References: <1583398524-18749-1-git-send-email-ajay.kishore@intel.com> <1583398524-18749-6-git-send-email-ajay.kishore@intel.com>
In-Reply-To: <1583398524-18749-6-git-send-email-ajay.kishore@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 5 Mar 2020 11:53:17 -0800
Message-ID: <CABBYNZKUnVWpZxBVW12JnoY1ZV+_jwsO90+M8-kJNYjaA0kBDw@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] doc/obex-api: Update documentation
To:     Ajay Kishore <ajay.kishore@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Ajay,

On Thu, Mar 5, 2020 at 1:21 AM Ajay Kishore <ajay.kishore@intel.com> wrote:
>
> This adds documentation with the conversation listing feature
> ---
>  doc/obex-api.txt | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>
> diff --git a/doc/obex-api.txt b/doc/obex-api.txt
> index f39355a..ef81460 100644
> --- a/doc/obex-api.txt
> +++ b/doc/obex-api.txt
> @@ -712,6 +712,44 @@ Methods            void SetFolder(string name)
>                         Possible errors: org.bluez.obex.Error.InvalidArguments
>                                          org.bluez.obex.Error.Failed
>
> +               array{object, dict} ListConversations(string folder, dict filter)

If we are going to return Message1 objects this should reuse
ListMessages and then use the Type filter to specify the types of
message to list, if that is not present then it should list
everything.

> +                       Returns an array containing the conversations found in the
> +                       given subfolder of the current folder, or in the current
> +                       folder if folder is empty.
> +
> +                       Possible Filters: MaxListCount, LastActivityBegin, LastActivityEnd,
> +                       ReadStatus, Recipient
> +
> +                       Each message is represented by an object path followed
> +                       by a dictionary of the properties.
> +
> +                       Properties:
> +
> +                               string id:

Properties should use the same format as methods in D-Bus, ID might be better.

> +
> +                                       Conversation unique identification
> +
> +                               string last_activity:

LastActivity

> +                                       Conversation timestamp for the last activity
> +
> +                               string chat_state:
> +
> +                                       Conversation current chat state of the participants

ChatState

> +                               string presence_availability:
> +
> +                                       Conversation  participants availability

Presence

> +                               string presence_text:

We could reuse Subject here.

> +                                       User defined status of the conversation
> +
> +                       Possible errors: org.bluez.obex.Error.InvalidArguments
> +                                        org.bluez.obex.Error.Failed
> +
> +

I though we discussed about this but it seems that the properties here
have no relation to Message1 which appears to be the objects you are
creating so you will have to introduce these properties also in
Message1, besides we need to include a new possible value for Type
e.g. "Conversation"

>                 void UpdateInbox(void)
>
>                         Request remote to update its inbox.
> @@ -799,6 +837,18 @@ Filter:            uint16 Offset:
>                         Possible values: True for high priority or False for
>                         non-high priority
>
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
>  Message hierarchy
>  =================
>
> --
> 2.7.4
>


-- 
Luiz Augusto von Dentz
