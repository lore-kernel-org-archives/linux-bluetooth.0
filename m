Received: from forward501d.mail.yandex.net (forward501d.mail.yandex.net [178.154.239.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14E3168483
	for <linux-bluetooth@vger.kernel.org>; Sat,  2 Nov 2024 09:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730541486; cv=none; b=iFZ2szVNsHUtQHwcjA5XY2tpCm3QQ0gcwKNH7XlGQtkySJV4ngQW2nWeLS2DgyYaisb6cKY9I/SZ/W2kCaN80PpIs6iCT0s9M6aAXqbiqVmLAVDIIV5Tuv7cfIt8Dy9QVd1po23e9tVsbf5xlfuYe4kK+y0QgDEJItYSHqD3wEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730541486; c=relaxed/simple;
	bh=We5jE/V8SrH9AdGWjHUD3VzAfKTmsiBpz3742DFPMuI=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=oXknUwF9CqqlvpgupasOAuaCOh/ZVQBbQaTzoed70D5Hy1T1cZkO6KL961s8dIa7+s8rwFB4u1fZ9mt1L8RbMstiVr5qgNWV8GwHAlID/LJD6SL1P5XCFVfFOzX8HFlNNpr3HFC4uhwutWKwCudw3b6zZgbewWK82R5Oh2vYvlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=sHpd/Q6D; arc=none smtp.client-ip=178.154.239.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="sHpd/Q6D"
Received: from mail-nwsmtp-smtp-production-main-91.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-91.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:500f:0:640:e3f2:0])
	by forward501d.mail.yandex.net (Yandex) with ESMTPS id 80B21613FB;
	Sat,  2 Nov 2024 12:51:57 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-91.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id upZ7hndOf0U0-1xHjLVCy;
	Sat, 02 Nov 2024 12:51:56 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1730541116; bh=bPA3mcyit10cM+BXGLDzcnk/vKOd2+tZkb1+SBmYoL8=;
	h=In-Reply-To:Subject:To:From:Cc:Date:References:Message-ID;
	b=sHpd/Q6DE+ympc+jPJo/N7haNETUwm9OIcB6q1QA04wUsXcESbwAL0+AoUKDxupgn
	 3MJJ01z6ZT2+W5Uh70771XcgWGrJej+skqS4ZRn/gcTs/V5drsovO0de6zw1cZdfoY
	 S3aG4L0yxpqm+EwKHFmWnpJ9gGiB9PDK9VWMQ1pc=
Authentication-Results: mail-nwsmtp-smtp-production-main-91.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <2554961e-37b3-477a-8a78-724dfb092c02@yandex.ru>
Date: Sat, 2 Nov 2024 12:51:56 +0300
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org,
 lvc-project@linuxtesting.org,
 syzbot+6cf5652d3df49fae2e3f@syzkaller.appspotmail.com
References: <20241101114410.234311-1-dmantipov@yandex.ru>
 <CABBYNZK=H9JtzaQudQ1b7TGU5VaJ_qX_bbSJhKSwWKh+5_1uUQ@mail.gmail.com>
 <5cc24ab9-80c0-4280-8c4c-d8b052524e1d@yandex.ru>
 <CABBYNZKvP3u+7juqNNUHOS0PTb=QVzxob+rC3PVq-XXu9vGU+A@mail.gmail.com>
 <fe1588ee-1f00-429c-a917-d1c5e08f3831@yandex.ru>
 <CABBYNZJiYHWgtBExZ2jbuemJdyo6inpiYMGF7qc9Xbjqu__L7w@mail.gmail.com>
 <CABBYNZJXMyJ0bjVAe=sY+zonvFwS2Eh2wiSuzGd+a6U-3-8=fg@mail.gmail.com>
Content-Language: en-MW
From: Dmitry Antipov <dmantipov@yandex.ru>
Autocrypt: addr=dmantipov@yandex.ru; keydata=
 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
 A/UwwXBRuvydGV0=
Subject: Re: [PATCH v2] Bluetooth: fix use-after-free in
 device_for_each_child()
In-Reply-To: <CABBYNZJXMyJ0bjVAe=sY+zonvFwS2Eh2wiSuzGd+a6U-3-8=fg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/1/24 8:37 PM, Luiz Augusto von Dentz wrote:

> Looks like this doesn't solve the problem, in fact I think you are
> getting it backwards, you are trying to reparent the parent dev not
> the child and I assume by destroying the parent device there should be
> some way to reset the parent which seems to be the intent the
> following code in hci_conn_del_sysfs:
> 
>      while (1) {
>          struct device *dev;
> 
>          dev = device_find_child(&conn->dev, NULL, __match_tty);
>          if (!dev)
>              break;
>          device_move(dev, NULL, DPM_ORDER_DEV_LAST);
>          put_device(dev);
>      }
> 
> But note that it only does that after matching tty, but I guess we
> want to do it regardless otherwise we may have the child objects still
> access it, that said we should probably use device_for_each_child
> though if that is safe to do calls to device_move under its callback.

