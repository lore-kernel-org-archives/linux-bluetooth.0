Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BA1C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Apr 2022 20:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392575AbiDUUzp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Apr 2022 16:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392576AbiDUUzn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Apr 2022 16:55:43 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6544EA0A
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Apr 2022 13:52:52 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id w194so6872108oiw.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Apr 2022 13:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E1pw43PPby1af/FatofrAqvya9F5/rju3G/L3DZ5IRI=;
        b=h9S5NBFq20hk5/mmFbZAEea8rLFsBbZyKNzFdAZzXDw6HAOf8j979B13PQfEhCQJGu
         ATXJ6RPtVTm0a5ZlEkE1+37cC7AE4DkcLeEkoyqJhWhrSTiYI8bE0iC5pXpWA8okLZtY
         ArXf1Kyh9tbW7r0Nl+sIXf/Bvzg5ILnzQosHSTZBL6ttmbWcAmRf02J0V153uKbhLlaV
         /YUoX5KGqd0sYOewziulm9Lkfv8gmjpdKPB8WcWQPnZlwzR1yn3cUb9FqzvgMxl4NW/U
         SqCgQlD4dWeexaTTjNIr7YGvXFHQ4I/SJfxpF2A0B7qkM1EA6XopVTYf2wjgxK+kvx3c
         L4DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E1pw43PPby1af/FatofrAqvya9F5/rju3G/L3DZ5IRI=;
        b=TxYMToUVIxuZTKa+lCCLwEE1td6DCDHcQosVXulKYJEeuELtxkRtRR2qP3yulzfKhq
         +xjkqiRRdOdG5n1rXeEVnCYh8YhlHMzr+QBmkc3gdqmyXA1ZCDjEKIejhXY2VB7p1p2Y
         52QnraA3TEeXbHPQSU3VVQQvhJ4dLLy0p6/TslarLdwg8SG+RIeHkGLI1RdcVEo8xy3U
         5BtxT5KS57QMR4RAmzE/+JKuIbhTVIbn/vSMrEX3lQPCp3ZWuSsllJm1If89bb/gUXZj
         7SlV4vMeU2jaES5GnhO03gSpOvpSUDE/iS9OGwHQ5jTrfocGAIJXqKpbVo8drDCVNSKV
         8I0g==
X-Gm-Message-State: AOAM530SmKBeEsj5Y95o6LGcTwCHps0t0sWGAmD2qaIdQS7oUWhD88cl
        jIkCX6gjVUTWcQCoyMjWh4J1WFxtRxRACxRAl2tysSAl
X-Google-Smtp-Source: ABdhPJyKy8woHAd6enKAQBbju+oKaKH8npB84PXCPOu+XaeblOhIRk7gT2ZGDm7AX7BmglAlirDlq2ZXZEdkSFRjEMY=
X-Received: by 2002:a05:6808:15a7:b0:322:be0d:556a with SMTP id
 t39-20020a05680815a700b00322be0d556amr739390oiw.85.1650574372239; Thu, 21 Apr
 2022 13:52:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220420221433.2933868-1-luiz.dentz@gmail.com> <654FF692-95EB-459A-9144-62EA911C7BBB@holtmann.org>
In-Reply-To: <654FF692-95EB-459A-9144-62EA911C7BBB@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 21 Apr 2022 13:52:40 -0700
Message-ID: <CABBYNZKZB3Xv0z+KdV2nBmV0YXK_e0anSD0oxpNKJ68C1tWQYg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_event: Fix checking for invalid handle on
 error status
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Thu, Apr 21, 2022 at 8:57 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Luiz,
>
> > Commit d5ebaa7c5f6f6 introduces checks for handle range
> > (e.g HCI_CONN_HANDLE_MAX) but controllers don't seem to respect the
> > valid range int case of error status:
> >
> >> HCI Event: Connect Complete (0x03) plen 11
> >        Status: Page Timeout (0x04)
> >        Handle: 65535
> >        Address: 94:DB:56:XX:XX:XX (Sony Home Entertainment&
> >       Sound Products Inc)
> >        Link type: ACL (0x01)
> >        Encryption: Disabled (0x00)
> > [1644965.827560] Bluetooth: hci0: Ignoring HCI_Connection_Complete for
> > invalid handle
>
> so the problem is that with BR/EDR the lookup is by BD_ADDR. I think the check for valid handle is wrong at the beginning of connect complete handler.
>
> The problem is really the fact the we trying a big hammer at the beginning. The hci_conn_add in case of auto-connect should validate status and handle. We are not even validating the status right now assuming we always get a status == 0 on auto-connect.

