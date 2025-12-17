Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5A3283C83
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 21:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766007394; cv=none; b=lYy2KWeHMSC1FUwmfxfpYgVWPu9vuR6Oxc6jLJSWh5LjubCfDd5oakIpZlYex0qX/R8qFhVkpeor7Z9OqYrUmq6IvrS6xwcFZ+YXsWgr1KtmnE/Zlc+KAtJ2v+Z094eu03e1YEgUku3kbFKgqUtahYwn6GqeY2RgCtHaFanfbmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766007394; c=relaxed/simple;
	bh=mPiAnXDnXYeaRRXvkzT09R1gTCChRkB+wmW7gki5HF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=US7JZRFxmphQ+01sHfnkoSfH3Au8kWir5EEsXCFJPyRk3dQO6C9J3UeHUQl29UBXWKS94d2V2lhtgyz2LHIbNxxbs9niZBOaPikYysGOe/6uWjf4259OU+jw45W+Bl/PBt6zv1T9v5aDiHC51IXOvSHjTG5cYC3EosEa1YHKhWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jHzGUm8k; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHzGUm8k"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-38107fadda2so9367381fa.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 13:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766007390; x=1766612190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1HRCCp5MOT9evGsh3hsretESYQ1gOMoQIZE9n7dSAao=;
        b=jHzGUm8k6jIWLOmohfboZgpRP06uJUoyyWJIZnsFHSyJBdnid19eSAUf4GY8h9hQGX
         rh29xECHgpFQgYM7QIC7bio6Va5PS1IvxDntPHCAd++edBNULI7+20i96rQzJmyIjvE3
         64PoRCykiZddSdBVgW1IijA9ndc5PgzV6if5bLzoI6s+R14d7KyFP9gJfDEWFQc1TI8r
         YxBPhfDdQQhAEklIcuGt+BlfIRid/JRJl1InZc5Ue5FsBirF0qOvWXnRgR55bAMvbvZW
         jphy7Qcp9EjtJufg0kJ4Qb/YRu31w7M2C1FjoyOM2hNfxC7zIJUXZlWbPgowbhr1qMAh
         NtnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766007390; x=1766612190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1HRCCp5MOT9evGsh3hsretESYQ1gOMoQIZE9n7dSAao=;
        b=vN24/d8GlwAVRtIpNbPAssaIg6zuQ12nyTCMiw8Q8/GikAUdSCYIawXeLXSjfBT0s4
         zkl8K2nSZBd2TKJYZirMWzD2VNFh23a5RW7HSv+oxVtuwaMN3LzC7NSBEZRcfI+UR1yc
         dYAPs6f6pBwhy2OANGMN8jI/lLCxvXxC4p1fXoEq63/pwhfKp+4pJXT98GcQmHrIeWFv
         ZQhIrG62EFLwYsoBF8wMCvmHFhmtpb8FDQR5O0arvmWRKHO0oEY3yjKpfPwBeMgoO+NH
         IFE+ZHaj69m4ZJo6AUS36426P3zUxIaj3Fy/8M+oIisocePRwX0q7AraGV269Un0KcbU
         fJDw==
X-Gm-Message-State: AOJu0Yy66YT+ZpJ0t8IaCNNk71UUwMGKxhX0nahJuNOAxnPccAfTmXJ/
	gIL1I8dXHYHuJpbu5u1nuPtQrQmlq84U39frzxlAyjkfYsJhKokM2J8ROsJzUtHrUHcHVWEtQHi
	Oo322UX0exOYUo+QCeC3JoSB+5sBSZgk=
X-Gm-Gg: AY/fxX7tnqq0ntvAzUfoWaLhBbEvgyBsVTpNTbxvkqX7dCtUIkch928C6AF4yRHBnOy
	Keo8Qkerg7bf5RzA629LZQI/ZOJpcvJclLj9074vG04s3Q7kgTUjD7OkfL+i3svhaZ6GI2IUzvN
	uvZkw3Hh3df3kOsQQcr9QbTAiJ0vecGo+wT5caooEm0LrRnt2IzcdhFQEVF8b2sCTBIgitLvUUp
	PYinDwzyl4yDEYDtTaDV0u2bmBx0D++UjUZPz88NP7Hgjv7YT8cIAm5+kWHGsU8BxmiqQ==
X-Google-Smtp-Source: AGHT+IHS1pJCfFi8UUoNWBhzHaivRgIYxgf5LXjO7ufMaT3GrBrZrXIKfEeMi18C3JAoCGmcgBFjF6npMi+HWFeJzyo=
X-Received: by 2002:a2e:a549:0:b0:352:6aa4:3cee with SMTP id
 38308e7fff4ca-37fd07b6d1bmr53080201fa.17.1766007390391; Wed, 17 Dec 2025
 13:36:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251216191255.882653-1-cakturk@gmail.com>
In-Reply-To: <20251216191255.882653-1-cakturk@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 17 Dec 2025 16:36:18 -0500
X-Gm-Features: AQt7F2pD0E44LdSWQnxxnebiiCn62J1_dj_F133lrskV1I5-uD-kcwprVEDGU0Q
Message-ID: <CABBYNZKHof-LaKXiB_oe34R9_mTdH_YCjVsATrdwrLQehaGWhg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci: fix refcounts in LE remote features command
To: Cihangir Akturk <cakturk@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, linux-kernel@vger.kernel.org, 
	syzbot+87badbb9094e008e0685@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Cihangir,

On Tue, Dec 16, 2025 at 2:13=E2=80=AFPM Cihangir Akturk <cakturk@gmail.com>=
 wrote:
