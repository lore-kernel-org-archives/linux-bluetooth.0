Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 38D3018411D
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jun 2024 14:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719410637; cv=none; b=p0SUHiG2yj5QujoePOYyqcCWHGc/5zkowloJPEZ3WHKgkX9itJJILh1N02kmSmSbOf+d/QUlt82nhlJTqgyUnjmnzvEB++1oE4IKmkGnHwmnDtc+bmloJs1Iif+7PyCNnN137etPPXMcjiAv3ZDvkjnoP4DzIL8srh7u5YpaWn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719410637; c=relaxed/simple;
	bh=yr2QGq2m6+l2KCUiEbPTHrb0Ln1dcGbH+U8081HMkEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=osyU4Zxsm3wDqPvc5PsJQ3+MOZxR7RnfvUSQtiyNYADWE5AfbgwsOQBH2GBBltzBw6x1ODs2HtAX3s2aXj49aaS05m6ioe5mw7BJ3p7NvrsDpMHT80u3tHzgHodQ8EHVGWfhSwM11UMcGpaiXK6En7Z7NRBx6Suvc1t8Z+QEayI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 704924 invoked by uid 1000); 26 Jun 2024 10:03:54 -0400
Date: Wed, 26 Jun 2024 10:03:54 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: syzbot <syzbot+8693a0bb9c10b554272a@syzkaller.appspotmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
  linux-usb@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org,
  syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] [bluetooth?] WARNING in
 btusb_submit_intr_urb/usb_submit_urb
Message-ID: <a6eb3c4e-411f-4fbf-a85c-f3435170341d@rowland.harvard.edu>
References: <0000000000003d868e061bc0f554@google.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000003d868e061bc0f554@google.com>

On Tue, Jun 25, 2024 at 06:30:22PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    66cc544fd75c Merge tag 'dmaengine-fix-6.10' of git://git.k..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=14280161980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3f7b9f99610e0e87
> dashboard link: https://syzkaller.appspot.com/bug?extid=8693a0bb9c10b554272a
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16f59c82980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12b955b6980000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/b4d37fd1f3c8/disk-66cc544f.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/04c8b576cea2/vmlinux-66cc544f.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/05e217dc3c31/bzImage-66cc544f.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+8693a0bb9c10b554272a@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> usb 1-1: BOGUS urb xfer, pipe 1 != type 3
> WARNING: CPU: 0 PID: 4491 at drivers/usb/core/urb.c:504 usb_submit_urb+0xc4e/0x18c0 drivers/usb/core/urb.c:503
> Modules linked in:
> CPU: 0 PID: 4491 Comm: kworker/u9:1 Not tainted 6.10.0-rc4-syzkaller-00164-g66cc544fd75c #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
> Workqueue: hci0 hci_power_on
> RIP: 0010:usb_submit_urb+0xc4e/0x18c0 drivers/usb/core/urb.c:503
> Code: f8 48 c1 e8 03 0f b6 04 18 84 c0 0f 85 b1 08 00 00 45 8b 07 48 c7 c7 40 90 6d 8c 48 8b 34 24 4c 89 e2 89 e9 e8 23 9a 3c fa 90 <0f> 0b 90 90 48 8b 5c 24 30 41 89 dc 4c 89 e7 48 c7 c6 b0 4b f2 8e
> RSP: 0018:ffffc9000d817798 EFLAGS: 00010246
> RAX: 6d750bdfc6b7f400 RBX: dffffc0000000000 RCX: ffff888030053c00
> RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
> RBP: 0000000000000001 R08: ffffffff81585822 R09: fffffbfff1c39994
> R10: dffffc0000000000 R11: fffffbfff1c39994 R12: ffff88801c2e7560
> R13: ffff88801a2af400 R14: 0000000000000001 R15: ffffffff8c6d8e28
> FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000559f0e1c6bd8 CR3: 000000002e10e000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  btusb_submit_intr_urb+0x3dd/0x7b0 drivers/bluetooth/btusb.c:1409

This shouldn't happen.  The driver takes care to verify the types of the 
endpoints it uses.  Let's add some debugging info.

Alan Stern

#syz test: upstream 66cc544fd75c

Index: usb-devel/drivers/bluetooth/btusb.c
===================================================================
--- usb-devel.orig/drivers/bluetooth/btusb.c
+++ usb-devel/drivers/bluetooth/btusb.c
@@ -1398,6 +1398,7 @@ static int btusb_submit_intr_urb(struct
 	}
 
 	pipe = usb_rcvintpipe(data->udev, data->intr_ep->bEndpointAddress);
+	dev_info(&data->intf->dev, "Pipe %x ep %p\n", pipe, data->intr_ep);
 
 	usb_fill_int_urb(urb, data->udev, pipe, buf, size,
 			 btusb_intr_complete, hdev, data->intr_ep->bInterval);
@@ -4283,6 +4284,9 @@ static int btusb_probe(struct usb_interf
 
 		if (!data->intr_ep && usb_endpoint_is_int_in(ep_desc)) {
 			data->intr_ep = ep_desc;
+			dev_info(&intf->dev, "Ep %p epaddr %x epattr %x\n",
+					ep_desc, ep_desc->bEndpointAddress,
+					ep_desc->bmAttributes);
 			continue;
 		}
 
Index: usb-devel/drivers/usb/core/urb.c
===================================================================
--- usb-devel.orig/drivers/usb/core/urb.c
+++ usb-devel/drivers/usb/core/urb.c
@@ -208,8 +208,11 @@ int usb_pipe_type_check(struct usb_devic
 	ep = usb_pipe_endpoint(dev, pipe);
 	if (!ep)
 		return -EINVAL;
-	if (usb_pipetype(pipe) != pipetypes[usb_endpoint_type(&ep->desc)])
+	if (usb_pipetype(pipe) != pipetypes[usb_endpoint_type(&ep->desc)]) {
+		dev_info(&dev->dev, "Error pipe %x ep %p epaddr %x\n",
+				pipe, &ep->desc, ep->desc.bEndpointAddress);
 		return -EINVAL;
+	}
 	return 0;
 }
 EXPORT_SYMBOL_GPL(usb_pipe_type_check);

