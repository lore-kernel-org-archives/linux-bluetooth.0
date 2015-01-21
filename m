Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 21 Jan 2015 09:26:20 +0530
Message-ID: <CAEUmHyata35dg_=CMWau0AhjVwFU-cJT1eVyBsgpDHYRMp5uzw@mail.gmail.com>
Subject: bluetooth-next tree compilation error
From: Varka Bhadram <varkabhadram@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I am getting compilation error with bluetooth-next tree. No problem
with net-next tree.
...
CC      drivers/net/ethernet/ti/cpsw.o
drivers/net/ethernet/ti/cpsw.c: In function ‘cpsw_ndo_poll_controller’:
drivers/net/ethernet/ti/cpsw.c:1635:24: error: ‘struct cpsw_priv’ has
no member named ‘irq’
drivers/net/ethernet/ti/cpsw.c:1636:24: error: ‘struct cpsw_priv’ has
no member named ‘irq’
make[4]: *** [drivers/net/ethernet/ti/cpsw.o] Error 1
make[3]: *** [drivers/net/ethernet/ti] Error 2
make[2]: *** [drivers/net/ethernet] Error 2
make[1]: *** [drivers/net] Error 2
make: *** [drivers] Error 2


-- 
Thanks and Regards,
Varka Bhadram.
