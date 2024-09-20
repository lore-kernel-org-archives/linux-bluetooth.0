Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C7317C9B9;
	Fri, 20 Sep 2024 15:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726844843; cv=none; b=cwkT2PJwzO6ZpCmYAv183dznHFkhVQI79c+vxqzskbYy2vDR3AbToBeeGwCtBgDyCtqVMz/WM/uZ07Q8KA2Qp2fKYEio2mweyg41flLOGYR3MZVxTMZcH9iMqPsoOK1+Oz4BShlfaUEaLtO4gVegGWcrwLADQ7EQ8iEFx91Q1k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726844843; c=relaxed/simple;
	bh=db4/tSHXoH1UdpzgDOTz6GUrVd6tjuvc2m/wUEeGt7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LXt7hhX/gdwvVJCtHFzluwD/I2r9quSyDYDYGD1fOyWOeXhElG0kOONZwUAjYlt7yoC8rlE6Ntc0PEnSJZR4WVQ5cvE1CEhOtOlgq+oJ72eiFxTkOBUuUxAVrJGqxroGwl6PDp1+pEW+47lcvTTlkZQtsaltTQ+mIDfYFYfZvEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A6jRPaNh; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6jRPaNh"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f75e5f3debso20748381fa.1;
        Fri, 20 Sep 2024 08:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726844839; x=1727449639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QoV1uk/hwI46jJLz2GVKJptOnI0KTXoCw3Oho/Pn9Q8=;
        b=A6jRPaNh/dvADikOmOOLoLtA28NOZxDlz81Nvmz4kgeP2i5ZagRBDmOlnJuFRWN9M6
         Z018QANuH0cZQ/HLoLuN41uSwbB7RGx8OIgcK2ONC3XtFFGrZjApG6WolFVIsBxJKiXK
         cbv3/8wlPFd8MK59uN0gcbKe5LsNoIiV36JpSr7oEoD+wbFJw4z8u/DR59E4gbwBeWpZ
         mCOj+1a/k8ZHfiBax+0+KPxiMPe1D16EO6KUek7+gzGGTum+pWjZBhUjt1GL5WDV1eIo
         sUdq8iLXXf9r3Jk5fqYVNPkBQLXWuF8obsn7S6OKBDquchQqBXk9vjZXCBO0ntV7cFMu
         9xbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726844839; x=1727449639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QoV1uk/hwI46jJLz2GVKJptOnI0KTXoCw3Oho/Pn9Q8=;
        b=CdoOgmmWcdWbttSoUUriYb9AMNAicX7xh2i7nRNfUOz+OInSxlvR/pxi53z0pq8mBG
         2q/NrfeUyuAjQ3BGSeUKLF9zfeI8dPrIR/YcRJG6lsxTzEvMQeN/LgHWeFPr5BDORR0a
         xP+C/orhVlhBO8cHuDVlBgUi+6IfKEr2oQlwK06CuvWbtuAakBuSf3HFb09INLhkg/mN
         ue8oGerLE112tYYyKiGxvW4qgw7JWOmIiVqhW0gWo8ijJqQugbJhRthDaZ/0JZVC4A7D
         wMQV4qCMlUTm7MaYy6Riz8GcVn0eoenZSUg5sWoi0DCrkys2N33gXu+zein/dNgzhdPt
         3kFQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4FsdYIdSQmG6HYHplSz2wVWwPXa352IpLc1F5a/d21EXm8VOJD0rXML9gedypUjt/+94HccAE+PZBMRDOQ4s=@vger.kernel.org, AJvYcCWEC2eXp2c0Zap6ek6KRmk+3gf4aeDDBBpxbqfP8EDq7Oo3O6lQ5NuhPiUbay3yffXChE/OtiqbCIDs8EnK@vger.kernel.org
X-Gm-Message-State: AOJu0YyWDcLOslStMSUGhtul4QrGZHDnFwK4QyHh1VoAMgqlcUTalB0L
	u2jUBn/38Hu0K2ryru9UPZbcgRbNnMRpoadDM4CSn2hGiEMyENlsH17V5W0QW7K+PhR6oEuPfCd
	5lKoid1zsV2vVpFCtUmJb6UkXHvA=
