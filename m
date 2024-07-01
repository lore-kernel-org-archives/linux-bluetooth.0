Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BFC15EFB0
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jul 2024 13:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719842374; cv=none; b=oMkmmgmnzDQ/nLp2KOAn5XxVSnw4IJuBwBGOb8Ax96e8MruhdCTMukqtc4pYmy/lwLlpzUxaXq5qv9LS2gxvN49c+lwfE7GE0tY8vPSfAPBBNpaIilQdTAUf3a1sVp1ulJO0EP5ws8ZCMmVuKNZSYTdS4CkU96GYtwzTIrXIqUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719842374; c=relaxed/simple;
	bh=/uVdAWuKbDTEiHyLzCYv9wfkJM35ipJVq+DD+ASU57U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LbNZpbiOCSeRwpzRbX1eSTGIgO6jDApso6ZLBZnXIiSDASpWyhyelPnv03kKYfE6HrlZUN3XTJylVYZChvwMTo2QgmbU/fu/raVBgmSySQ3CqgXq0moKIvjwQCnuZtIntqE7p2fquMFod0+LOy4zQ/MfV+kXUq6fGw4TQeWiRro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RkZJeCbY; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RkZJeCbY"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2eaae2a6dc1so39788711fa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Jul 2024 06:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719842369; x=1720447169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xd5UE+sv90IaGID7cz/aqdBGuAqFEHugikMJlMeOz4Y=;
        b=RkZJeCbYIXVffqGdMb3GcAB7nuCVed3JLJIw5v8PSW2EECSzWkIT1Ox0mQi/XxF1ZQ
         Nz6tn3s2TFnu3oC82iNZ5547/xubEa0Kde4YE4VlecjGGQU9Punf1MxZGYoRm6mW5DPi
         szUkS1FOjdk026VlK7RdXc/0mcBaR9/oidCIiOyd4Godps5af0WaiYduhy4MbaOF7Td0
         v/XGZwig+8L0PBYRVBwyAz5y8Fi9AqFaVVKOrbuu/hoGwLVLNDGs1b02YpmdICHDfi81
         9iWhtFxzvDwRFLQNaBECwmD8BTASJ+Bwylst9UZWUJ7fJn0+swvDhAdvdl2knc6/uqlx
         rnSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719842369; x=1720447169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xd5UE+sv90IaGID7cz/aqdBGuAqFEHugikMJlMeOz4Y=;
        b=KZ3BIamuAUurjHBZyTWJnnXmtDTCq5ZAk/NXLxA0zE7u1dTXCpRw+i0oSHY2lJcuaN
         +Q9CIsJrvYl2Opc8qabAWU67F/HNN4N5jYnrEcP5uow+q1zqMpeYfKJiJY9YWy5gXM/u
         Y5ZD3kjwukM/uqkmSgK29VAgv/71pddR68oWIj5aZqyKus6kRh1Clg/dv70I6idB8qUM
         xVOVMuHRu3nRpWXNJc0jddiB1FH7zDMn38Z5XOs1EZu6zqb3233l3l4V8t/Mlj1ujYGb
         OSz6XhDic2zNj39paw367Nlsi9tKSnFWTZqN2lr7lqYZQWdlU9v8NiEngVYMM36PN0Bn
         Kc6w==
X-Gm-Message-State: AOJu0YyPtO4cligi3Hi0POWCT9rKTuPusl+aly1Be0xU45199f/t7P2B
	DqXK7PGdpLbrvOnEydGBZ+lqlUON2TS9vBqKungn4Hwksw0DriQkZXfn7gjLdRKwYUlIKabjsRw
	gZ/UgliVcXrbLKYPRG6zU14jdpC0=
X-Google-Smtp-Source: AGHT+IFiU+ZLuSX4Gf8C6Vk2G4geALDzDj3OAJCgs080zxYPnXtx0QKbIqksxY6OYGYlsde/A4CpPispgxCzCK02dQo=
X-Received: by 2002:a2e:b816:0:b0:2ec:4bb7:d7f6 with SMTP id
 38308e7fff4ca-2ee5e37ff9emr42306281fa.7.1719842369028; Mon, 01 Jul 2024
 06:59:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624144911.3817479-1-luiz.dentz@gmail.com> <a9609dd3d0cb3b8c3fd387efe8a81eddc821be0f.camel@iki.fi>
