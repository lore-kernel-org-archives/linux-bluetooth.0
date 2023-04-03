Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F618C76196
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Apr 2023 22:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbjDCWw3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 3 Apr 2023 18:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233775AbjDCWwZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 3 Apr 2023 18:52:25 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32EF444B6
        for <linux-bluetooth@vger.kernel.org>; Mon,  3 Apr 2023 15:52:17 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id c29so40059700lfv.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Apr 2023 15:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680562335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=strz1h1gIkGDKf+pPaTRaOhTqMwADov+KszjF2zM7PA=;
        b=OOrU7Z9vy/zU5ZX+2qlu53SgqPN6rxtOfQTY+cvEJsZ4KXs+8qon58WIOuOXl1CJp1
         Xb17lFZjoy3y/snNddT7R4OZAlJZKq55Em6/et8SSi0EUp6A88HcK2fqL3rsj2+wvQ/x
         MgedARvlg8c0nWnieVDhWs6LsQRjsGMP9jpzrMkkFUPSsnS4smCW39xAP1qdejHnClB1
         hVSVwHuTnXw1pai3i7RO3O59m7FLjKK1oiZn/G9RrgN6+2Ch2WNgZvTRwCi62HhatGmH
         KjXDhhQ8D+8ilDb40UmUxdLOHLh/f3Y84rL59iVpSs/HnopptamNXRxRbu3hjDqGPbG9
         f8aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680562335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=strz1h1gIkGDKf+pPaTRaOhTqMwADov+KszjF2zM7PA=;
        b=sZgFyh47mHPtf30EpCFlDi3Ch2OGUWu8UOuzg8t3/J9dbiO7ZyHAMJ3laAjWuLgBrO
         SxOcN8R30Qe7ZP3YSzg2kOmBeBAexsctyYkDQYTHbDokiyvcYIgD/nk+KtmKc0O3QXQe
         hBvNWJojXORUPJkeDe7MTX19AE4StofBwn1RUZXMAUMNPgKdPe5/OgB65q/u/KILOyd3
         +UFQ4ibiXoZHuzh2o5JxdjU4f2TZA3nXeXMqm+AUkdQIb8UD9tVv4IabyMLvVouTmVya
         CLj5aGNwb5fN+xHGI7/YZy0xtpccwRy/cg/8VwhWo90HeBYTDTmQUwmx+PDWn7vy3NYC
         en7Q==
X-Gm-Message-State: AAQBX9ccb6Vl2gPzGhJsMIdAhUATopLJHml6a4lhdlf1u11NcfhK72rt
        1lyq2smZB9mv4XUZME0ja1UEQCyAK+C8UIeCe0LyuUY+
X-Google-Smtp-Source: AKy350avR7R/a24VB7+5DL59sLE5rnOWYhyd47AE4Al46Wc1vrfNCJn0a9i9TKnbsiwTFlkZ4nP8K5WBTJHPIA458LE=
X-Received: by 2002:ac2:522c:0:b0:4ea:2dce:fa0a with SMTP id
 i12-20020ac2522c000000b004ea2dcefa0amr95155lfl.10.1680562334718; Mon, 03 Apr
 2023 15:52:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230403224412.2021594-1-luiz.dentz@gmail.com>
In-Reply-To: <20230403224412.2021594-1-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 3 Apr 2023 15:52:02 -0700
Message-ID: <CABBYNZK74Q6Hm=g0dnnP16tqcU9ObSk6Sj6+2uRf=4aFNmUaeQ@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: hci_conn: Fix possible UAF
To:     linux-bluetooth@vger.kernel.org
Cc:     Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