X-Google-Smtp-Source: AGHT+IGM1wmeYjQSNYOnz1oIqTCD8I4u4xH0jHOr3PZLP/sVbivkR0OkTuEGrHTHf0u5FkNFUWG4Vow8XNfWvAe2lPI=
X-Received: by 2002:a2e:719:0:b0:2f6:4cc0:5438 with SMTP id
 38308e7fff4ca-2f7cb32934fmr16399561fa.29.1726844839030; Fri, 20 Sep 2024
 08:07:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000004a130a0621888811@google.com> <tencent_7697B4E9DEEC52CEB478626D182DE96CB00A@qq.com>
 <CABBYNZLnohZofm4Tchk7p36XS=HwYmN94DB0FGyiPFJno+evSw@mail.gmail.com>
In-Reply-To: <CABBYNZLnohZofm4Tchk7p36XS=HwYmN94DB0FGyiPFJno+evSw@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 20 Sep 2024 11:07:05 -0400
Message-ID: <CABBYNZJ73acaaO7m8eEk=PSGrSHE+ZxKUEnm3spaDjULRT7ifg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth/l2cap: Fix uaf in l2cap_connect
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+c12e2f941af1feb5632c@syzkaller.appspotmail.com, 
	johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Edward,

On Tue, Sep 10, 2024 at 4:56=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Edward,
>
> On Sun, Sep 8, 2024 at 3:22=E2=80=AFAM Edward Adam Davis <eadavis@qq.com>=
 wrote:
