Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571AC257B;
	Sat, 21 Sep 2024 01:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726883232; cv=none; b=pFhKoNCjx4hCY6O/6Z9GxLoIODpFW8vAMrZjTy4L8iyZOkqJpYalPQSnT2qJdeUz92rItkrrNAC3kJSk90IYyIvNd+nKWaP45858/VtcMlOwi1ncGy33lU4dFgciR2gqIK/WU6Uy6c6s3ir5vLdd668SPmstvbj7JpIO9lCkeCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726883232; c=relaxed/simple;
	bh=omUdyrJz5osRPwJqsMBoIH/LTF2YXFcsMDuwMsRC1+E=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KiW8kFrFBzrAFJZhdFinZQ4GFOOfU6L772XnqEa5r8RM1umbjWkCQQgoGZ61erQmWwe0cq+jmGV8C3A6VWPWeKslNLL2bZ6ZzFkFy+uzEezKFw4/rvlCDvTHBDzwhMCiQPtPA1JzjbHGO4iXn93ZqgjIBsW1U2nhz2Sb7yaEJTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=UI6m4QvX; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="UI6m4QvX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1726883219; bh=i/x0DGw/KxYjUM8BAxxUj6prqrZf45lcbHT0KVJ57YE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UI6m4QvXhYYYzaD1adIgj7C5/ehQL+NI8EUrKSg9pc8GEogdrfDp/3WiooU7DaGZ0
	 e0nBzG2Kwq9mKLXHur4pCqqmbaHgsJXcqeavKr4UusEJTOIhU035BaXm93LCfTlZty
	 vLK3WjTlAPAKRphml8tLRx3IwI+Eqo0YUsNkmlHk=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id A352C206; Sat, 21 Sep 2024 09:40:53 +0800
X-QQ-mid: xmsmtpt1726882853t0xh4e1bh
Message-ID: <tencent_EA71777E46CCD36D236B696043AA444DD705@qq.com>
X-QQ-XMAILINFO: NvH2zBBgt3uT/jFPnVvtskaTrz2TQOnLhyhU/mWNZOCODfnSCnmO0Nq+zhuqhE
	 eGCc3oPSTcdNRBvXA67rrmrFZtRi1yX9YyTkq4B0OiZHsPm/A/gFJxcJvhIEJG3xi9RtUMytfxaq
	 YXe28OO47YSo69TTYjCovQnlQijGrsStCc3IJUHLzVsIxrhW/p9f9dogw5rH0G60Skqwgw8pXFnX
	 l1X0M6eKUhLreX2acY5rKHOuE0JokU+CERskL+990sUwQz3EluiQTJC7rfs9UuFU3AWeHL3GgINm
	 HCrBLjJMtSTC4tW94x+xF0o5ix7x5rZ/yvRQamrn/nkzwhIqDqrPrVNZUvRLY2wpcA4ynxcrKfSr
	 ofl9THxYP6KPWthxwPMNQxhspb+D28f9MdvnAqnepkty7zLJt19gcTkR5hjJb3DwQZvn/1SG/HLx
	 qDwCygQIEFSUOa5n+/rN10H5VvPXDDFbtZLPd4xmnUz2l0Rg031n0vB8rXvMtJNt7LDzu1/33bVj
	 sYhVCl0xdJayXaUjucrIZDLhL4ACvwkAVsxRK0sLzfXLdMvNbxH7zkVqS/9w6SVoPoQpC0BIgNCF
	 1wytXoHujB4Qbycox2uTHbp1BnNV4CDwAx4zhRQu+xJ5GFNHILF5a1lh4QaZwVc9+q9fDGLDjOXd
	 HkfLKiqmO9dYo4i16v6zHjv+nA1o7b4Eu/PfzDcutn+yHS3CiriE9WwZ07xLvwsE7mdwhE95DrVk
	 NDgG/0E2V+TS+/g2f5HHU12mpueYUpNIMrjk9I6/SFwZ5h77bLFHghe1t9bTW9ju70n3Rl0o3URb
	 X7ABp72dvugexEemdBqGNbjXzsfJh68G9IsxYNxh7dYX33ruOSYrBx1f6yqRnFdKbhOaYxZjVhfH
	 3qz0R/1op+wa01pB9F9C20uRBVF0jdrxTwzz66pE+uOOcxlyh3HFu/9Lc8cWnMUtMnVcA7yO13WH
	 d6fWH6/2pE/IpyYMG/mw==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: luiz.dentz@gmail.com
