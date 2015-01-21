Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: bluetooth-next tree compilation error
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAEUmHyata35dg_=CMWau0AhjVwFU-cJT1eVyBsgpDHYRMp5uzw@mail.gmail.com>
Date: Tue, 20 Jan 2015 21:19:46 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <A73F36CA-2DD1-4EBE-A08F-E3CD0CC63ECA@holtmann.org>
References: <CAEUmHyata35dg_=CMWau0AhjVwFU-cJT1eVyBsgpDHYRMp5uzw@mail.gmail.com>
To: Varka Bhadram <varkabhadram@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Varka,

> I am getting compilation error with bluetooth-next tree. No problem
> with net-next tree.
> ...
> CC      drivers/net/ethernet/ti/cpsw.o
> drivers/net/ethernet/ti/cpsw.c: In function ‘cpsw_ndo_poll_controller’:
> drivers/net/ethernet/ti/cpsw.c:1635:24: error: ‘struct cpsw_priv’ has
> no member named ‘irq’
> drivers/net/ethernet/ti/cpsw.c:1636:24: error: ‘struct cpsw_priv’ has
> no member named ‘irq’
> make[4]: *** [drivers/net/ethernet/ti/cpsw.o] Error 1
> make[3]: *** [drivers/net/ethernet/ti] Error 2
> make[2]: *** [drivers/net/ethernet] Error 2
> make[1]: *** [drivers/net] Error 2
> make: *** [drivers] Error 2

this is obviously not our fault. However just in case I pulled net-next into bluetooth-next now.

Regards

Marcel