> >
> > [Syzbot reported]
> > BUG: KASAN: slab-use-after-free in l2cap_connect.constprop.0+0x10d8/0x1=
270 net/bluetooth/l2cap_core.c:3949
> > Read of size 8 at addr ffff8880241e9800 by task kworker/u9:0/54
> >
> > CPU: 0 UID: 0 PID: 54 Comm: kworker/u9:0 Not tainted 6.11.0-rc6-syzkall=
er-00268-g788220eee30d #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 08/06/2024
> > Workqueue: hci2 hci_rx_work
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:93 [inline]
> >  dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
> >  print_address_description mm/kasan/report.c:377 [inline]
> >  print_report+0xc3/0x620 mm/kasan/report.c:488
> >  kasan_report+0xd9/0x110 mm/kasan/report.c:601
> >  l2cap_connect.constprop.0+0x10d8/0x1270 net/bluetooth/l2cap_core.c:394=
9
> >  l2cap_connect_req net/bluetooth/l2cap_core.c:4080 [inline]
> >  l2cap_bredr_sig_cmd net/bluetooth/l2cap_core.c:4772 [inline]
> >  l2cap_sig_channel net/bluetooth/l2cap_core.c:5543 [inline]
> >  l2cap_recv_frame+0xf0b/0x8eb0 net/bluetooth/l2cap_core.c:6825
> >  l2cap_recv_acldata+0x9b4/0xb70 net/bluetooth/l2cap_core.c:7514
> >  hci_acldata_packet net/bluetooth/hci_core.c:3791 [inline]
> >  hci_rx_work+0xaab/0x1610 net/bluetooth/hci_core.c:4028
> >  process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
> >  process_scheduled_works kernel/workqueue.c:3312 [inline]
> >  worker_thread+0x6c8/0xed0 kernel/workqueue.c:3389
> >  kthread+0x2c1/0x3a0 kernel/kthread.c:389
> >  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
> >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> > ...
> >
> > Freed by task 5245:
> >  kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
> >  kasan_save_track+0x14/0x30 mm/kasan/common.c:68
> >  kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
> >  poison_slab_object+0xf7/0x160 mm/kasan/common.c:240
> >  __kasan_slab_free+0x32/0x50 mm/kasan/common.c:256
> >  kasan_slab_free include/linux/kasan.h:184 [inline]
> >  slab_free_hook mm/slub.c:2256 [inline]
> >  slab_free mm/slub.c:4477 [inline]
> >  kfree+0x12a/0x3b0 mm/slub.c:4598
> >  l2cap_conn_free net/bluetooth/l2cap_core.c:1810 [inline]
> >  kref_put include/linux/kref.h:65 [inline]
> >  l2cap_conn_put net/bluetooth/l2cap_core.c:1822 [inline]
> >  l2cap_conn_del+0x59d/0x730 net/bluetooth/l2cap_core.c:1802
> >  l2cap_connect_cfm+0x9e6/0xf80 net/bluetooth/l2cap_core.c:7241
> >  hci_connect_cfm include/net/bluetooth/hci_core.h:1960 [inline]
> >  hci_conn_failed+0x1c3/0x370 net/bluetooth/hci_conn.c:1265
> >  hci_abort_conn_sync+0x75a/0xb50 net/bluetooth/hci_sync.c:5583
> >  abort_conn_sync+0x197/0x360 net/bluetooth/hci_conn.c:2917
> >  hci_cmd_sync_work+0x1a4/0x410 net/bluetooth/hci_sync.c:328
> >  process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
> >  process_scheduled_works kernel/workqueue.c:3312 [inline]
> >  worker_thread+0x6c8/0xed0 kernel/workqueue.c:3389
> >  kthread+0x2c1/0x3a0 kernel/kthread.c:389
> >  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
> >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> >
> > [Analysis]
> > There was a data race when accessing conn in hci_rx_work and hci_cmd_sy=
nc_work.
> > This is because the hci dev lock was prematurely exited when executing
> > hci_acldata_macket() in hci_rx_work, which resulted in it being release=
d
> > by hci_cmd_sync_work when accessing conn outside the lock.
> >
> > Reported-and-tested-by: syzbot+c12e2f941af1feb5632c@syzkaller.appspotma=
il.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3Dc12e2f941af1feb5632c
> > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > ---
> >  net/bluetooth/hci_core.c   | 3 ++-
> >  net/bluetooth/l2cap_core.c | 2 --
> >  2 files changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > index f25a21f532aa..4f7b45bb863f 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -3776,18 +3776,19 @@ static void hci_acldata_packet(struct hci_dev *=
hdev, struct sk_buff *skb)
> >
> >         hci_dev_lock(hdev);
> >         conn =3D hci_conn_hash_lookup_handle(hdev, handle);
> > -       hci_dev_unlock(hdev);
> >
> >         if (conn) {
> >                 hci_conn_enter_active_mode(conn, BT_POWER_FORCE_ACTIVE_=
OFF);
> >
> >                 /* Send to upper protocol */
> >                 l2cap_recv_acldata(conn, skb, flags);
> > +               hci_dev_unlock(hdev);
> >                 return;
> >         } else {
> >                 bt_dev_err(hdev, "ACL packet for unknown connection han=
dle %d",
> >                            handle);
> >         }
> > +       hci_dev_unlock(hdev);
>
> This is sort of risky, we shouldn't be calling this deep into the
> stack with hci_dev_lock held.
>
> >
> >         kfree_skb(skb);
> >  }
> > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > index 9988ba382b68..b948b0a3b2f2 100644
> > --- a/net/bluetooth/l2cap_core.c
> > +++ b/net/bluetooth/l2cap_core.c
> > @@ -4072,10 +4072,8 @@ static int l2cap_connect_req(struct l2cap_conn *=
conn,
> >         if (cmd_len < sizeof(struct l2cap_conn_req))
> >                 return -EPROTO;
> >
> > -       hci_dev_lock(hdev);
> >         if (hci_dev_test_flag(hdev, HCI_MGMT))
> >                 mgmt_device_connected(hdev, hcon, NULL, 0);
> > -       hci_dev_unlock(hdev);
>
> So this might explain why things gets freed while processing the
> request, we are locking to call mgmt_device_connected which I suspect
> is no longer needed ever since:
>
> commit db11223571d489d1aab575a4ac4b7352d2d54e2f
> Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> Date:   Tue Oct 25 14:12:58 2022 -0700
>
>     Bluetooth: btusb: Default CONFIG_BT_HCIBTUSB_POLL_SYNC=3Dy
>
>     poll_sync has been proven to fix races of USB data and event endpoint=
s
>     so this enables it by default.
>
>     Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>     Tested-by: Tedd Ho-Jeong An <tedd.an@intel.com>
>
> Anyway syzbot don't use btusb so I think this might be due some
> command pending that the emulator is not responding and instead
> sending data, and then there is the issue that 7b064edae38d
> ("Bluetooth: Fix authentication if acl data comes before remote
> feature evt") attempted to fix which I think it actually made it worse
> by moving the call to mgmt_device_connected into l2cap_core.c it sort
> move the problem but didn't fix the actual problem.
>
> Maybe something like the following would be a better approach:
>
> https://gist.github.com/Vudentz/121a15fa4391b2b1f6c7e8d420a6846e

Any comments? Are you still planning to work on this?

> >
> >         l2cap_connect(conn, cmd, data, L2CAP_CONN_RSP);
> >         return 0;
> > --
> > 2.43.0
> >
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
