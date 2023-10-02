Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE5CE776D1
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Oct 2023 23:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjJBXWn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Oct 2023 19:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237155AbjJBXWm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Oct 2023 19:22:42 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F0FDD
        for <linux-bluetooth@vger.kernel.org>; Mon,  2 Oct 2023 16:22:39 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c012232792so3359991fa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Oct 2023 16:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696288958; x=1696893758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5XIJtX1EAuQjwSpl0j0+OjDfDYaeOZIQiAK0siVjdD0=;
        b=mjqJ7QphVVVv24SBGJX8mAl96Xw5Z8mikGo7hbtpkp54gDdLNwxo2Yn4bac3ffiAUj
         i9OxIfdYW6PAvylZ8jYSPDvEbStKSc7ifqvTnyXBYoK+1LKTw5l2GX9dzQ9hG0eg3n3R
         fwlvkmj6FzsonRggtAfQQMonSngJ02hSKqZefwfp7E0vFkARNwtdrCvElDtx7HgnRi9F
         X4s/8X01CWiN2+Dd+ERysegADnrrgZvIJ2FpbgHpPLMnVN17vyZ3g/wW5tyipk7HAPcG
         M5DoiZmqZAFtC0/tzyEDO9O67xPKPT3/FKMMD3KV2Teac/TqfUh0MQUC0ghmOGmrDODO
         a4Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696288958; x=1696893758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5XIJtX1EAuQjwSpl0j0+OjDfDYaeOZIQiAK0siVjdD0=;
        b=hq8evtC5DOF2kifpkrd7O2zpqY5r2B2pTMogTiWFY+gkaor0oIuVxYMjhLaMVf41i4
         cFPpBh8ykA1SiIe9u7xN8HrekxnVu+Fo7ZSm3NYafYf/NfbKRumyO7n8Bjp8+nCj2pc2
         LnyVx+iCPY5MoH9dEQpQh7rU1mA9m3j3tld/VCrV0J9TFJ+9CQcvNMaar0rEdrOCmXOM
         H/oCjk9onRjC0SFQORqH26vNLgTU9B8l6qVVDtz+Mte/xRD94c0MdWj9FA/6PlFytF2v
         gERoWB/lj46Rwkz7kaXYV0NVBQdqZVvmyr8iaER20WMvpwLyFW0YgqbZ+lmB1828BuR1
         Guqg==
X-Gm-Message-State: AOJu0YyR9ZDzq6CgdJI1YPa6HQqdCIiZw7s5pZuifnoLqE7cKMgM8Xxf
        ppbwO/KuamC0AhN4LfYgeDnE8qb6Td0804bjXGW4VOU7nmyyOQ==
X-Google-Smtp-Source: AGHT+IHn2eXVJmOx7+CcMGFcH6j5dz7pqSxym52Lh3UTap4VtdLoGZfAitcxHoKuo5ZVo8jI+ZNk2YuGIVWJ+sW6uz0=
X-Received: by 2002:a2e:bc27:0:b0:2c2:966f:8cc with SMTP id
 b39-20020a2ebc27000000b002c2966f08ccmr7129745ljf.0.1696288957796; Mon, 02 Oct
 2023 16:22:37 -0700 (PDT)
MIME-Version: 1.0
References: <53130b4a5fb21a15f2674c336282d25ef5d2232e.1696077070.git.pav@iki.fi>
 <fd9c0f0eddb8a7d73e9797568dc3cf2bc9b8ad62.1696077070.git.pav@iki.fi>
In-Reply-To: <fd9c0f0eddb8a7d73e9797568dc3cf2bc9b8ad62.1696077070.git.pav@iki.fi>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 2 Oct 2023 16:22:25 -0700
Message-ID: <CABBYNZKcTxZ916gdjCSWe6j+9JJ=Jz-Yazfm5bu-vzNss8U9oQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Bluetooth: hci_conn: verify connection is to be
 aborted before doing it
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzbot+a0c80b06ae2cb8895bc4@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Sat, Sep 30, 2023 at 3:25=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> There is a race condition where a connection handle is reused, after
> hci_abort_conn but before abort_conn_sync is processed in hci_sync. In
> this case, hci_abort_conn_sync ends up working on the wrong connection,
> which can have abort_reason=3D=3D0, in which case hci_connect_cfm is call=
ed
> with success status and then connection is deleted, which causes various
> use-after-free.
>
> Fix by checking abort_reason is nonzero before calling
> hci_abort_conn_sync. If it's zero, then the connection is probably a
> different one than we expected and should not be aborted.
>
> Also fix some theoretical UAF / races, where something frees the conn
> while hci_abort_conn_sync is working on it.
>
> Fixes: a13f316e90fd ("Bluetooth: hci_conn: Consolidate code for aborting =
connections")
> Reported-by: syzbot+a0c80b06ae2cb8895bc4@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/linux-bluetooth/0000000000005ab9840603715=
83e@google.com/
> Signed-off-by: Pauli Virtanen <pav@iki.fi>
> ---
>
> Notes:
>     v2: drop one probably not necessary WARN_ON
>
>     Not sure how you'd hit this condition in real controller, but syzbot
>     does end up calling hci_abort_conn_sync with reason =3D=3D 0 which th=
en
>     causes havoc.
>
>     This can be verified: with a patch that changes abort_conn_sync to
>
>         2874    conn =3D hci_conn_hash_lookup_handle(hdev, handle);
>         2875    if (!conn || WARN_ON(!conn->abort_reason))
>         2876            return 0;
>
>     https://syzkaller.appspot.com/text?tag=3DPatch&x=3D16eff740680000
>
>     it hits that WARN_ON:
>
>     https://syzkaller.appspot.com/x/log.txt?x=3D10affb97a80000
>
> #syz test git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetoo=
th-next.git master
>
>  net/bluetooth/hci_conn.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index e62a5f368a51..22de82071e35 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -2901,12 +2901,25 @@ static int abort_conn_sync(struct hci_dev *hdev, =
void *data)
>  {
>         struct hci_conn *conn;
>         u16 handle =3D PTR_UINT(data);
> +       u8 reason;
> +       int err;
> +
> +       rcu_read_lock();
>
>         conn =3D hci_conn_hash_lookup_handle(hdev, handle);
> +       if (conn) {
> +               reason =3D READ_ONCE(conn->abort_reason);
> +               conn =3D reason ? hci_conn_get(conn) : NULL;
> +       }
> +
> +       rcu_read_unlock();
> +
>         if (!conn)
>                 return 0;
>
> -       return hci_abort_conn_sync(hdev, conn, conn->abort_reason);
> +       err =3D hci_abort_conn_sync(hdev, conn, reason);
> +       hci_conn_put(conn);
> +       return err;
>  }
>
>  int hci_abort_conn(struct hci_conn *conn, u8 reason)
> @@ -2918,6 +2931,8 @@ int hci_abort_conn(struct hci_conn *conn, u8 reason=
)
>          */
>         if (conn->abort_reason)
>                 return 0;
> +       if (WARN_ON(!reason))
> +               reason =3D HCI_ERROR_UNSPECIFIED;
>
>         bt_dev_dbg(hdev, "handle 0x%2.2x reason 0x%2.2x", conn->handle, r=
eason);
>
> --
> 2.41.0

Don't really like where this is going, the culprit here seems that we
are not able to cancel the callback when freeing the hci_conn so it
stays enqueued while the new connection is created with the same
handle, so I think we need to introduce a function that cancel queued
like Ive sent sometime back, that way we don't need to keep trying to
check if it is the same connection or not.


--=20
Luiz Augusto von Dentz
