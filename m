Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993A7C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Feb 2022 20:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353228AbiBKUbK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Feb 2022 15:31:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353223AbiBKUbJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Feb 2022 15:31:09 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D43ACCC
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Feb 2022 12:31:07 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id p19so28330375ybc.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Feb 2022 12:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=svWzIxgxYrwtXfOQZkiVGXshlqJt3M2tGZrwZ+2yDUY=;
        b=BMLf3lHjFdWrLaEe2yNPzPTrtdxp86Hj9WL8RsTnsM7zDa71Yt1RIxN2xZBAmV3dJd
         +oB0C0P2ZGvdfdjKAQYIv3g/XroNs2FRUz6tLFZYiR3Iuk5GRe7OIIpnhGo21lzGaj9Q
         AFNtU3Fqk/RbNQwoIGkacHt3RIWypaU+0CoA054oxYOYvDKJgz2KH6QE8P0bs9KB+CGX
         L4NoK5ZJw5HGlhEsrS3ZacAl+lnNUkjRK/NBEazre0pVrsnJNb4AnAZri99A6Q6VQ9HM
         qEbhArzoVWiOxYeOJNdgq3AHOPsNaXSZ33IvltX+o2yJVeR+tPtn7CTyeVDB3PP3LcEI
         3rfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=svWzIxgxYrwtXfOQZkiVGXshlqJt3M2tGZrwZ+2yDUY=;
        b=C94KWzt6KsGkMtewLGvFVvxzcGN8y8RxGtiTJS4GAHR2uvWGdEj7huzWnmdpTjd3ek
         T82z8kf4nwePe9ypJv7itYenMlbRtdIEePWbcXR+Z/oZnptj4sZ0+MxdxVsXrWJwXJci
         +R9xSDHuk6puSVNioalQ+aooDVX1oy84rFDH90h+zuETV+TGOTTYFhOP5sRDNE0FUhWk
         6LUjyrgn93Mftb8ixQJlNFPvhVoouLy8MKYHy+2X7xpFnxfi86so65PUTGgextvG4rFp
         qUfQFP3ps5gsyxTAFuCSS9LapLwrqHnEpDPsEcp2Qco3Iobuylt61A4qgPWNiAFWe2YX
         EoGw==
X-Gm-Message-State: AOAM531NS6p31IN19HXpWLg+qFisTSOCPD4dFTaWzV7SAteK1dRq1C8R
        D+i3RM9gONBP6NmDWcN91q7cTYO7BkoD7BL4yCI=
X-Google-Smtp-Source: ABdhPJy8cZx7ByXb+2dRSdz5hLXHH2qEfI8/N5vPevjgdh35XFMNaodg+yaycP225kzM3FIxrwkMgfnpFP64snZbvpU=
X-Received: by 2002:a25:b310:: with SMTP id l16mr3112111ybj.752.1644611466257;
 Fri, 11 Feb 2022 12:31:06 -0800 (PST)
MIME-Version: 1.0
References: <20220211001840.22566-1-hj.tedd.an@gmail.com> <fdaaf4ca-934f-c0ff-63f8-2feda6a106ef@molgen.mpg.de>
In-Reply-To: <fdaaf4ca-934f-c0ff-63f8-2feda6a106ef@molgen.mpg.de>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 11 Feb 2022 12:30:55 -0800
Message-ID: <CABBYNZJ4ZByGjHFmXwzC6UYJNGBQ4GfOLP56BVT6jdyaHA6qKg@mail.gmail.com>
Subject: Re: [BlueZ PATCH 1/4] adapter: Fix the reusing gerror without re-initialization
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Paul,

On Fri, Feb 11, 2022 at 8:41 AM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Dear Tedd,
>
>
> Am 11.02.22 um 01:18 schrieb Tedd Ho-Jeong An:
> > From: Tedd Ho-Jeong An <tedd.an@intel.com>
>
> I had a hard time to understand, what the git commit message summary
> meant. Maybe:
>
> > adapter: Use g_clear_error() to set gerr to NULL to fix segfault
>
>
> > When the GError variable is freeed with g_error_free(), it is not set to
> > NULL and reusing the same variable again can cause the seg_fault because
> > it is still pointing the old memory address which is freed.
>
> Could you please include an example stack-/backtrace?

