Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9ACC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 May 2022 18:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240181AbiEXSIk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 May 2022 14:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240182AbiEXSIj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 May 2022 14:08:39 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33D46B08B
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 May 2022 11:08:37 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id p13-20020a17090a284d00b001e0817e77f6so1892246pjf.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 May 2022 11:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P6jEhRYBuWpsNnDD04lz5yBNR701Qvg5CrX6H/2zQns=;
        b=E6CH5dAWA610CekiEz9VwVayPGHwiOrWyYSiKWab0JyGaW+3y/U18sdjy31+DPCG1l
         IJ6fliYPRpsnbu4V0tf2pE3OEP+voFuRTyty4cvIiWRAD/GP5QaNxpQ2quvECvUgshiD
         Iv66jG4OsLD0vlUfLmcOjinH1T8varBVUHO0sAmTFFjDeQVYM2E3PK04Wf5WflbFQQDS
         eK0VLzO+gpZdPA8U7BCz3af/0kD9J9zGPzSnUzkeiEx0sJR3ewGjuamzKvLhAdFt7Ef1
         I64OQDtic/L4KiuIEhYeDA+MKOhuxxE0rAo0wC0Iw6pfSG/GeGU0Ie0ynytAX73YkHkt
         brgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P6jEhRYBuWpsNnDD04lz5yBNR701Qvg5CrX6H/2zQns=;
        b=uMsvDjs8q2uX1S+c3aQsiVc2ekgCDQjLZvZnMCVMlAY8vtmzaFGLABfaOdNRzkm6nN
         DqeBIgpSSJRq5KB6P6jQsFgmCWdI8jGVoKUzcR+rwiuZ8NT2wsmnGM2HiwSvoKF7E1EN
         GvHXqF0nqmZFBkMdJDVCPbr3gL7gvC8/sPy+/3a0x7JG41egcZ9AaXOE4LZnOeIHDnjm
         svBOlo+nSjmkZldgZyRE5U7b5eP7PS9t9uufDxrBk8zjUxJaMG0kbK9KQT4taM27KAyn
         l036M2aBjcWuqyfMT9J1y8K6y7wNq4Pb1IRQTHxZnpjBc0c3JWqfD0SCI5+lY2JQ6Fpq
         HHBA==
X-Gm-Message-State: AOAM530/MLMSnZicoN4/vjcLtoH10YOstQA7P4eZW7eW4W0I4wdXLm6W
        OOg+igigYGD7U7dO0Qr4RdGi029136cw71DPYpK7EIu3eO4=
X-Google-Smtp-Source: ABdhPJyOqa4oM4Qm3+60RX6SnHLUq+By/tgUvmRt4cAM38rlHCPByPAlKEbZrP0zZEow3D921niTuFJ/fA9MBqkAe5c=
X-Received: by 2002:a17:90a:3cce:b0:1df:8f80:ef7a with SMTP id
 k14-20020a17090a3cce00b001df8f80ef7amr5905607pjd.4.1653415717034; Tue, 24 May
 2022 11:08:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220520183713.2641513-1-luiz.dentz@gmail.com>
 <148a9f76-0784-1d17-22cd-80343895aa37@pengutronix.de> <9e5b51ae-5089-dc91-57cb-52b0d76249d8@pengutronix.de>
In-Reply-To: <9e5b51ae-5089-dc91-57cb-52b0d76249d8@pengutronix.de>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 24 May 2022 11:08:25 -0700
Message-ID: <CABBYNZ+DNOvguwKXie+1NVJ6xQjOYQiUCroBcBNEyUuKjt2+_Q@mail.gmail.com>
Subject: Re: [PATCH-stable] Bluetooth: hci_conn: Fix hci_connect_le_sync
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Ahmad,

On Tue, May 24, 2022 at 8:55 AM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>
> Hello Luiz,
>
> On 24.05.22 16:48, Ahmad Fatoum wrote:
> > On 20.05.22 20:37, Luiz Augusto von Dentz wrote:
> >> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >>
> >> The handling of connection failures shall be handled by the request
> >> completion callback as already done by hci_cs_le_create_conn, also make
> >> sure to use hci_conn_failed instead of hci_le_conn_failed as the later
> >> don't actually call hci_conn_del to cleanup.
> >>
> >> Link: https://github.com/bluez/bluez/issues/340
> >> Fixes: 8e8b92ee60de5 ("Bluetooth: hci_sync: Add hci_le_create_conn_sync")
> >> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > A bit late, as I am not subscribed to linux-bluetooth and didn't notice this
> > patch, but FWIW: Tested-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> >
> >   Bluetooth: hci0: Opcode 0x200d failed: -110
> >   Bluetooth: hci0: request failed to create LE connection: err -110
> >
> > now, whereas before it crashed the kernel.
>
> I see now that this fix doesn't build for v5.17 because hci_conn_failed
> was only introduced in v5.18. Can the hci_conn.c hunk be safely dropped?

Are you talking about:

        if (status) {
-               hci_le_conn_failed(conn, status);
+               hci_conn_failed(conn, status);
                goto unlock;
        }

You just need to replace hci_conn_failed with hci_le_conn_failed or
well in the code above the end result is the same since it is not
supposed to cleanup in the event handler.

> Thanks,
> Ahmad
>
> >
> > Cheers,
> > Ahmad
> >
> >> ---
> >>  net/bluetooth/hci_conn.c  | 5 +++--
> >>  net/bluetooth/hci_event.c | 8 +++++---
> >>  2 files changed, 8 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> >> index 882a7df13005..ac06c9724c7f 100644
> >> --- a/net/bluetooth/hci_conn.c
> >> +++ b/net/bluetooth/hci_conn.c
> >> @@ -943,10 +943,11 @@ static void create_le_conn_complete(struct hci_dev *hdev, void *data, int err)
> >>
> >>      bt_dev_err(hdev, "request failed to create LE connection: err %d", err);
> >>
> >> -    if (!conn)
> >> +    /* Check if connection is still pending */
> >> +    if (conn != hci_lookup_le_connect(hdev))
> >>              goto done;
> >>
> >> -    hci_le_conn_failed(conn, err);
> >> +    hci_conn_failed(conn, err);
> >>
> >>  done:
> >>      hci_dev_unlock(hdev);
> >> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> >> index 0270e597c285..af17dfb20e01 100644
> >> --- a/net/bluetooth/hci_event.c
> >> +++ b/net/bluetooth/hci_event.c
> >> @@ -5632,10 +5632,12 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
> >>              status = HCI_ERROR_INVALID_PARAMETERS;
> >>      }
> >>
> >> -    if (status) {
> >> -            hci_conn_failed(conn, status);
> >> +    /* All connection failure handling is taken care of by the
> >> +     * hci_conn_failed function which is triggered by the HCI
> >> +     * request completion callbacks used for connecting.
> >> +     */
> >> +    if (status)
> >>              goto unlock;
> >> -    }
> >>
> >>      if (conn->dst_type == ADDR_LE_DEV_PUBLIC)
> >>              addr_type = BDADDR_LE_PUBLIC;
> >
> >
>
>
> --
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |



-- 
Luiz Augusto von Dentz