>
> KASAN reported a slab-use-after-free in le_read_features_complete()
> running from hci_cmd_sync_work.  le_read_features_complete() can run
> after hci_rx_work/hci_conn_del() has removed the link, so the destroy
> callback may touch a freed hci_conn and trigger a KASAN use-after-free.
> Duplicate submissions also need to drop the references to avoid leaking
> the hold and blocking teardown.
>
> Fix this by taking hci_conn_get() before queueing, passing the conn
> directly as work data, and balancing hci_conn_hold()/drop() and
> hci_conn_get()/put() in the completion and all error/-EEXIST paths so
> the connection stays referenced while the work runs and is released
> afterwards.
>
> Reported-by: syzbot+87badbb9094e008e0685@syzkaller.appspotmail.com
> Signed-off-by: Cihangir Akturk <cakturk@gmail.com>
> ---
>  net/bluetooth/hci_sync.c | 37 ++++++++++++++++++++++++++-----------
>  1 file changed, 26 insertions(+), 11 deletions(-)
>
> I am not entirely sure that removing the err =3D=3D -ECANCELED early retu=
rn
> is strictly correct. My assumption is that, with the changes in this
> patch, there does not appear to be another cancellation path that
> reliably balances hci_conn_drop() and hci_conn_put() for this command.
> Based on that assumption, keeping the early return could leave the
> references taken before queuing unbalanced on cancellation, so I opted
> to remove it to keep the lifetime handling consistent.
>
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index a9f5b1a68356..5a3d288e7015 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -776,14 +776,23 @@ _hci_cmd_sync_lookup_entry(struct hci_dev *hdev, hc=
i_cmd_sync_work_func_t func,
>   * - Lookup if an entry already exist and only if it doesn't creates a n=
ew entry
>   *   and queue it.
>   */
> -int hci_cmd_sync_queue_once(struct hci_dev *hdev, hci_cmd_sync_work_func=
_t func,
> +static int __hci_cmd_sync_queue_once(struct hci_dev *hdev, hci_cmd_sync_=
work_func_t func,
>                             void *data, hci_cmd_sync_work_destroy_t destr=
oy)
>  {
>         if (hci_cmd_sync_lookup_entry(hdev, func, data, destroy))
> -               return 0;
> +               return -EEXIST;
>
>         return hci_cmd_sync_queue(hdev, func, data, destroy);
>  }
> +
> +int hci_cmd_sync_queue_once(struct hci_dev *hdev, hci_cmd_sync_work_func=
_t func,
> +                           void *data, hci_cmd_sync_work_destroy_t destr=
oy)
> +{
> +       int ret;
> +
> +       ret =3D __hci_cmd_sync_queue_once(hdev, func, data, destroy);
> +       return ret =3D=3D -EEXIST ? 0 : ret;
> +}
>  EXPORT_SYMBOL(hci_cmd_sync_queue_once);
>
>  /* Run HCI command:
> @@ -7338,10 +7347,8 @@ static void le_read_features_complete(struct hci_d=
ev *hdev, void *data, int err)
>
>         bt_dev_dbg(hdev, "err %d", err);
>
> -       if (err =3D=3D -ECANCELED)
> -               return;
> -
>         hci_conn_drop(conn);
> +       hci_conn_put(conn);
>  }
>
>  static int hci_le_read_all_remote_features_sync(struct hci_dev *hdev,
> @@ -7408,12 +7415,20 @@ int hci_le_read_remote_features(struct hci_conn *=
conn)
>          * role is possible. Otherwise just transition into the
>          * connected state without requesting the remote features.
>          */
> -       if (conn->out || (hdev->le_features[0] & HCI_LE_PERIPHERAL_FEATUR=
ES))
> -               err =3D hci_cmd_sync_queue_once(hdev,
> -                                             hci_le_read_remote_features=
_sync,
> -                                             hci_conn_hold(conn),
> -                                             le_read_features_complete);
> -       else
> +       if (conn->out || (hdev->le_features[0] & HCI_LE_PERIPHERAL_FEATUR=
ES)) {
> +               hci_conn_get(conn);
> +               hci_conn_hold(conn);
> +               err =3D __hci_cmd_sync_queue_once(hdev,
> +                                               hci_le_read_remote_featur=
es_sync,
> +                                               conn,
> +                                               le_read_features_complete=
);
> +               if (err) {
> +                       hci_conn_drop(conn);
> +                       hci_conn_put(conn);
> +                       if (err =3D=3D -EEXIST)
> +                               err =3D 0;
> +               }
> +       } else

Sort of overkill, why do we have to use 2 references? Also we do have
code for dequeuing callbacks using conn as user_data so either that is
not working or there is something else at play here. Maybe we need to
change the order so that dequeue happens before hci_conn_cleanup:

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index dc085856f5e9..b64c0e53d9cd 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1232,15 +1232,15 @@ void hci_conn_del(struct hci_conn *conn)
        skb_queue_purge(&conn->data_q);
        skb_queue_purge(&conn->tx_q.queue);

+       /* Dequeue callbacks using connection pointer as data */
+       hci_cmd_sync_dequeue(hdev, NULL, conn, NULL);
+
        /* Remove the connection from the list and cleanup its remaining
         * state. This is a separate function since for some cases like
         * BT_CONNECT_SCAN we *only* want the cleanup part without the
         * rest of hci_conn_del.
         */
        hci_conn_cleanup(conn);
-
-       /* Dequeue callbacks using connection pointer as data */
-       hci_cmd_sync_dequeue(hdev, NULL, conn, NULL);
 }

 struct hci_dev *hci_get_route(bdaddr_t *dst, bdaddr_t *src, uint8_t src_ty=
pe)


>                 err =3D -EOPNOTSUPP;
>
>         return err;
> --
> 2.52.0
>


--=20
Luiz Augusto von Dentz
