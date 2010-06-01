Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 2/3] Replace hci_recv_fragment calls
From: Marcel Holtmann <marcel@holtmann.org>
To: "Luis R. Rodriguez" <lrodriguez@atheros.com>
Cc: Luis Rodriguez <Luis.Rodriguez@Atheros.com>,
	Suraj Sumangala <Suraj.Sumangala@Atheros.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Jothikumar Mothilal <Jothikumar.Mothilal@Atheros.com>
In-Reply-To: <20100601205120.GB6037@tux>
References: <1275379440.19477.9.camel@atheros013-desktop>
	 <1275379734.19477.14.camel@atheros013-desktop>
	 <BD672EAEE3AD2C47A7120B0973C3FB3A2DC28BB600@SC1EXMB-MBCL.global.atheros.com>
	 <1275422353.2182.5.camel@localhost.localdomain> <20100601205120.GB6037@tux>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 01 Jun 2010 14:59:09 -0700
Message-ID: <1275429550.2182.7.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luis,

> > > You want to unify patches 1 and 2. Patches upstream should be atomic so that if  you apply it, it should make everything still work. Your first patch removes hci_recv_fragment() and then this one fixes the places that call it, you want to do both in one shot.
> > 
> > actually I prefer to leave these two patches out for now. Since the
> > renaming could be done easily later. The important part is actually the
> > other implementation.
> 
> Won't that break compilation on the first patch since all existing
> code users no longer have the exported symbol available?

no. The important change here is for the H4 specific stream fragment
handling. The rest is just a renaming. So 3/3 is the important patch and
1/2 and 2/2 are just cosmetic changes.

Regards

Marcel


