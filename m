Return-Path: <cyrus@holtmann.org>
Date: Thu, 11 Jul 2013 13:03:05 +0100
From: Gustavo Padovan <gustavo@padovan.org>
To: Sedat Dilek <sedat.dilek@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: Re: [PATCH] Bluetooth: Fix race between hci_register_dev() and
 hci_dev_open()
Message-ID: <20130711120305.GA551@joana>
References: <1373541591-9529-1-git-send-email-gustavo@padovan.org>
 <CA+icZUU8Xin-UapmBObQPt7kidek4GZusV1+fqYBMtvfoKKcmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA+icZUU8Xin-UapmBObQPt7kidek4GZusV1+fqYBMtvfoKKcmQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sedat,

* Sedat Dilek <sedat.dilek@gmail.com> [2013-07-11 13:26:44 +0200]:

> On Thu, Jul 11, 2013 at 1:19 PM, Gustavo Padovan <gustavo@padovan.org> wrote:
> > From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> >
> > If hci_dev_open() is called after hci_register_dev() added the device to
> > the hci_dev_list but before the workqueue are created we could run into a
> > NULL pointer dereference (showed in the crash below).
> >
> 
> That sentense is hard to follow.
> 
> s/showed in the crash below/see below
> 
> > This is bug that is very unlikely to happen, systems using bluetoothd to
> > manage their bluetooth devices will never see this happens.
> >
> 
> What about:
> "This bug is very unlikely to happen. Systems... will never see this happen."

Thank you for those suggestions, I'm not a native English speaker, so I still
do a lot of mistakes.

> 
> > BUG: unable to handle kernel NULL pointer dereference
> > 0100
> > IP: [<ffffffff81077502>] __queue_work+0x32/0x3d0
> > (...)
> > Call Trace:
> >  [<ffffffff81077be5>] queue_work_on+0x45/0x50
> >  [<ffffffffa016e8ff>] hci_req_run+0xbf/0xf0 [bluetooth]
> >  [<ffffffffa01709b0>] ? hci_init2_req+0x720/0x720 [bluetooth]
> >  [<ffffffffa016ea06>] __hci_req_sync+0xd6/0x1c0 [bluetooth]
> >  [<ffffffff8108ee10>] ? try_to_wake_up+0x2b0/0x2b0
> >  [<ffffffff8150e3f0>] ? usb_autopm_put_interface+0x30/0x40
> >  [<ffffffffa016fad5>] hci_dev_open+0x275/0x2e0 [bluetooth]
> >  [<ffffffffa0182752>] hci_sock_ioctl+0x1f2/0x3f0 [bluetooth]
> >  [<ffffffff815c6050>] sock_do_ioctl+0x30/0x70
> >  [<ffffffff815c75f9>] sock_ioctl+0x79/0x2f0
> >  [<ffffffff811a8046>] do_vfs_ioctl+0x96/0x560
> >  [<ffffffff811a85a1>] SyS_ioctl+0x91/0xb0
> >  [<ffffffff816d989d>] system_call_fastpath+0x1a/0x1f
> >
> 
> Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> 
> Still-untested-by: ... (AFAICS it was hard to reproduce.)

I'll probably push this patch anyway, it is a simple change and can't cause
any regressions.

	Gustavo
