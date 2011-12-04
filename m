Return-Path: <cyrus@holtmann.org>
From: "Ganir, Chen" <chen.ganir@ti.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	Santiago Carot <sancane@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH 1/2] Provide return status in gatt_service_add function
Date: Sun, 4 Dec 2011 06:51:13 +0000
Message-ID: <F0070FBC0FB3174D8D11444EB2D5B02643D9D0@DNCE02.ent.ti.com>
References: <1322129290-10767-1-git-send-email-sancane@gmail.com>
	<20111202112957.GC17203@x220.ger.corp.intel.com>
	<CACLukzK1YyqBszGc679Vj-Pf9+M+s+LaBpnd2_+pan8TCwHODA@mail.gmail.com>
 <CAJdJm_P5OU6vqs+-9xL36=1DWVtgzzY1CEPf6rD3Tws5BSik2g@mail.gmail.com>
In-Reply-To: <CAJdJm_P5OU6vqs+-9xL36=1DWVtgzzY1CEPf6rD3Tws5BSik2g@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Anderson,

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Anderson Lizardo
> Sent: Friday, December 02, 2011 5:37 PM
> To: Santiago Carot
> Cc: linux-bluetooth@vger.kernel.org
> Subject: Re: [PATCH 1/2] Provide return status in gatt_service_add
> function
> 
> Hi Santiago,
> 
> On Fri, Dec 2, 2011 at 7:43 AM, Santiago Carot <sancane@gmail.com>
> wrote:
> > When I was working in this stuff, I was wondering if there may exist
> > the case when a plugin registers several services and the last one
> > fails, Do you think it would have sense to provide the service ID as
> > return parameter to allow plugins remove their attributes before
> > aborting the loading operation?, On the other hand, this feature
> would
> > raise the posibility of finding gaps in the distribution of handlers
> > assigned in GATT due that plugins could add and remove services
> > dynamically, I'm not sure if that is expected in GATT.
> 
> I think that, before doing anything like this, we should ensure the
> handles allocated for GATT servers do not change after registration
> (i.e. they are kept in storage and reloaded when bluez starts). If
> possible, can you contribute on this regard?
> 
> Thanks,
> --
> Anderson Lizardo
> Instituto Nokia de Tecnologia - INdT
> Manaus - Brazil
> --
> To unsubscribe from this list: send the line "unsubscribe linux-
> bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

How do you ensure that? Do you assume that all servers will always initialize at bluetoothd startup, and always in the same order? Who's responsibility is it to send out the "service changed" notification when something changed? What is the proposed logic for this ?

Thanks,
Chen Ganir
