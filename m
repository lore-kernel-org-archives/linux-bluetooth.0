Return-Path: <SRS0=BBV2=6L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A06B5C54FD0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Apr 2020 16:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AD8C2051A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Apr 2020 16:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7GZJ4PC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgD0Q2u (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Apr 2020 12:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728038AbgD0Q2t (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Apr 2020 12:28:49 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7954C0610D5
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2020 09:28:49 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id b13so27242672oti.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2020 09:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rkBPoDsQWTBMo43NQ1pecvSWxrJDTnHCWbFEASyCWt8=;
        b=j7GZJ4PCtUwMyqvMyAW0KSox1zu8la1WrVTaKUuCkdZ89gZ/Spk60SiOsO1eBMe4YM
         sMbvwI4fBumEMuTMwTdWq2t51RfaBrQ+y+IqMzUNS/XsSFVto6ZqeQdXhxfagTGpCgbe
         iavtXt7xdVex750Zzwi0DBIHi8CVNguCzmvU1LbDtCrYfXVasVPjg6Y3oMHIj9N8T923
         iU4WTZwufOwiond4tEFQKvXaXXc4GjVC1x9HMHZr9ZHtgMrzO4cgGGXBUDZlTYbJlEAc
         qX82Hr6XQyq8GkCG0JdeO8H1YGrTHfZYzgoX+L676vimuM7dLqC6ArIM+P/oA/05/nLU
         pwkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rkBPoDsQWTBMo43NQ1pecvSWxrJDTnHCWbFEASyCWt8=;
        b=YGnEdUVdydKQBvzNsLOntSu2nlFxSCDl7x5BkUDHhP9JLBu6y/bo5oL2nljy34B8mU
         +1GpVuDzuJUiBJxTTNEW8FPGepK72rtqn1uNGn3yJdrIWiMq3aUTMVCXRvEilVw31WWx
         uyvo+lrx8vdzmf+gL5MfqKj6h7cwv1FbU0Eu/GqvWYe5Bqb6tpOA8rmZR0RJfjL+RCm8
         HAPKWDNH9YTav839STp/lIB0idDrrltcYl4TJsbP0OYCCGWFj+NsHziPaKPdo/LftOy/
         RrRWiFN4Dkt+6bKV2RFhMKC2dvN3KdFd68VzURIuUZxTCxSFndTd9CKlcU9nmlfvRIdn
         Gczg==
X-Gm-Message-State: AGi0PuYmFekYNrOGsSX8CUkjVzYi5nv2IsbbVfX0xW6Pu5SoVZS8XtTD
        IkBMM5wqtXU140RK9hvjudQUjtDKbnLFZLCiGGIA8VMP
X-Google-Smtp-Source: APiQypK7tiW84pAUkFl1WmZgiM6sRKmsQig8uT6At69lrNoj+6d0tGTSpTGlEcbuqxqZHSpP6kc0jeujs2QlmaI74zg=
X-Received: by 2002:a9d:7244:: with SMTP id a4mr6345297otk.177.1588004929145;
 Mon, 27 Apr 2020 09:28:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200427150153.17055-1-david@lechnology.com>
In-Reply-To: <20200427150153.17055-1-david@lechnology.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 27 Apr 2020 09:28:37 -0700
Message-ID: <CABBYNZKhVUqLortqL60CNtu0MZBdtW+qqdtn6zfacOVKDezYxQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2] src/gatt-client: always check properties in WriteValue
To:     David Lechner <david@lechnology.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi David,

On Mon, Apr 27, 2020 at 8:07 AM David Lechner <david@lechnology.com> wrote:
>
> This modifies the GATT client characteristic WriteValue D-Bus method to
> always check that the characteristic supports the requested type of
> write by checking for the corresponding property before attempting to
> write.
>
> Before this change, if the "type" option was used and it was set to
> "reliable" or "request", then BlueZ would attempt the write even if the
> characteristic does not support that write type. On the other hand, if
> "type" was set to "command" or was not specified, the method would
> return a org.bluez.Error.NotSupported error without attempting to write.
>
> After this change, the WriteValue method will consistently return
> org.bluez.Error.NotSupported if the corresponding property flag is not
> set for all types of writes.
> ---
>
> v2 changes:
> - remove extra check of test variable not NULL
> - fix one line over 80 chars
>
>  src/gatt-client.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/src/gatt-client.c b/src/gatt-client.c
> index a9bfc2802..f80742fbb 100644
> --- a/src/gatt-client.c
> +++ b/src/gatt-client.c
> @@ -1016,8 +1016,8 @@ static DBusMessage *characteristic_write_value(DBusConnection *conn,
>          *     - If value is larger than MTU - 3: long-write
>          *   * "write-without-response" property set -> write command.
>          */
> -       if ((!type && (chrc->ext_props & BT_GATT_CHRC_EXT_PROP_RELIABLE_WRITE))
> -                       || (type && !strcasecmp(type, "reliable"))) {
> +       if ((!type || !strcasecmp(type, "reliable")) && chrc->ext_props &
> +                               BT_GATT_CHRC_EXT_PROP_RELIABLE_WRITE) {
>                 supported = true;
>                 chrc->write_op = start_long_write(msg, chrc->value_handle, gatt,
>                                                 true, value, value_len, offset,
> @@ -1026,8 +1026,8 @@ static DBusMessage *characteristic_write_value(DBusConnection *conn,
>                         return NULL;
>         }
>
> -       if ((!type && chrc->props & BT_GATT_CHRC_PROP_WRITE) ||
> -                       (type && !strcasecmp(type, "request"))) {
> +       if ((!type || !strcasecmp(type, "request")) && chrc->props &
> +                                               BT_GATT_CHRC_PROP_WRITE) {
>                 uint16_t mtu;
>
>                 supported = true;
> --
> 2.17.1

As far I can remember this is on purpose so the application can
overwrite the type if it needs to disabling the checks on the client
side, though the kernel can still return not supported, so if we want
to change this it will now not be possible to overwrite it anymore.

-- 
Luiz Augusto von Dentz
