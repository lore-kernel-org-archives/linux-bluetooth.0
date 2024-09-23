Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0BC433D6
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Sep 2024 15:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727105899; cv=none; b=tReiQfOKXeOGJ27hzl/n5LtEHN+Wh1bBj5YZbqxT18odb0VWmky+RF9A/okg7AVsf6YOLjlPcKvPZIHOBIaMajq7yNkzpbTf4w8qo+WWO7cVtvtR4niOy75un3VYl1weh1AknT12CTmpTduIPD/FIG6LEvAZwMWX3Vsjg1A1GUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727105899; c=relaxed/simple;
	bh=VSO7uT2xkknVJM18+AB8me0n8jkiADuAZGka1TMUYUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lzweFXigaTOGmrjAK3/vO2pclDmRb+VmrlKv9Y7kASktkFeunKcaGW8CeFLy7YFU2TFW3Sf4O6aqVPXs1Zmn3CuU6S6t9MGZTGMpci48Lo+udmxJpYHjg9vq2TOv4rcdS6lh0s3Sc6Cx6HoCW7FCy0pZj7tdFavuaem1yP/SkBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=smh6gEFO; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="smh6gEFO"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71788bfe60eso3663231b3a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Sep 2024 08:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727105897; x=1727710697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HNWzqv0LAr+fZdDTxHUMZYVREs5mmsO0H8D59f7sYWo=;
        b=smh6gEFOtM1NN68d4dcC/ik3/u0uJ2GCOAEt4IoQAdPL8sXDUMgek4kaL0U+M/8lrj
         yZS+sIDiRgp0v1PP0rt8ov5A8buescyEDy8wjQuGsvJWtB0oVRdK+QA8m7IH5Bjevhgq
         61v8jHSwE8v8oVc3XjTeuRqkqr2TzcZ0oqSA1wSP1Id4AZhuLV8dwcklqODSwpZcfNbp
         5qFOMjZIm1LOFXE65s+V9+kZZB4oX/efJarVDGJMsSO6uJNYhM2idizNDwli8yVer40r
         3DiyWE7DZIHFlOqQT0t7KwhksKYkhoMjx4oG+lMDjZfNMj7cM4M+cwRIxQbO18eKFRd8
         5HnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727105897; x=1727710697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HNWzqv0LAr+fZdDTxHUMZYVREs5mmsO0H8D59f7sYWo=;
        b=eaHdG3vPbliI0j2oWhZ3sxx7RE7w/EbkHIK80Rn8uJCn+07mdCVWrp4DFg5nVb+RWa
         iysBVNw5S0DUDD8iQ8ANiITCGh3ykQYUK0olTcPl7AsYRy0nIxnZSN+O9CHG7j3CGMH3
         0hqPZdlkgxhygY0g9rMJ9gGKJSfQ8FfvDE0LrKvlV0Lg7CnUgqW9M6ROdGYxg76PTJc+
         KQon+QHQF96ApyQjFBVp5nBBI50banRuTjdvzZRirxOhvKSFrn3PvvOFY5e69wz42Vja
         RgHPDdTFn8EpINPstIhwn1MoUQ8KDOc/Ix7rTxv2SajfMwZEB6BwZQ0Y8h7rLlbH8J0x
         nbvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIgGBDi3LljC9Nj032zj8CHCol0w2xRm5kxfLvWqAjDvt+JRMUXBLAyFuRzRov04qn7ik1fuGtcjzzrotQBO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG/XooKhJaK3nj+56V4mGIGpsI7ufRBmf0uQkoHqTJi1WPxj73
	ZFZXwgLXmCZBTqXBtP3R3Qxfx0U8YkLIY8gMzjWPA8r0el7z5TG0ZSzcZAvKou1cBzbQsVrMa32
	+l/dRe+S91tZ6VjsUi17yRIzB6WYPlhVXHiVT
X-Google-Smtp-Source: AGHT+IHb0BavWVYG7v04YHJffKMfU7HscEjRUekuoT8uTPQ23YGmVCA6QDcIxU2xREn0sHZXAP50DGIUQSnj5uEeV+o=
X-Received: by 2002:a05:6a00:a1b:b0:714:2620:d235 with SMTP id
 d2e1a72fcca58-7199c976712mr18027119b3a.16.1727105897072; Mon, 23 Sep 2024
 08:38:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABBYNZLnohZofm4Tchk7p36XS=HwYmN94DB0FGyiPFJno+evSw@mail.gmail.com>
 <20240921105609.1025-1-hdanton@sina.com> <CABBYNZLqXfAc7_YO+goAf7fnAsmJ+j9V0cjmPMX4+MhoDhzOCA@mail.gmail.com>
 <CANp29Y7bbvUckx7c+Bke28p5AzNCw7kYfXr87DsAD2DtUm99Xw@mail.gmail.com> <CABBYNZLKMu296VLeEcyMZBw1HFivMA=L6xOZRHHcKwWZb7PQ4g@mail.gmail.com>