Ive sent a separate patch addressing the use of hci_conn_add on error
status, in some places we did it properly but others didn't so it
would result in hci_conn object being created just to be freed later
at the same function.

> The second handle validation should only occur if we have !status in the bottom half of that function.

Send a v2 checking the handle just before assigning it to hci_conn object.

>
> > Because of it is impossible to cleanup the connections properly since
> > the stack would attempt to cancel the connection which is no longer in
> > progress causing the following trace:
> >
> > < HCI Command: Create Connection Cancel (0x01|0x0008) plen 6
> >        Address: 94:DB:56:XX:XX:XX (Sony Home Entertainment&
> >       Sound Products Inc)
> > = bluetoothd: src/profile.c:record_cb() Unable to get Hands-Free Voice
> >       gateway SDP record: Connection timed out
> >> HCI Event: Command Complete (0x0e) plen 10
> >      Create Connection Cancel (0x01|0x0008) ncmd 1
> >        Status: Unknown Connection Identifier (0x02)
> >        Address: 94:DB:56:XX:XX:XX (Sony Home Entertainment&
> >       Sound Products Inc)
> > < HCI Command: Create Connection Cancel (0x01|0x0008) plen 6
> >        Address: 94:DB:56:XX:XX:XX (Sony Home Entertainment&
> >       Sound Products Inc)
>
> Can we get details about which controller uses 0xffff instead of 0 for the handle?
>
> >
> > Fixes: d5ebaa7c5f6f6 ("Bluetooth: hci_event: Ignore multiple conn complete events")
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> > net/bluetooth/hci_event.c | 6 +++---
> > 1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index abaabfae19cc..1cc5a712459e 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -3068,7 +3068,7 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
> >       struct hci_ev_conn_complete *ev = data;
> >       struct hci_conn *conn;
> >
> > -     if (__le16_to_cpu(ev->handle) > HCI_CONN_HANDLE_MAX) {
> > +     if (!status && __le16_to_cpu(ev->handle) > HCI_CONN_HANDLE_MAX) {
> >               bt_dev_err(hdev, "Ignoring HCI_Connection_Complete for invalid handle");
> >               return;
> >       }
>
> See comments above.
>
> > @@ -4690,7 +4690,7 @@ static void hci_sync_conn_complete_evt(struct hci_dev *hdev, void *data,
> >               return;
> >       }
> >
> > -     if (__le16_to_cpu(ev->handle) > HCI_CONN_HANDLE_MAX) {
> > +     if (!status && __le16_to_cpu(ev->handle) > HCI_CONN_HANDLE_MAX) {
> >               bt_dev_err(hdev, "Ignoring HCI_Sync_Conn_Complete for invalid handle");
> >               return;
> >       }
>
> This is also in the wrong position. Fundamentally we need to check the validity of the handle before we assign it and not just globally.
>
> > @@ -5527,7 +5527,7 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
> >       struct smp_irk *irk;
> >       u8 addr_type;
> >
> > -     if (handle > HCI_CONN_HANDLE_MAX) {
> > +     if (!status && handle > HCI_CONN_HANDLE_MAX) {
> >               bt_dev_err(hdev, "Ignoring HCI_LE_Connection_Complete for invalid handle");
> >               return;
> >       }
>
> Same here. The global check is pointless. Check before using it.
>
> Regards
>
> Marcel
>


-- 
Luiz Augusto von Dentz
