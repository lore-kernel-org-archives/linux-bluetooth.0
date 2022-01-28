Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1760C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jan 2022 20:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245580AbiA1U2n (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Jan 2022 15:28:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbiA1U2m (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Jan 2022 15:28:42 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD66C061714
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jan 2022 12:28:42 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id i10so21888720ybt.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jan 2022 12:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JgwswYwwL7LWLnMr6AfTS4g5P9fRxg7B2atBYanU8QQ=;
        b=G0KVrLe6qGHM8B+sy/6i0X5bIWfUaYoB66CoVBNdJltJhiiaNE+8lyb0vxvFqYXHSB
         njbj712nAMGDMx7gTRGxhSSN2hAPztAtdj6gSM0+mrkEDsjLNqtWT+dE/8Bc7tCm3dLs
         oAJQIB5kIpKNLG6O8Hw9+VkkLh91AXEdmJASgwxqedSZb95LGixarkJgDceTh3NoAB5Z
         rEa4WXLEoQ6XwOtKdYLOUn9LaO0FwZTraMzpDKSgZv6Lr19WNPtJvBokfVQ4mBvBoOv1
         6apIoZbEPfKQFQsXvHXWSVja8/NOb1V+F1bnFbuD5/erk2XMfIColIjnBT7veCXHemVb
         /2OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JgwswYwwL7LWLnMr6AfTS4g5P9fRxg7B2atBYanU8QQ=;
        b=fWQSafKF+fEe7xXy//myetFX1PDyK8rpABLvyxn9slHZuLobwTpgPXAyCHghJRZS+H
         Hfdn9Gl4diLqWXzUHBvlrfjWPmGOoFgZhd2xvEr5oemEFuvMHSbq9hSSLQq9sSmmiAmA
         D5tBJBQ6TfA0HeS3Lo+1m1gHGBnnTg/I5kdHNZNbsQNbp3c046GTHqjpJtkeP/9pLB7q
         JlzOVav0yLI9xMtyz+wOYHcakq5sQTDNbmAGFzAy2Au8kOTg7tgQCRq2sQ4Sf+oIicHz
         zP+2QLySrsnV+w/Y+tRQyHrGkW2/xL9KuGGwgL22w3x08m0MZ0M/Xa6J/4vu6US4bJ5U
         1zKw==
X-Gm-Message-State: AOAM532Xsy7lT522+wIpN9E4tVkHV1hlW1y6pl6PDxcIugQEB/hjQsWb
        hcynhjoX3brW7sb58Ma6PJMceTQ69gzUGdujVjHDlnDdJxE=
X-Google-Smtp-Source: ABdhPJwvw9+is+zM1NWwsjO3AcveMFqmBTBdbJDVMVtS6UUeBrdlgcA3CID2h8t0WSzHVfcWxJo1plbVUvGBYr/aadU=
X-Received: by 2002:a25:8011:: with SMTP id m17mr14819656ybk.284.1643401721683;
 Fri, 28 Jan 2022 12:28:41 -0800 (PST)
MIME-Version: 1.0
References: <20220128020735.3779202-1-luiz.dentz@gmail.com>
 <20220128020735.3779202-2-luiz.dentz@gmail.com> <8C6BE164-39E5-4215-BF6D-4DFC9D6123D0@holtmann.org>
In-Reply-To: <8C6BE164-39E5-4215-BF6D-4DFC9D6123D0@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 28 Jan 2022 12:28:30 -0800
Message-ID: <CABBYNZKpxZDUoKz4qRXz9cmKHRxfSNRHDa3jteRrSzFAVgTjEQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] adapter: Remove custom MGMT send/reply timeout
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Fri, Jan 28, 2022 at 5:37 AM Marcel Holtmann <marcel@holtmann.org> wrote=
:
>
> Hi Luiz,
>
> > This removes the custom MGMT send/reply timeout since bt_mgmt itself
> > can handle them itself and it actually start the timer only when the
> > command is actually sent to the kernel rather then when it is queued.
> >
> > Fixes: https://github.com/bluez/bluez/issues/275
> > ---
> > src/adapter.c | 162 ++++----------------------------------------------
> > 1 file changed, 10 insertions(+), 152 deletions(-)
> >
> > diff --git a/src/adapter.c b/src/adapter.c
> > index 9772e843a..72e98ba0a 100644
> > --- a/src/adapter.c
> > +++ b/src/adapter.c
> > @@ -311,15 +311,6 @@ struct btd_adapter {
> >
> >       struct oob_handler *oob_handler;
> >
> > -     unsigned int load_ltks_id;
> > -     unsigned int load_ltks_timeout;
> > -
> > -     unsigned int confirm_name_id;
> > -     unsigned int confirm_name_timeout;
> > -
> > -     unsigned int pair_device_id;
> > -     unsigned int pair_device_timeout;
> > -
> >       unsigned int db_id;             /* Service event handler for GATT=
 db */
> >
> >       bool is_default;                /* true if adapter is default one=
 */
> > @@ -4134,21 +4125,6 @@ static void load_link_keys(struct btd_adapter *a=
dapter, GSList *keys,
> >                                                       adapter->dev_id);
> > }
> >
> > -static bool load_ltks_timeout(gpointer user_data)
> > -{
> > -     struct btd_adapter *adapter =3D user_data;
> > -
> > -     btd_error(adapter->dev_id, "Loading LTKs timed out for hci%u",
> > -                                                     adapter->dev_id);
> > -
> > -     adapter->load_ltks_timeout =3D 0;
> > -
> > -     mgmt_cancel(adapter->mgmt, adapter->load_ltks_id);
> > -     adapter->load_ltks_id =3D 0;
> > -
> > -     return FALSE;
> > -}
> > -
> > static void load_ltks_complete(uint8_t status, uint16_t length,
> >                                       const void *param, void *user_dat=
a)
> > {
> > @@ -4160,11 +4136,6 @@ static void load_ltks_complete(uint8_t status, u=
int16_t length,
> >                               adapter->dev_id, mgmt_errstr(status), sta=
tus);
> >       }
> >
> > -     adapter->load_ltks_id =3D 0;
> > -
> > -     timeout_remove(adapter->load_ltks_timeout);
> > -     adapter->load_ltks_timeout =3D 0;
> > -
> >       DBG("LTKs loaded for hci%u", adapter->dev_id);
> > }
> >
> > @@ -4237,27 +4208,13 @@ static void load_ltks(struct btd_adapter *adapt=
er, GSList *keys)
> >               }
> >       }
> >
> > -     adapter->load_ltks_id =3D mgmt_send(adapter->mgmt,
> > -                                     MGMT_OP_LOAD_LONG_TERM_KEYS,
> > -                                     adapter->dev_id, cp_size, cp,
> > -                                     load_ltks_complete, adapter, NULL=
);
> > -
> > -     g_free(cp);
> > -
> > -     if (adapter->load_ltks_id =3D=3D 0) {
> > +     if (!mgmt_send_timeout(adapter->mgmt, MGMT_OP_LOAD_LONG_TERM_KEYS=
,
> > +                     adapter->dev_id, cp_size, cp, load_ltks_complete,
> > +                     adapter, NULL, 2))
> >               btd_error(adapter->dev_id, "Failed to load LTKs for hci%u=
",
> >                                                       adapter->dev_id);
> > -             return;
> > -     }
> >
> > -     /*
> > -      * This timeout handling is needed since the kernel is stupid
> > -      * and forgets to send a command complete response. However in
> > -      * case of failures it does send a command status.
> > -      */
>
> please don=E2=80=99t loose these comments. They are important because of =
the kernel bugs we had.

Sure I will incorporate them back.

> Regards
>
> Marcel
>


--=20
Luiz Augusto von Dentz
