Return-Path: <cyrus@holtmann.org>
Date: Thu, 9 Jun 2011 16:36:38 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	linux-bluetooth@vger.kernel.org,
	Anderson Briglia <anderson.briglia@openbossa.org>
Subject: Re: [bluetooth-next v3 06/16] Bluetooth: Add SMP confirmation structs
Message-ID: <20110609193638.GE2533@joana>
References: <1307483205-1518-1-git-send-email-vinicius.gomes@openbossa.org>
 <1307483205-1518-7-git-send-email-vinicius.gomes@openbossa.org>
 <20110608184649.GC13036@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20110608184649.GC13036@joana>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Gustavo F. Padovan <padovan@profusion.mobi> [2011-06-08 15:46:49 -0300]:

> * Vinicius Costa Gomes <vinicius.gomes@openbossa.org> [2011-06-07 18:46:35 -0300]:
> 
> > From: Anderson Briglia <anderson.briglia@openbossa.org>
> > 
> > This patch adds initial support for verifying the confirmation value
> > that the remote side has sent.
> > 
> > Signed-off-by: Anderson Briglia <anderson.briglia@openbossa.org>
> > Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> > ---
> >  include/net/bluetooth/l2cap.h |    5 +++++
> >  net/bluetooth/smp.c           |   17 +++++++++++++++++
> >  2 files changed, 22 insertions(+), 0 deletions(-)
> 
> Patch up to 6/16 are applied. Thanks.

I dropped all six patches:

  CC [M]  net/bluetooth/l2cap_sock.o
  CC [M]  net/bluetooth/smp.o
  CC [M]  net/bluetooth/sco.o
net/bluetooth/smp.c:80:12: warning: ‘smp_c1’ defined but not used [-Wunused-function]
net/bluetooth/smp.c:122:12: warning: ‘smp_s1’ defined but not used [-Wunused-function]
net/bluetooth/smp.c:138:12: warning: ‘smp_rand’ defined but not used [-Wunused-function]
  CC [M]  net/bluetooth/bnep/core.o
  CC [M]  net/bluetooth/bnep/sock.o

I pick them again with the whole patchset next time to avoid warnings like these.

	Gustavo
