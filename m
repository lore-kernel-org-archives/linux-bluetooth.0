Return-Path: <cyrus@holtmann.org>
Date: Mon, 14 Feb 2011 15:25:16 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Vladislav P <vladisslav@inbox.ru>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: rfcomm: Release BTM while sleeping to avoid
 deadlock.
Message-ID: <20110214172516.GF2597@joana>
References: <E1PoQLR-0008E5-00.vladisslav-inbox-ru@f68.mail.ru>
 <20110214144931.GD2597@joana>
 <E1Pp0gh-0002s9-00.vladisslav-inbox-ru@f95.mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <E1Pp0gh-0002s9-00.vladisslav-inbox-ru@f95.mail.ru>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vladislav,

* Vladislav P <vladisslav@inbox.ru> [2011-02-14 18:50:07 +0300]:

> Mon, 14 Feb 2011 12:49:31 -0200 письмо от "Gustavo F. Padovan" <padovan@profusion.mobi>:
> 
> > Hi 
> > 
> > * Владислав <vladisslav@inbox.ru> [2011-02-13 04:01:45 +0300]:
> > 
> > > Bug description:
> > > Kernel freezes for ~2 seconds after trying to access /dev/rfcommX device.
> > > Steps to reproduce:
> > > 1. Edit /etc/bluetooth/rfcomm.conf - uncomment default config, set "bind" to
> > "yes".
> > > 2. Issue "sudo rfcomm bind all" to create /dev/rfcomm0 device node.
> > > 3. Issue "cat /dev/rfcomm0" to trigger a bug.
> > > Everything freezes (at least GUI): cursor does not move, no response from
> > > keypresses, no gui redraw for 2~3 seconds.
> > > Then cat displays expected error message "cat: /dev/rfcomm0: Host is down"
> > > and system starts to respond again.
> > > What expected (and occurs with 2.6.35) : no freeze between cat and error
> > message.
> > > Things goes worse when device, mentioned in /etc/bluetooth/rfcomm.conf
> > > is in range and not paired - system displays pairing request and locks
> > > up for a longer time, maybe completely - I did not wait longer than ~30
> > > seconds and turned off bluetooth device.
> > 
> > I've faced this issue some days ago and your patch looks good. But I need
> > proper git patch with your Signed-off-by line.
> > 
> > -- 
> > Gustavo F. Padovan
> > http://profusion.mobi
> Made proper patch:
> 
> From d1459f3042b4b8cdea1f1a184eb61f7be4002203 Mon Sep 17 00:00:00 2001
> From: Vladislav P <vladisslav@inbox.ru>
> Date: Mon, 14 Feb 2011 18:42:27 +0300
> Subject: [PATCH] Release BTM while sleeping to avoid deadlock.
> 
> Signed-off-by: Vladislav P <vladisslav@inbox.ru>
> ---
>  net/bluetooth/rfcomm/tty.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)

Applied, thanks.

-- 
Gustavo F. Padovan
http://profusion.mobi
