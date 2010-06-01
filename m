Return-Path: <cyrus@holtmann.org>
Date: Tue, 1 Jun 2010 13:51:20 -0700
From: "Luis R. Rodriguez" <lrodriguez@atheros.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: Luis Rodriguez <Luis.Rodriguez@Atheros.com>, Suraj Sumangala
	<Suraj.Sumangala@Atheros.com>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, Jothikumar Mothilal
	<Jothikumar.Mothilal@Atheros.com>
Subject: Re: [PATCH 2/3] Replace hci_recv_fragment calls
Message-ID: <20100601205120.GB6037@tux>
References: <1275379440.19477.9.camel@atheros013-desktop>
 <1275379734.19477.14.camel@atheros013-desktop>
 <BD672EAEE3AD2C47A7120B0973C3FB3A2DC28BB600@SC1EXMB-MBCL.global.atheros.com>
 <1275422353.2182.5.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1275422353.2182.5.camel@localhost.localdomain>
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Jun 01, 2010 at 12:59:13PM -0700, Marcel Holtmann wrote:
> Hi Luis,
> 
> > You want to unify patches 1 and 2. Patches upstream should be atomic so that if  you apply it, it should make everything still work. Your first patch removes hci_recv_fragment() and then this one fixes the places that call it, you want to do both in one shot.
> 
> actually I prefer to leave these two patches out for now. Since the
> renaming could be done easily later. The important part is actually the
> other implementation.

Won't that break compilation on the first patch since all existing
code users no longer have the exported symbol available?

  Luis
