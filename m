Return-Path: <SRS0=1j7M=2I=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F411CC43603
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Dec 2019 00:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8252218AC
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Dec 2019 00:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fIZAfbBg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbfLRAOI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Dec 2019 19:14:08 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41673 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfLRAOI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Dec 2019 19:14:08 -0500
Received: by mail-oi1-f193.google.com with SMTP id i1so143007oie.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Dec 2019 16:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nCuG6xSdV16a1lwsxarq3DmWJPgj7VjdGMseQ736R0I=;
        b=fIZAfbBgwW4hgmOwVKSLfC1JNVTTpEqP4dRGUnhZwFGqtaEH82zxeSES/RPYZ0Uo9n
         QLmSpw/eW3rN5XkpPDBxstxJYwWHuGt2eOL1zLfTeWrVqJ4f6nBX5fjd2+bx476wE+s9
         rXs/rhovw25VCANdQ1/evGzsHGaTHXHSK7dQHv0SyEihZ0ovkLVw2mMkH+Ihgx028si5
         n9kSnZY2RFvorEezIkrsHu7+nNPxpiejc6jor4L1G5el0mY+InpMm+hmlghzVlkbUpHG
         XDcwVW20MlmgK5eFJLn1YV8cHjZ2XG5zV+iNTCy+qybA/1vENWXjQY/MJSVDzqqfoISj
         +W7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nCuG6xSdV16a1lwsxarq3DmWJPgj7VjdGMseQ736R0I=;
        b=Xxxe23YfDsptYLCd27kQcKCJo4MVCTqGxtE7t17QWBQzPxPMER3cAIKW+vq3/4P7CG
         k8K/EqYRmdFRBT24ox4JY7faPkoC/iMGcC9GCJwiMTA5LFZ1NbYbw5fIKkDK52NT/WMy
         Like0zHj90sBIHkILRWNZimd1o0S2qHGckdNlomXUmlrwdAAbnjmC0/fuUCUUMfCZw7Y
         B4c6cDj8XwjWlDyeNpr4jYw1dyFRzNgrWXNX2rk/0kJG8NLePGh4kgw/ZpKfzctU9gHp
         LEDD3Ac5A8wNICA+WHjTPb9AvJNgXqw4o1t6cDdON4Mdxzc5QR+9I1ktcyXSUpAvalE0
         aJ6w==
X-Gm-Message-State: APjAAAWXfJ/cYJkVXZ4uU8UlqmDA0TG/3d/dfm5Qcr7A4hhKQqZo01fw
        h2RVIO2Jh/88BJsUyxSNzeC4GGWuL1O/uVjFf1s=
X-Google-Smtp-Source: APXvYqwVNBTehgLu60PTZP6YgTxL+6ega2oRmObjgXM71NiOdHq6orRQiu8r7fmvlAMDD/dAgoxat0iBBozy5l6RuRA=
X-Received: by 2002:aca:481:: with SMTP id 123mr34012oie.110.1576628047222;
 Tue, 17 Dec 2019 16:14:07 -0800 (PST)
MIME-Version: 1.0
References: <1576488509-26331-1-git-send-email-ajay.kishore@intel.com>
In-Reply-To: <1576488509-26331-1-git-send-email-ajay.kishore@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 17 Dec 2019 16:13:55 -0800
Message-ID: <CABBYNZLVARFpsMJsaA6aXnYZO8BD76C4WWi9zrLu5N3u=euPSg@mail.gmail.com>
Subject: Re: [PATCH 6/6] doc/obex-api: Update documentation
To:     Ajay Kishore <ajay.kishore@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Ajay,

On Mon, Dec 16, 2019 at 1:54 AM Ajay Kishore <ajay.kishore@intel.com> wrote=
:
>
> This adds documentation with the conversation listing feature
>
> Signed-off-by: Ajay Kishore <ajay.kishore@intel.com>
> ---
>  doc/obex-api.txt | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 65 insertions(+)
>
> diff --git a/doc/obex-api.txt b/doc/obex-api.txt
> index f39355a..9a76159 100644
> --- a/doc/obex-api.txt
> +++ b/doc/obex-api.txt
> @@ -712,6 +712,71 @@ Methods            void SetFolder(string name)
>                         Possible errors: org.bluez.obex.Error.InvalidArgu=
ments
>                                          org.bluez.obex.Error.Failed
>
> +
> +
> +               array{object, dict} listconversations(string folder, dict=
 filter)

It should have been ListConversations to adhere with our D-Bus APIs,
but read bellow.

> +                       Returns an array containing the conversations fou=
nd in the
> +                       given subfolder of the current folder, or in the =
current
> +                       folder if folder is empty.
> +
> +                       Possible Filters: LastActivityBegin, LastActivity=
End,
> +                       ReadStatus, Recipient

So here is the big design question, why hasn't this been done as a
filter to ListMessages? We could just have a couple of different
properties to indicate it is a conversation rather than a single
message, in any case we would need something like
org.bluez.obex.Conversation1 to enumerate these objects, something
that is not documented here.


> +
> +                       Properties:
> +
> +                               string id:
> +
> +                                       Conversation unique identificatio=
n
> +
> +                               string name:
> +
> +                                       Conversation name
> +
> +                               string last_activity:
> +
> +                                       Conversation timestamp for the la=
st activity
> +
> +                               boolean read_status:
> +
> +                                       Conversation read flag
> +
> +                               string version_counter:
> +
> +                                       128 bits version counter.
> +                                       The =E2=80=98Conversation-Listing=
 Version Counter=E2=80=99,
> +                                       =E2=80=98Conversation Version Cou=
nter=E2=80=99, and =E2=80=98Folder
> +                                       Version Counter=E2=80=99 are used=
 to detect if something
> +                                       has changed
> +
> +                               string summary:
> +
> +                                       Conversation summary
> +
> +                               string display:
> +
> +                                       Conversation participants name
> +
> +                               string chat_state:
> +
> +                                       Conversation current chat state o=
f the participants
> +
> +                               string presence_availability:
> +
> +                                       Conversation  participants availa=
bility
> +
> +                               string presence_text:
> +
> +                                       User defined status of the conver=
sation
> +
> +                               uint16 priority:
> +
> +                                       Conversation participant priority
> +
> +                       Possible errors: org.bluez.obex.Error.InvalidArgu=
ments
> +                                        org.bluez.obex.Error.Failed
> +
> +
>                 void UpdateInbox(void)
>
>                         Request remote to update its inbox.
> --
> 2.7.4
>


--=20
Luiz Augusto von Dentz