On Mon, Apr 3, 2023 at 3:44=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This fixes the following trace:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: slab-use-after-free in hci_conn_del+0xba/0x3a0
> Write of size 8 at addr ffff88800208e9c8 by task iso-tester/31
>
> CPU: 0 PID: 31 Comm: iso-tester Not tainted 6.3.0-rc2-g991aa4a69a47
>  #4716
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.1-2.fc36
> 04/01/2014
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x1d/0x70
>  print_report+0xce/0x610
>  ? __virt_addr_valid+0xd4/0x150
>  ? hci_conn_del+0xba/0x3a0
>  kasan_report+0xdd/0x110
>  ? hci_conn_del+0xba/0x3a0
>  hci_conn_del+0xba/0x3a0
>  hci_conn_hash_flush+0xf2/0x120
>  hci_dev_close_sync+0x388/0x920
>  hci_unregister_dev+0x122/0x260
>  vhci_release+0x4f/0x90
>  __fput+0x102/0x430
>  task_work_run+0xf1/0x160
>  ? __pfx_task_work_run+0x10/0x10
>  ? mark_held_locks+0x24/0x90
>  exit_to_user_mode_prepare+0x170/0x180
>  syscall_exit_to_user_mode+0x19/0x50
>  do_syscall_64+0x4e/0x90
>  entry_SYSCALL_64_after_hwframe+0x70/0xda
>
> Fixes: 0f00cd322d22 ("Bluetooth: Free potentially unfreed SCO connection"=
)
> Link: https://syzkaller.appspot.com/bug?extid=3D8bb72f86fc823817bc5d
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  net/bluetooth/hci_conn.c | 30 ++++++++++++++++++++++++------
>  1 file changed, 24 insertions(+), 6 deletions(-)
>
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index fe8d54f8f04f..5672b4924572 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -1069,6 +1069,17 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev=
, int type, bdaddr_t *dst,
>         return conn;
>  }
>
> +static bool hci_conn_unlink(struct hci_conn *conn)
> +{
> +       if (!conn->link)
> +               return false;
> +
> +       conn->link->link =3D NULL;
> +       conn->link =3D NULL;
> +
> +       return true;
> +}
> +
>  int hci_conn_del(struct hci_conn *conn)
>  {
>         struct hci_dev *hdev =3D conn->hdev;
> @@ -1080,15 +1091,16 @@ int hci_conn_del(struct hci_conn *conn)
>         cancel_delayed_work_sync(&conn->idle_work);
>
>         if (conn->type =3D=3D ACL_LINK) {
> -               struct hci_conn *sco =3D conn->link;
> -               if (sco) {
> -                       sco->link =3D NULL;
> +               struct hci_conn *link =3D conn->link;
> +
> +               if (link) {
> +                       hci_conn_unlink(conn);
>                         /* Due to race, SCO connection might be not estab=
lished
>                          * yet at this point. Delete it now, otherwise it=
 is
>                          * possible for it to be stuck and can't be delet=
ed.
>                          */
> -                       if (sco->handle =3D=3D HCI_CONN_HANDLE_UNSET)
> -                               hci_conn_del(sco);
> +                       if (link->handle =3D=3D HCI_CONN_HANDLE_UNSET)
> +                               hci_conn_del(link);
>                 }
>
>                 /* Unacked frames */
> @@ -1104,7 +1116,7 @@ int hci_conn_del(struct hci_conn *conn)
>                 struct hci_conn *acl =3D conn->link;
>
>                 if (acl) {
> -                       acl->link =3D NULL;
> +                       hci_conn_unlink(conn);
>                         hci_conn_drop(acl);
>                 }
>
> @@ -2444,6 +2456,12 @@ void hci_conn_hash_flush(struct hci_dev *hdev)
>                 c->state =3D BT_CLOSED;
>
>                 hci_disconn_cfm(c, HCI_ERROR_LOCAL_HOST_TERM);
> +
> +               /* Unlink before deleting otherwise it is possible that
> +                * hci_conn_del removes the link which may cause the list=
 to
> +                * contain items already freed.
> +                */
> +               hci_conn_unlink(c);
>                 hci_conn_del(c);
>         }
>  }
> --
> 2.39.2

Can you give it a try if this doesn't break the existing problem you
were trying to fix, anyway it is quite easy to reproduce with the
likes of iso-tester and syzbot also seems to have bumped into it as
well.


--=20
Luiz Augusto von Dentz