In-Reply-To: <CABBYNZLKMu296VLeEcyMZBw1HFivMA=L6xOZRHHcKwWZb7PQ4g@mail.gmail.com>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Mon, 23 Sep 2024 17:38:03 +0200
Message-ID: <CANp29Y7TBdGuThfBX1=K7jNj6_+0XqL0A3_=sF1xMMpMWNfoYg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth/l2cap: Fix uaf in l2cap_connect
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Hillf Danton <hdanton@sina.com>, Edward Adam Davis <eadavis@qq.com>, 
	syzbot+c12e2f941af1feb5632c@syzkaller.appspotmail.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

On Mon, Sep 23, 2024 at 5:20=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Aleksandr,
>
> On Mon, Sep 23, 2024 at 10:37=E2=80=AFAM Aleksandr Nogikh <nogikh@google.=
com> wrote:
> >
> > On Mon, Sep 23, 2024 at 4:33=E2=80=AFPM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Hillf,
> > >
> > > On Sat, Sep 21, 2024 at 6:56=E2=80=AFAM Hillf Danton <hdanton@sina.co=
m> wrote:
> > > >
> > > > On Tue, Sep 10, 2024 at 4:56=E2=80=AFPM Luiz Augusto von Dentz <lui=
z.dentz@gmail.com> wrote:
> > > > >
> > > > > Maybe something like the following would be a better approach:
> > > > >
> > > > > https://gist.github.com/Vudentz/121a15fa4391b2b1f6c7e8d420a6846e
> > > >
> > > > If your idea is not bad, boy, feel free to win Tested-by from syzbo=
t with it.
> > >
> > > Is there a way to quickly check a patch with syzbot?
> >
> > You can send a `#syz test` command in a reply to syzbot and attach the
> > patch-to-test to the email message.
> >
> > See https://github.com/google/syzkaller/blob/master/docs/syzbot.md#test=
ing-patches
>
> Thanks, lets see if this works:
>
> #syz test
>
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index d6976db02c06..b2f8f9c5b610 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -3782,6 +3782,8 @@ static void hci_acldata_packet(struct hci_dev
> *hdev, struct sk_buff *skb)
>
>         hci_dev_lock(hdev);
>         conn =3D hci_conn_hash_lookup_handle(hdev, handle);
> +       if (conn && hci_dev_test_flag(hdev, HCI_MGMT))
> +               mgmt_device_connected(hdev, conn, NULL, 0);
>         hci_dev_unlock(hdev);
>

^^ Patch parsing will fail here because it expects to see the git diff
output as is -- i.e. if some line only consisted of a single
whitespace (=3D it was an empty line and it did not change), it must
remain so. Sometimes these whitespaces get lost during copy-pasting
and it confuses syzbot.

>         if (conn) {
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 1c82dcdf6e8f..b87c0f1dab9e 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -3706,7 +3706,7 @@ static void hci_remote_features_evt(struct
> hci_dev *hdev, void *data,
>                 goto unlock;
>         }
>
> -       if (!ev->status && !test_bit(HCI_CONN_MGMT_CONNECTED, &conn->flag=
s)) {
> +       if (!ev->status) {
>                 struct hci_cp_remote_name_req cp;
>                 memset(&cp, 0, sizeof(cp));
>                 bacpy(&cp.bdaddr, &conn->dst);
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 9988ba382b68..6544c1ed7143 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -4066,17 +4066,9 @@ static void l2cap_connect(struct l2cap_conn
> *conn, struct l2cap_cmd_hdr *cmd,
>  static int l2cap_connect_req(struct l2cap_conn *conn,
>                              struct l2cap_cmd_hdr *cmd, u16 cmd_len, u8 *=
data)
>  {
> -       struct hci_dev *hdev =3D conn->hcon->hdev;
> -       struct hci_conn *hcon =3D conn->hcon;
> -
>         if (cmd_len < sizeof(struct l2cap_conn_req))
>                 return -EPROTO;
>
> -       hci_dev_lock(hdev);
> -       if (hci_dev_test_flag(hdev, HCI_MGMT))
> -               mgmt_device_connected(hdev, hcon, NULL, 0);
> -       hci_dev_unlock(hdev);
> -
>         l2cap_connect(conn, cmd, data, L2CAP_CONN_RSP);
>         return 0;
>  }

--=20
Aleksandr