I'm not sure that I've got your point. IIUC the problem is that a controller
(parent) instance may be freed _after_ the child (connection) has passed
'device_unregister(&conn->dev)' but _before_ an actual removal of 'conn->dev'
from the devices hierarchy, thus leaving the dangling 'conn->dev.parent'
pointer. The latter may be fixed by reparenting 'conn->dev' to NULL explicitly.
And handling children of 'conn->dev' (i.e. the grandchilren of the controller)
is out of this problem's scope at all.

And nothing to say about syzbot's innards but manual testing shows that the
following thing:

void hci_conn_del_sysfs(struct hci_conn *conn)
{
         struct hci_dev *hdev = conn->hdev;

         bt_dev_dbg(hdev, "conn %p", conn);

         if (!device_is_registered(&conn->dev)) {
                 /* If device_add() has *not* succeeded, use *only* put_device()
                  * to drop the reference count.
                  */
                 put_device(&conn->dev);
                 return;
         }

         while (1) {
                 struct device *dev;

                 dev = device_find_any_child(&conn->dev);
                 if (!dev)
                         break;
                 printk(KERN_ERR "%s:%d: reparent dev@%p(%s) with parent@%p(%s)\n",
                        __FILE__, __LINE__, dev, dev_name(dev), dev->parent,
                        (dev->parent ? dev_name(dev->parent) : "<none>"));
                 device_move(dev, NULL, DPM_ORDER_DEV_LAST);
                 put_device(dev);
         }

         device_unregister(&conn->dev);
}

occasionally triggers the following crash:

net/bluetooth/hci_sysfs.c:82: reparent dev@ffff888114be86f8(bnep0) with parent@ffff888111c64b68(hci4:200)
Oops: general protection fault, probably for non-canonical address 0xdffffc000000000b: 0000 [#1] PREEMPT SMP KASI
KASAN: null-ptr-deref in range [0x0000000000000058-0x000000000000005f]
CPU: 3 UID: 0 PID: 6033 Comm: repro Not tainted 6.12.0-rc5-00299-g11066801dd4b-dirty #8
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-3.fc41 04/01/2014
RIP: 0010:klist_put+0x4d/0x1d0
Code: c1 ea 03 80 3c 02 00 0f 85 74 01 00 00 48 b8 00 00 00 00 00 fc ff df 4c 8b 23 49 83 e4 fe 49 8d 7c 24 58 49
RSP: 0018:ffffc9000423f9b0 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff88810f43ac60 RCX: 0000000000000000
RDX: 000000000000000b RSI: ffffffff8a92d415 RDI: 0000000000000058
RBP: 0000000000000001 R08: 0000000000000000 R09: fffffbfff1fad62c
R10: ffffffff8fd6b163 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000001 R14: ffffc9000423fa30 R15: ffffffff8a92d805
FS:  00007f24ebb78740(0000) GS:ffff888135f00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055c52afb6950 CR3: 0000000020c1c000 CR4: 00000000000006f0
Call Trace:
  <TASK>
  ? die_addr.cold+0x8/0xd
  ? exc_general_protection+0x147/0x240
  ? asm_exc_general_protection+0x26/0x30
  ? klist_remove+0x155/0x2b0
  ? klist_put+0x15/0x1d0
  ? klist_put+0x4d/0x1d0
  klist_remove+0x15a/0x2b0
  ? __pfx_klist_remove+0x10/0x10
  device_move+0x12d/0x10b0
  hci_conn_del_sysfs.cold+0xcf/0x14a
  hci_conn_del+0x467/0xd60
  hci_conn_hash_flush+0x18f/0x270
  hci_dev_close_sync+0x549/0x1260
  hci_dev_do_close+0x2e/0x90
  hci_unregister_dev+0x213/0x630
  vhci_release+0x79/0xf0
  ? __pfx_vhci_release+0x10/0x10
  __fput+0x3f6/0xb30
  task_work_run+0x151/0x250
  ? __pfx_task_work_run+0x10/0x10
  do_exit+0xa79/0x2c30
  ? do_raw_spin_lock+0x12a/0x2b0
  ? __pfx_do_exit+0x10/0x10
  do_group_exit+0xd5/0x2a0
  __x64_sys_exit_group+0x3e/0x50
  x64_sys_call+0x14af/0x14b0
  do_syscall_64+0xc7/0x250
  entry_SYSCALL_64_after_hwframe+0x77/0x7f

Dmitry