Cc: eadavis@qq.com,
	johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	marcel@holtmann.org,
	syzbot+c12e2f941af1feb5632c@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] Bluetooth/l2cap: Fix uaf in l2cap_connect
Date: Sat, 21 Sep 2024 09:40:52 +0800
X-OQ-MSGID: <20240921014052.1185980-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <CABBYNZJ73acaaO7m8eEk=PSGrSHE+ZxKUEnm3spaDjULRT7ifg@mail.gmail.com>
References: <CABBYNZJ73acaaO7m8eEk=PSGrSHE+ZxKUEnm3spaDjULRT7ifg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 20 Sep 2024 11:07:05 -0400, Luiz Augusto von Dentz wrote:
> On Tue, Sep 10, 2024 at 4:56 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Edward,
> >
> > On Sun, Sep 8, 2024 at 3:22 AM Edward Adam Davis <eadavis@qq.com> wrote:
> > >
> > > [Syzbot reported]
> > > BUG: KASAN: slab-use-after-free in l2cap_connect.constprop.0+0x10d8/0x1270 net/bluetooth/l2cap_core.c:3949
> > > Read of size 8 at addr ffff8880241e9800 by task kworker/u9:0/54
> > >
> > > CPU: 0 UID: 0 PID: 54 Comm: kworker/u9:0 Not tainted 6.11.0-rc6-syzkaller-00268-g788220eee30d #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
> > > Workqueue: hci2 hci_rx_work
> > > Call Trace:
> > >  <TASK>
> > >  __dump_stack lib/dump_stack.c:93 [inline]
> > >  dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
> > >  print_address_description mm/kasan/report.c:377 [inline]
> > >  print_report+0xc3/0x620 mm/kasan/report.c:488
> > >  kasan_report+0xd9/0x110 mm/kasan/report.c:601
> > >  l2cap_connect.constprop.0+0x10d8/0x1270 net/bluetooth/l2cap_core.c:3949
> > >  l2cap_connect_req net/bluetooth/l2cap_core.c:4080 [inline]
> > >  l2cap_bredr_sig_cmd net/bluetooth/l2cap_core.c:4772 [inline]
> > >  l2cap_sig_channel net/bluetooth/l2cap_core.c:5543 [inline]
> > >  l2cap_recv_frame+0xf0b/0x8eb0 net/bluetooth/l2cap_core.c:6825
> > >  l2cap_recv_acldata+0x9b4/0xb70 net/bluetooth/l2cap_core.c:7514
> > >  hci_acldata_packet net/bluetooth/hci_core.c:3791 [inline]
> > >  hci_rx_work+0xaab/0x1610 net/bluetooth/hci_core.c:4028
> > >  process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
> > >  process_scheduled_works kernel/workqueue.c:3312 [inline]
> > >  worker_thread+0x6c8/0xed0 kernel/workqueue.c:3389
> > >  kthread+0x2c1/0x3a0 kernel/kthread.c:389
> > >  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
> > >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> > > ...
> > >
> > > Freed by task 5245:
> > >  kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
> > >  kasan_save_track+0x14/0x30 mm/kasan/common.c:68
> > >  kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
> > >  poison_slab_object+0xf7/0x160 mm/kasan/common.c:240
> > >  __kasan_slab_free+0x32/0x50 mm/kasan/common.c:256
> > >  kasan_slab_free include/linux/kasan.h:184 [inline]
> > >  slab_free_hook mm/slub.c:2256 [inline]
> > >  slab_free mm/slub.c:4477 [inline]
> > >  kfree+0x12a/0x3b0 mm/slub.c:4598
> > >  l2cap_conn_free net/bluetooth/l2cap_core.c:1810 [inline]
> > >  kref_put include/linux/kref.h:65 [inline]
> > >  l2cap_conn_put net/bluetooth/l2cap_core.c:1822 [inline]
> > >  l2cap_conn_del+0x59d/0x730 net/bluetooth/l2cap_core.c:1802
> > >  l2cap_connect_cfm+0x9e6/0xf80 net/bluetooth/l2cap_core.c:7241
> > >  hci_connect_cfm include/net/bluetooth/hci_core.h:1960 [inline]
> > >  hci_conn_failed+0x1c3/0x370 net/bluetooth/hci_conn.c:1265
> > >  hci_abort_conn_sync+0x75a/0xb50 net/bluetooth/hci_sync.c:5583
> > >  abort_conn_sync+0x197/0x360 net/bluetooth/hci_conn.c:2917
> > >  hci_cmd_sync_work+0x1a4/0x410 net/bluetooth/hci_sync.c:328
> > >  process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
> > >  process_scheduled_works kernel/workqueue.c:3312 [inline]
> > >  worker_thread+0x6c8/0xed0 kernel/workqueue.c:3389
> > >  kthread+0x2c1/0x3a0 kernel/kthread.c:389
> > >  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
> > >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> > >
> > > [Analysis]
> > > There was a data race when accessing conn in hci_rx_work and hci_cmd_sync_work.
> > > This is because the hci dev lock was prematurely exited when executing
> > > hci_acldata_macket() in hci_rx_work, which resulted in it being released
> > > by hci_cmd_sync_work when accessing conn outside the lock.
> > >
> > > Reported-and-tested-by: syzbot+c12e2f941af1feb5632c@syzkaller.appspotmail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=c12e2f941af1feb5632c
> > > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > > ---
> > >  net/bluetooth/hci_core.c   | 3 ++-
> > >  net/bluetooth/l2cap_core.c | 2 --
> > >  2 files changed, 2 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > > index f25a21f532aa..4f7b45bb863f 100644
> > > --- a/net/bluetooth/hci_core.c
> > > +++ b/net/bluetooth/hci_core.c
> > > @@ -3776,18 +3776,19 @@ static void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
> > >
> > >         hci_dev_lock(hdev);
> > >         conn = hci_conn_hash_lookup_handle(hdev, handle);
> > > -       hci_dev_unlock(hdev);
> > >
> > >         if (conn) {
> > >                 hci_conn_enter_active_mode(conn, BT_POWER_FORCE_ACTIVE_OFF);
> > >
> > >                 /* Send to upper protocol */
> > >                 l2cap_recv_acldata(conn, skb, flags);
> > > +               hci_dev_unlock(hdev);
> > >                 return;
> > >         } else {
> > >                 bt_dev_err(hdev, "ACL packet for unknown connection handle %d",
> > >                            handle);
> > >         }
> > > +       hci_dev_unlock(hdev);
> >
> > This is sort of risky, we shouldn't be calling this deep into the
> > stack with hci_dev_lock held.
I haven't thought of any better way yet. I understand what you mean, holding
hci_dev_lock for a long time.
At present, it is not impossible to try some strong drugs.
> >
> > >
> > >         kfree_skb(skb);
> > >  }
> > > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > > index 9988ba382b68..b948b0a3b2f2 100644
> > > --- a/net/bluetooth/l2cap_core.c
> > > +++ b/net/bluetooth/l2cap_core.c
> > > @@ -4072,10 +4072,8 @@ static int l2cap_connect_req(struct l2cap_conn *conn,
> > >         if (cmd_len < sizeof(struct l2cap_conn_req))
> > >                 return -EPROTO;
> > >
> > > -       hci_dev_lock(hdev);
> > >         if (hci_dev_test_flag(hdev, HCI_MGMT))
> > >                 mgmt_device_connected(hdev, hcon, NULL, 0);
> > > -       hci_dev_unlock(hdev);
> >
> > So this might explain why things gets freed while processing the
> > request, we are locking to call mgmt_device_connected which I suspect
> > is no longer needed ever since:
> >
> > commit db11223571d489d1aab575a4ac4b7352d2d54e2f
> > Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > Date:   Tue Oct 25 14:12:58 2022 -0700
> >
> >     Bluetooth: btusb: Default CONFIG_BT_HCIBTUSB_POLL_SYNC=y
> >
> >     poll_sync has been proven to fix races of USB data and event endpoints
> >     so this enables it by default.
> >
> >     Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >     Tested-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> >
> > Anyway syzbot don't use btusb so I think this might be due some
> > command pending that the emulator is not responding and instead
> > sending data, and then there is the issue that 7b064edae38d
> > ("Bluetooth: Fix authentication if acl data comes before remote
> > feature evt") attempted to fix which I think it actually made it worse
> > by moving the call to mgmt_device_connected into l2cap_core.c it sort
> > move the problem but didn't fix the actual problem.
I think 7B064edae38d is used to solve another issue.
> >
> > Maybe something like the following would be a better approach:
> >
> > https://gist.github.com/Vudentz/121a15fa4391b2b1f6c7e8d420a6846e
> 
> Any comments? Are you still planning to work on this?
Sorry for late.
> 
> > >
> > >         l2cap_connect(conn, cmd, data, L2CAP_CONN_RSP);
> > >         return 0;
> > > --
> > > 2.43.0
> > >
> >
> >
> > --
> > Luiz Augusto von Dentz

BR,
Edward