In-Reply-To: <a9609dd3d0cb3b8c3fd387efe8a81eddc821be0f.camel@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 1 Jul 2024 09:59:16 -0400
Message-ID: <CABBYNZKYX5S7SbcHZcx2UeoV_u80bxS6y68mDhpxvROnTeP_Uw@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: Fix double free in hci_req_sync_complete
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Sat, Jun 29, 2024 at 6:07=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi Luiz,
>
> ma, 2024-06-24 kello 10:49 -0400, Luiz Augusto von Dentz kirjoitti:
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > This fixes the following race:
> >
> > cpu1                       cpu2
> > =3D=3D=3D=3D                       =3D=3D=3D=3D
> >                            sock_ioctl
> >                            sock_do_ioctl
> >                            hci_sock_ioctl
> > hci_rx_work                hci_dev_cmd
> > hci_event_packet           hci_req_sync
> > req_complete_skb           __hci_req_sync
> > hci_req_sync_complete
> >
> > If hci_rx_work executes before __hci_req_sync releases req_skb, everyth=
ing
> > is normal, otherwise it will result in double free of req_skb.
> >
> > This replaces the usage of hci_req_sync with hci_cmd_sync_status.
> >
> > Fixes: 45d355a926ab ("Bluetooth: Fix memory leak in hci_req_sync_comple=
te()")
> > Reported-and-tested-by: syzbot+35ebc808442df6420eae@syzkaller.appspotma=
il.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D35ebc808442df6420eae
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> >  include/net/bluetooth/hci_sync.h |  2 +
> >  net/bluetooth/hci_core.c         | 72 ++++++++------------------------
> >  net/bluetooth/hci_sync.c         | 13 ++++++
> >  3 files changed, 33 insertions(+), 54 deletions(-)
> >
> > diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/h=
ci_sync.h
> > index b49057bbdf23..20168732f20e 100644
> > --- a/include/net/bluetooth/hci_sync.h
> > +++ b/include/net/bluetooth/hci_sync.h
> > @@ -38,6 +38,8 @@ int __hci_cmd_sync_status(struct hci_dev *hdev, u16 o=
pcode, u32 plen,
> >  int __hci_cmd_sync_status_sk(struct hci_dev *hdev, u16 opcode, u32 ple=
n,
> >                            const void *param, u8 event, u32 timeout,
> >                            struct sock *sk);
> > +int hci_cmd_sync_status(struct hci_dev *hdev, u16 opcode, u32 plen,
> > +                     const void *param, u32 timeout);
>
> In this patch, this function is unused?
>
> >
> >  void hci_cmd_sync_init(struct hci_dev *hdev);
> >  void hci_cmd_sync_clear(struct hci_dev *hdev);
> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > index d541cbb991eb..144e85ebfbdb 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -63,50 +63,6 @@ DEFINE_MUTEX(hci_cb_list_lock);
> >  /* HCI ID Numbering */
> >  static DEFINE_IDA(hci_index_ida);
> >
> > -static int hci_scan_req(struct hci_request *req, unsigned long opt)
> > -{
> > -     __u8 scan =3D opt;
> > -
> > -     BT_DBG("%s %x", req->hdev->name, scan);
> > -
> > -     /* Inquiry and Page scans */
> > -     hci_req_add(req, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
> > -     return 0;
> > -}
> > -
> > -static int hci_auth_req(struct hci_request *req, unsigned long opt)
> > -{
> > -     __u8 auth =3D opt;
> > -
> > -     BT_DBG("%s %x", req->hdev->name, auth);
> > -
> > -     /* Authentication */
> > -     hci_req_add(req, HCI_OP_WRITE_AUTH_ENABLE, 1, &auth);
> > -     return 0;
> > -}
> > -
> > -static int hci_encrypt_req(struct hci_request *req, unsigned long opt)
> > -{
> > -     __u8 encrypt =3D opt;
> > -
> > -     BT_DBG("%s %x", req->hdev->name, encrypt);
> > -
> > -     /* Encryption */
> > -     hci_req_add(req, HCI_OP_WRITE_ENCRYPT_MODE, 1, &encrypt);
> > -     return 0;
> > -}
> > -
> > -static int hci_linkpol_req(struct hci_request *req, unsigned long opt)
> > -{
> > -     __le16 policy =3D cpu_to_le16(opt);
> > -
> > -     BT_DBG("%s %x", req->hdev->name, policy);
> > -
> > -     /* Default link policy */
> > -     hci_req_add(req, HCI_OP_WRITE_DEF_LINK_POLICY, 2, &policy);
> > -     return 0;
> > -}
> > -
> >  /* Get HCI device by index.
> >   * Device is held on return. */
> >  struct hci_dev *hci_dev_get(int index)
> > @@ -735,6 +691,7 @@ int hci_dev_cmd(unsigned int cmd, void __user *arg)
> >  {
> >       struct hci_dev *hdev;
> >       struct hci_dev_req dr;
> > +     __le16 policy;
> >       int err =3D 0;
> >
> >       if (copy_from_user(&dr, arg, sizeof(dr)))
> > @@ -761,8 +718,8 @@ int hci_dev_cmd(unsigned int cmd, void __user *arg)
> >
> >       switch (cmd) {
> >       case HCISETAUTH:
> > -             err =3D hci_req_sync(hdev, hci_auth_req, dr.dev_opt,
> > -                                HCI_INIT_TIMEOUT, NULL);
> > +             err =3D __hci_cmd_sync_status(hdev, HCI_OP_WRITE_AUTH_ENA=
BLE,
> > +                                         1, &dr.dev_opt, HCI_CMD_TIMEO=
UT);
>
> These probably were intended to use hci_cmd_sync_status that has the
> locking?

Yep, looks like I used the wrong version, I will need to fix that,
thanks for spotting it.

> >               break;
> >
> >       case HCISETENCRYPT:
> > @@ -773,19 +730,23 @@ int hci_dev_cmd(unsigned int cmd, void __user *ar=
g)
> >
> >               if (!test_bit(HCI_AUTH, &hdev->flags)) {
> >                       /* Auth must be enabled first */
> > -                     err =3D hci_req_sync(hdev, hci_auth_req, dr.dev_o=
pt,
> > -                                        HCI_INIT_TIMEOUT, NULL);
> > +                     err =3D __hci_cmd_sync_status(hdev,
> > +                                                 HCI_OP_WRITE_AUTH_ENA=
BLE,
> > +                                                 1, &dr.dev_opt,
> > +                                                 HCI_CMD_TIMEOUT);
> >                       if (err)
> >                               break;
> >               }
> >
> > -             err =3D hci_req_sync(hdev, hci_encrypt_req, dr.dev_opt,
> > -                                HCI_INIT_TIMEOUT, NULL);
> > +             err =3D __hci_cmd_sync_status(hdev, HCI_OP_WRITE_ENCRYPT_=
MODE,
> > +                                         1, &dr.dev_opt,
> > +                                         HCI_CMD_TIMEOUT);
> >               break;
> >
> >       case HCISETSCAN:
> > -             err =3D hci_req_sync(hdev, hci_scan_req, dr.dev_opt,
> > -                                HCI_INIT_TIMEOUT, NULL);
> > +             err =3D __hci_cmd_sync_status(hdev, HCI_OP_WRITE_SCAN_ENA=
BLE,
> > +                                         1, &dr.dev_opt,
> > +                                         HCI_CMD_TIMEOUT);
> >
> >               /* Ensure that the connectable and discoverable states
> >                * get correctly modified as this was a non-mgmt change.
> > @@ -795,8 +756,11 @@ int hci_dev_cmd(unsigned int cmd, void __user *arg=
)
> >               break;
> >
> >       case HCISETLINKPOL:
> > -             err =3D hci_req_sync(hdev, hci_linkpol_req, dr.dev_opt,
> > -                                HCI_INIT_TIMEOUT, NULL);
> > +             policy =3D cpu_to_le16(dr.dev_opt);
> > +
> > +             err =3D __hci_cmd_sync_status(hdev, HCI_OP_WRITE_DEF_LINK=
_POLICY,
> > +                                         2, &policy,
> > +                                         HCI_CMD_TIMEOUT);
> >               break;
> >
> >       case HCISETLINKMODE:
> > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> > index eff648853ae1..ccad43f10415 100644
> > --- a/net/bluetooth/hci_sync.c
> > +++ b/net/bluetooth/hci_sync.c
> > @@ -280,6 +280,19 @@ int __hci_cmd_sync_status(struct hci_dev *hdev, u1=
6 opcode, u32 plen,
> >  }
> >  EXPORT_SYMBOL(__hci_cmd_sync_status);
> >
> > +int hci_cmd_sync_status(struct hci_dev *hdev, u16 opcode, u32 plen,
> > +                     const void *param, u32 timeout)
> > +{
> > +     int err;
> > +
> > +     hci_req_sync_lock(hdev);
> > +     err =3D __hci_cmd_sync_status(hdev, opcode, plen, param, timeout)=
;
> > +     hci_req_sync_unlock(hdev);
> > +
> > +     return err;
> > +}
> > +EXPORT_SYMBOL(hci_cmd_sync_status);
> > +
> >  static void hci_cmd_sync_work(struct work_struct *work)
> >  {
> >       struct hci_dev *hdev =3D container_of(work, struct hci_dev, cmd_s=
ync_work);
>
> --
> Pauli Virtanen



--=20
Luiz Augusto von Dentz