That is part of issue if you open the link:

https://github.com/bluez/bluez/issues/276#issue-1111278644

> > This patch relaces the g_error_free() to g_clear_error() which frees the
> > variable and set it to NULL if the variable is used in the function
>
> set*s*
>
> > again.
> >
> > Fixes: 2287c517ca1bd ("adapter: Fix unchecked return value")
> > Fixes: https://github.com/bluez/bluez/issues/276
>
> To make the tags unambiguous, at least in the Linux kernel world,
> *Resolves* or *Closes* are used to refer to issues.

But this is on kernel space, and afaik github uses *Fixes* instead to
auto close the issues, so I don't really follow what you are trying to
suggest here, or do you want github to start following Linux kernel
tags?

>
> Kind regards,
>
> Paul
>
>
> > ---
> >   src/adapter.c | 34 +++++++++++++++++-----------------
> >   1 file changed, 17 insertions(+), 17 deletions(-)
> >
> > diff --git a/src/adapter.c b/src/adapter.c
> > index 3ee98431d..eef50f67a 100644
> > --- a/src/adapter.c
> > +++ b/src/adapter.c
> > @@ -4676,7 +4676,7 @@ static void load_devices(struct btd_adapter *adapter)
> >               if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
> >                       error("Unable to load key file from %s: (%s)", filename,
> >                                                               gerr->message);
> > -                     g_error_free(gerr);
> > +                     g_clear_error(&gerr);
> >               }
> >
> >               key_info = get_key_info(key_file, entry->d_name);
> > @@ -5662,7 +5662,7 @@ static void convert_names_entry(char *key, char *value, void *user_data)
> >       if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
> >               error("Unable to load key file from %s: (%s)", filename,
> >                                                               gerr->message);
> > -             g_error_free(gerr);
> > +             g_clear_error(&gerr);
> >       }
> >       g_key_file_set_string(key_file, "General", "Name", value);
> >
> > @@ -5895,7 +5895,7 @@ static void convert_entry(char *key, char *value, void *user_data)
> >       if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
> >               error("Unable to load key file from %s: (%s)", filename,
> >                                                               gerr->message);
> > -             g_error_free(gerr);
> > +             g_clear_error(&gerr);
> >       }
> >
> >       set_device_type(key_file, type);
> > @@ -6001,7 +6001,7 @@ static void store_sdp_record(char *local, char *peer, int handle, char *value)
> >       if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
> >               error("Unable to load key file from %s: (%s)", filename,
> >                                                               gerr->message);
> > -             g_error_free(gerr);
> > +             g_clear_error(&gerr);
> >       }
> >
> >       sprintf(handle_str, "0x%8.8X", handle);
> > @@ -6085,7 +6085,7 @@ static void convert_sdp_entry(char *key, char *value, void *user_data)
> >       if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
> >               error("Unable to load key file from %s: (%s)", filename,
> >                                                               gerr->message);
> > -             g_error_free(gerr);
> > +             g_clear_error(&gerr);
> >       }
> >
> >       store_attribute_uuid(key_file, start, end, prim_uuid, uuid);
> > @@ -6145,7 +6145,7 @@ static void convert_primaries_entry(char *key, char *value, void *user_data)
> >       if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
> >               error("Unable to load key file from %s: (%s)", filename,
> >                                                               gerr->message);
> > -             g_error_free(gerr);
> > +             g_clear_error(&gerr);
> >       }
> >
> >       for (service = services; *service; service++) {
> > @@ -6170,7 +6170,7 @@ static void convert_primaries_entry(char *key, char *value, void *user_data)
> >       if (!g_file_set_contents(filename, data, length, &gerr)) {
> >               error("Unable set contents for %s: (%s)", filename,
> >                                                               gerr->message);
> > -             g_error_free(gerr);
> > +             g_clear_error(&gerr);
> >       }
> >
> >       if (device_type < 0)
> > @@ -6185,7 +6185,7 @@ static void convert_primaries_entry(char *key, char *value, void *user_data)
> >       if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
> >               error("Unable to load key file from %s: (%s)", filename,
> >                                                               gerr->message);
> > -             g_error_free(gerr);
> > +             g_clear_error(&gerr);
> >       }
> >       set_device_type(key_file, device_type);
> >
> > @@ -6241,7 +6241,7 @@ static void convert_ccc_entry(char *key, char *value, void *user_data)
> >       if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
> >               error("Unable to load key file from %s: (%s)", filename,
> >                                                               gerr->message);
> > -             g_error_free(gerr);
> > +             g_clear_error(&gerr);
> >       }
> >
> >       sprintf(group, "%hu", handle);
> > @@ -6297,7 +6297,7 @@ static void convert_gatt_entry(char *key, char *value, void *user_data)
> >       if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
> >               error("Unable to load key file from %s: (%s)", filename,
> >                                                               gerr->message);
> > -             g_error_free(gerr);
> > +             g_clear_error(&gerr);
> >       }
> >
> >       sprintf(group, "%hu", handle);
> > @@ -6352,7 +6352,7 @@ static void convert_proximity_entry(char *key, char *value, void *user_data)
> >       if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
> >               error("Unable to load key file from %s: (%s)", filename,
> >                                                               gerr->message);
> > -             g_error_free(gerr);
> > +             g_clear_error(&gerr);
> >       }
> >
> >       g_key_file_set_string(key_file, alert, "Level", value);
> > @@ -6556,7 +6556,7 @@ static void load_config(struct btd_adapter *adapter)
> >       if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
> >               error("Unable to load key file from %s: (%s)", filename,
> >                                                               gerr->message);
> > -             g_error_free(gerr);
> > +             g_clear_error(&gerr);
> >       }
> >
> >       /* Get alias */
> > @@ -8313,7 +8313,7 @@ static void store_ltk_group(struct btd_adapter *adapter, const bdaddr_t *peer,
> >       if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
> >               error("Unable to load key file from %s: (%s)", filename,
> >                                                               gerr->message);
> > -             g_error_free(gerr);
> > +             g_clear_error(&gerr);
> >       }
> >
> >       for (i = 0; i < 16; i++)
> > @@ -8479,7 +8479,7 @@ static void store_csrk(struct btd_adapter *adapter, const bdaddr_t *peer,
> >       if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
> >               error("Unable to load key file from %s: (%s)", filename,
> >                                                               gerr->message);
> > -             g_error_free(gerr);
> > +             g_clear_error(&gerr);
> >       }
> >
> >       for (i = 0; i < 16; i++)
> > @@ -8657,7 +8657,7 @@ static void store_conn_param(struct btd_adapter *adapter, const bdaddr_t *peer,
> >       if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
> >               error("Unable to load key file from %s: (%s)", filename,
> >                                                               gerr->message);
> > -             g_error_free(gerr);
> > +             g_clear_error(&gerr);
> >       }
> >
> >       g_key_file_set_integer(key_file, "ConnectionParameters",
> > @@ -9316,7 +9316,7 @@ static void remove_keys(struct btd_adapter *adapter,
> >       if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
> >               error("Unable to load key file from %s: (%s)", filename,
> >                                                               gerr->message);
> > -             g_error_free(gerr);
> > +             g_clear_error(&gerr);
> >       }
> >
> >       if (type == BDADDR_BREDR) {
> > @@ -9418,7 +9418,7 @@ static bool get_static_addr(struct btd_adapter *adapter)
> >                                                               &gerr)) {
> >               error("Unable to load key file from %s: (%s)",
> >                                       STORAGEDIR "/addresses", gerr->message);
> > -             g_error_free(gerr);
> > +             g_clear_error(&gerr);
> >       }
> >       addrs = g_key_file_get_string_list(file, "Static", mfg, &len, NULL);
> >       if (addrs) {



-- 
Luiz Augusto von Dentz
