Return-Path: <cyrus@holtmann.org>
Date: Wed, 26 Jan 2011 15:37:14 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: =?iso-8859-1?Q?Andr=E9?= Dieb <andre.dieb@signove.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 1/1] Device initialization and controller type resolving
Message-ID: <20110126173714.GF27017@joana>
References: <AANLkTimqtWzKS4H+veJE2PCXH0o5CLJwrspMTfQyd=AR@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <AANLkTimqtWzKS4H+veJE2PCXH0o5CLJwrspMTfQyd=AR@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi André,

* André Dieb <andre.dieb@signove.com> [2011-01-26 12:34:02 -0200]:

> From: André Dieb Martins <andre.dieb@signove.com>
> 
> This patch proposes to use LMP features in order to resolve the controller
> type. Currently there's very few code (mostly inside drivers) that cares
> about differentiating controller types (BR/EDR, BR/EDR/LE, LE only, AMP).
> 
> Once determined dev_type, the idea would be to implement controller-type
> specific initialization procedures. There's an initialization code for BR/EDR
> devices and some early adaptation for BR/EDR/LE, but nothing regarding
> LE-only - and I'm willing to tackle that, based on your pointers.
> 
> Would it be better to always let drivers modify their device's dev_type?
> 
> What would be the correct approach?
> 
> PS: Please don't bother the CC2540 hack. Consider it a joke :-).
> 
> Signed-off-by: André Dieb Martins <andre.dieb@signove.com>
> ---
>  include/net/bluetooth/hci.h      |   78 ++++++++++++++++++++++++++++++-------
>  include/net/bluetooth/hci_core.h |    3 +
>  net/bluetooth/hci_core.c         |    8 ++--
>  net/bluetooth/hci_event.c        |   24 ++++++++++++
>  net/bluetooth/hci_sysfs.c        |    4 ++
>  5 files changed, 98 insertions(+), 19 deletions(-)


Please rebase your patch against bluetooth-next-2.6. And run your patch
against the scripts/checkpatch.pl, it does not follow the styles requirements
for the Linux Kernel.

-- 
Gustavo F. Padovan
http://profusion.mobi
