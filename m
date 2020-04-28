Return-Path: <SRS0=u/yl=6M=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE9BC83008
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Apr 2020 17:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09B6920730
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Apr 2020 17:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/nzFraC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbgD1RDy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Apr 2020 13:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728089AbgD1RDy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Apr 2020 13:03:54 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0B3C03C1AB
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2020 10:03:52 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id x16so4832222oop.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2020 10:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5M444tclZawM7upB1rZ/qYGvZILyeIol7YUbX9ylAfc=;
        b=U/nzFraCx/J8Ag9joaOzSggHNcrD9dULyRyUe2j04/UQdrT5iyoL4ETLaJsntkx4Ax
         UFXUedXd55TWwpkcMgSy3kSJavCfo6dpi66yVfmGTagf9MVpx4Jx7Z3sbSiegnnRrwGZ
         ZIub0AtrltqXC1v1WLP2ofxWRD0RqoIyXJJb48ElhOM8aS1jTcj0nPweLjY8X8ZDSWEw
         zCGYYrzRfF3R9mZMIdQj0e99akDHXj/6leFEH+uhcrh8wnnDm221m1xiTxJqbOCatSQ7
         FeKomO30Yb9GMyCyd0gjIt6bKg9K2Lhrh6gFHdFv9rd82M5YPaZNYS4Rte8I6Wp4ZBe2
         igxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5M444tclZawM7upB1rZ/qYGvZILyeIol7YUbX9ylAfc=;
        b=syp5RWQFfKOnODpePjgsNMBKE4o+XfmKSttPUp4I/cUO+eMviddQVXCJXPIPvNRRHq
         K0U5GNcj29adKfsXQC7X0lvfCfrMiz8SuAbnBiAJXFg/cuZBMHaAhUNPy5fU+USUzjYl
         wNQNH+n6U6Tyf5ab78i64SAuoYhmgAwmuczjpqQcxOHQQ55QLQWqhAWM0r4aBtCbCLn6
         xtNjpDG7dWsR3nG5Oux0pVSPShteHPFhrI90YiNYv1kEymUyvdS3ywaqOPVvF+cZEqsm
         lkmWD82C5pyVE24ckVK4M5DnF+36NLLKmIlkZzzm925ggc5b8NVqYNssR0K02lMdze/P
         X3GA==
X-Gm-Message-State: AGi0PubV9opEmeR4+0A636Nb7Xy1Y7QL6m5ToXw6ND+I94lkxapLwoc0
        Lziw6ea3ehIFEr6brpJdwILaQeSDXawcsngWyp29XMvG
X-Google-Smtp-Source: APiQypKqsJqUiDC3SoxJz3OaHSzCjJabff5lYILLdF+7AjjcM/OiKRqaciXsI6zm3SnTPrvQ68GZUkBpN5yaQ1TWF80=
X-Received: by 2002:a4a:9285:: with SMTP id i5mr2476774ooh.50.1588093431955;
 Tue, 28 Apr 2020 10:03:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200427150153.17055-1-david@lechnology.com> <CABBYNZKhVUqLortqL60CNtu0MZBdtW+qqdtn6zfacOVKDezYxQ@mail.gmail.com>
 <35f37936-e737-ac35-c538-9447a00d1cbc@lechnology.com>
In-Reply-To: <35f37936-e737-ac35-c538-9447a00d1cbc@lechnology.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 28 Apr 2020 10:03:40 -0700
Message-ID: <CABBYNZKYXjKDb77988uFE6hQvW-R2es=Y4rZfNML9zFciOmuRg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2] src/gatt-client: always check properties in WriteValue
To:     David Lechner <david@lechnology.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi David,

