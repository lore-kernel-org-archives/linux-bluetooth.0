Return-Path: <cyrus@holtmann.org>
From: "Ganir, Chen" <chen.ganir@ti.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Wed, 19 Oct 2011 21:50:05 +0200
Subject: RE: LE discovery procedure
Message-ID: <7769C83744F2C34A841232EF77AEA20C01DC6AB191@dnce01.ent.ti.com>
References: <4E9E65FF.1000400@globaledgesoft.com>
	<7769C83744F2C34A841232EF77AEA20C01DC6AADCE@dnce01.ent.ti.com>
 <CAJdJm_Mxr_ubnALkUs7_mn41ZzoZdTWC45NhAwcBmueE195UOQ@mail.gmail.com>
In-Reply-To: <CAJdJm_Mxr_ubnALkUs7_mn41ZzoZdTWC45NhAwcBmueE195UOQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson

> 
> Actually we check it, but on the BlueZ side (as you know, our host
> stack is composed of kernel+userspace). From
> adapter_emit_device_found() in src/adapter.c:
> 
>         if (dev->le) {
>                 gboolean broadcaster;
> 
>                 if (dev->flags & (EIR_LIM_DISC | EIR_GEN_DISC))
>                         broadcaster = FALSE;
>                 else
>                         broadcaster = TRUE;
> 
>                 emit_device_found(adapter->path, paddr,
>                 [...]
> 
> But note that we still send the "DeviceFound" D-Bus signal, but with a
> "Broadcaster" property which UI can use to ignore the device.
> 
> Filtering on the kernel requires parsing Adv. data, and may not allow
> us to implement Broadcaster role on BlueZ (and on external
> applications as well) in future.
> 
> IMHO the kernel should still notify userspace of the device, then
> BlueZ can filter out the Broadcaster devices as necessary, *unless* we
> plan to parse all AD information on kernel, which is not a good idea
> IMHO.
> 

I'm not so comfortable using the same Device Found event both for discovering devices and for observing.
In addition, maybe the 'broadcaster variable is the wrong name for this variable. The true meaning is 'discoverable'. A peripheral can broadcast services and other advertising information while broadcasting as discoverable, so this flag may be confusing.

This also means that the upper layer using this API should keep its own state, to differ between discovering devices (where discoverable devices are displayed as discoverable and broadcast data is collected) or just 'observing' advertising data, where the central device just searches for broadcast data, and has no intention of connecting to a device. In this case, a DEVICE_FOUND event is a bit confusing.

Do you know if anyone is working on extending the capabilities of the EIR parser for more advertising data types (such as services)? We need to think of a proper way to pass the EIR information to the user in the event.

Best regards,
Chen Ganir.
