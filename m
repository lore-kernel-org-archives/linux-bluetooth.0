Return-Path: <cyrus@holtmann.org>
From: "Ganir, Chen" <chen.ganir@ti.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
CC: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH BlueZ 01/11] mgmt-api: Update the commands for
 exchanging LTK's
Date: Wed, 18 Jan 2012 14:41:34 +0000
Message-ID: <F0070FBC0FB3174D8D11444EB2D5B0260B41E0F8@DNCE02.ent.ti.com>
References: <1326842930-31623-1-git-send-email-vinicius.gomes@openbossa.org>
	<F0070FBC0FB3174D8D11444EB2D5B0260B41DE13@DNCE02.ent.ti.com>
 <CAJdJm_OXhZeB-Vx900PR7gwb1A0xiJzgyp6BP9x-hbgE6Gx7Nw@mail.gmail.com>
In-Reply-To: <CAJdJm_OXhZeB-Vx900PR7gwb1A0xiJzgyp6BP9x-hbgE6Gx7Nw@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Lizardo,


> -----Original Message-----
> From: Anderson Lizardo [mailto:anderson.lizardo@openbossa.org]
> Sent: Wednesday, January 18, 2012 12:41 PM
> To: Ganir, Chen
> Cc: Vinicius Costa Gomes; linux-bluetooth@vger.kernel.org
> Subject: Re: [PATCH BlueZ 01/11] mgmt-api: Update the commands for
> exchanging LTK's
> 
> Hi Chen,
> 
> On Wed, Jan 18, 2012 at 3:17 AM, Ganir, Chen <chen.ganir@ti.com> wrote:
> > Storing the address type in the LTK is not perfect. For this to work
> properly, you will store the address type only for devices which
> exchanged keys. What if we have devices which do not do pairing or
> exchange keys at all ? What if we use the CreateDevice instead of
> CreatePairedDevice? In that case we will not have the address type for
> future reconnections. We need to store the device address type in a
> separate file (for example, addresstypes) and manage it separately from
> the LTK management.
> 
> Note that BlueZ is still relying on the kernel LE advertising cache
> (which is refreshed with either the automatic scanning prior to
> connection, or with the future background scanning support) for
> detecting address type for non-bonded devices. We have no plans to
> change that in near feature, because IIRC it would require changing
> bluetooth socket API (which would break all current BR/EDR
> applications).
> 
> This is an issue separate from LTK storage, if you are interested on
> pursuing this, feel free to make a proposal.
> 

I have a working implementation now that is able to create a connection for bonded devices (currently just bonded devices, but in the future, any created device node) without relying on the scan cache. I simply store the device address, and use it when connecting to that device. I see no reason or possibility for a device to change its address type during its life time (correct me if I'm wrong, and please describe a use case for that).



> Best Regards,
> --
> Anderson Lizardo
> Instituto Nokia de Tecnologia - INdT
> Manaus - Brazil


Thanks,
Chen Ganir
