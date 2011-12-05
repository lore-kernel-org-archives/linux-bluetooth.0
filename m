Return-Path: <cyrus@holtmann.org>
From: "Ganir, Chen" <chen.ganir@ti.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
CC: Santiago Carot <sancane@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH 1/2] Provide return status in gatt_service_add function
Date: Mon, 5 Dec 2011 11:10:01 +0000
Message-ID: <F0070FBC0FB3174D8D11444EB2D5B02644008E@DNCE02.ent.ti.com>
References: <1322129290-10767-1-git-send-email-sancane@gmail.com>
	<20111202112957.GC17203@x220.ger.corp.intel.com>
	<CACLukzK1YyqBszGc679Vj-Pf9+M+s+LaBpnd2_+pan8TCwHODA@mail.gmail.com>
	<CAJdJm_P5OU6vqs+-9xL36=1DWVtgzzY1CEPf6rD3Tws5BSik2g@mail.gmail.com>
	<F0070FBC0FB3174D8D11444EB2D5B02643D9D0@DNCE02.ent.ti.com>
 <CAJdJm_PAC_HsEd-8-25r4V-ZqG0gfxpio=rnUZzG4AWJM2cNJQ@mail.gmail.com>
In-Reply-To: <CAJdJm_PAC_HsEd-8-25r4V-ZqG0gfxpio=rnUZzG4AWJM2cNJQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Anderson,

> -----Original Message-----
> From: Anderson Lizardo [mailto:anderson.lizardo@openbossa.org]
> Sent: Monday, December 05, 2011 12:56 PM
> To: Ganir, Chen
> Cc: Santiago Carot; linux-bluetooth@vger.kernel.org
> Subject: Re: [PATCH 1/2] Provide return status in gatt_service_add
> function
> 
> Hi Chen,
> 
> On Sun, Dec 4, 2011 at 2:51 AM, Ganir, Chen <chen.ganir@ti.com> wrote:
> > How do you ensure that? Do you assume that all servers will always
> initialize at bluetoothd startup, and always in the same order? Who's
> responsibility is it to send out the "service changed" notification
> when something changed? What is the proposed logic for this ?
> 
> To make sure the handles do not change between bluetoothd restarts
> (and is not dependent on any loading order), we need to save/restore
> attribute handles, like is done for other BlueZ parts.
> 
> "Service Changed" is not necessary to be sent if attribute handle
> storage is implemented. We have no plans to implement "Service
> Changed" now, but feel free to send patches :)
> 
> Regards,
> --
> Anderson Lizardo
> Instituto Nokia de Tecnologia - INdT
> Manaus - Brazil

What do you mean restoring the attribute handles ? Each of the profiles registers its own services when the plugin is loaded, according to the load order (which I assume will not change). When a profile registers its attributes, it can specify callbacks for read/write which are actually function pointers. How to you plan to support this? In addition, who will be responsible for reloading the database and populating the values (profile plugin or bluetoothd core) ? how do you synchronize them?

Do you have an RFC or a simple design description which will allow reviewing?

Thanks,
Chen Ganir.
 


Thanks,
Chen Ganir