On Tue, Apr 28, 2020 at 7:39 AM David Lechner <david@lechnology.com> wrote:
>
> On 4/27/20 11:28 AM, Luiz Augusto von Dentz wrote:
> > Hi David,
> >
> > On Mon, Apr 27, 2020 at 8:07 AM David Lechner <david@lechnology.com> wrote:
> >>
> >> This modifies the GATT client characteristic WriteValue D-Bus method to
> >> always check that the characteristic supports the requested type of
> >> write by checking for the corresponding property before attempting to
> >> write.
> >>
> >> Before this change, if the "type" option was used and it was set to
> >> "reliable" or "request", then BlueZ would attempt the write even if the
> >> characteristic does not support that write type. On the other hand, if
> >> "type" was set to "command" or was not specified, the method would
> >> return a org.bluez.Error.NotSupported error without attempting to write.
> >>
> >> After this change, the WriteValue method will consistently return
> >> org.bluez.Error.NotSupported if the corresponding property flag is not
> >> set for all types of writes.
> >> ---
> >>
> >> v2 changes:
> >> - remove extra check of test variable not NULL
> >> - fix one line over 80 chars
> >>
> >>   src/gatt-client.c | 8 ++++----
> >>   1 file changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/src/gatt-client.c b/src/gatt-client.c
> >> index a9bfc2802..f80742fbb 100644
> >> --- a/src/gatt-client.c
> >> +++ b/src/gatt-client.c
> >> @@ -1016,8 +1016,8 @@ static DBusMessage *characteristic_write_value(DBusConnection *conn,
> >>           *     - If value is larger than MTU - 3: long-write
> >>           *   * "write-without-response" property set -> write command.
> >>           */
> >> -       if ((!type && (chrc->ext_props & BT_GATT_CHRC_EXT_PROP_RELIABLE_WRITE))
> >> -                       || (type && !strcasecmp(type, "reliable"))) {
> >> +       if ((!type || !strcasecmp(type, "reliable")) && chrc->ext_props &
> >> +                               BT_GATT_CHRC_EXT_PROP_RELIABLE_WRITE) {
> >>                  supported = true;
> >>                  chrc->write_op = start_long_write(msg, chrc->value_handle, gatt,
> >>                                                  true, value, value_len, offset,
> >> @@ -1026,8 +1026,8 @@ static DBusMessage *characteristic_write_value(DBusConnection *conn,
> >>                          return NULL;
> >>          }
> >>
> >> -       if ((!type && chrc->props & BT_GATT_CHRC_PROP_WRITE) ||
> >> -                       (type && !strcasecmp(type, "request"))) {
> >> +       if ((!type || !strcasecmp(type, "request")) && chrc->props &
> >> +                                               BT_GATT_CHRC_PROP_WRITE) {
> >>                  uint16_t mtu;
> >>
> >>                  supported = true;
> >> --
> >> 2.17.1
> >
> > As far I can remember this is on purpose so the application can
> > overwrite the type if it needs to disabling the checks on the client
> > side, though the kernel can still return not supported, so if we want
> > to change this it will now not be possible to overwrite it anymore.
> >
>
> If this is the case, does it make sense to make the following change
> instead so that write without response can also be forced?
>
> diff --git a/src/gatt-client.c b/src/gatt-client.c
> index f80742fbb..3153f571f 100644
> --- a/src/gatt-client.c
> +++ b/src/gatt-client.c
> @@ -1050,8 +1050,8 @@ static DBusMessage *characteristic_write_value(DBusConnection *conn,
>                          return NULL;
>          }
>
> -       if ((type && strcasecmp(type, "command")) || offset ||
> -                       !(chrc->props & BT_GATT_CHRC_PROP_WRITE_WITHOUT_RESP))
> +       if ((type && strcasecmp(type, "command")) || offset || (!type &&
> +                       !(chrc->props & BT_GATT_CHRC_PROP_WRITE_WITHOUT_RESP)))
>                  goto fail;
>
>          supported = true;

Yes, that is probably one of the use cases to use the type to force
sending a command if the client don't care about the response but the
server don't mark write without response as supported, is that what
you are after? That sounds like a bug since it appears the intention
was to allow commands all along.

-- 
Luiz Augusto von Dentz
