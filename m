Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <7769C83744F2C34A841232EF77AEA20C01DC6AADCE@dnce01.ent.ti.com>
References: <4E9E65FF.1000400@globaledgesoft.com>
	<7769C83744F2C34A841232EF77AEA20C01DC6AADCE@dnce01.ent.ti.com>
Date: Wed, 19 Oct 2011 11:01:14 -0300
Message-ID: <CAJdJm_Mxr_ubnALkUs7_mn41ZzoZdTWC45NhAwcBmueE195UOQ@mail.gmail.com>
Subject: Re: LE discovery procedure
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: "Ganir, Chen" <chen.ganir@ti.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen,

On Wed, Oct 19, 2011 at 4:17 AM, Ganir, Chen <chen.ganir@ti.com> wrote:
> According to the spec, there are 3 discoverable modes available : None, Limited and general. Here's how the spec defines General discovery procedure :
> "The Host shall check for the Flags AD type in the advertising data. If the Flags
> AD type is present and either the LE General Discoverable Mode flag is set to
> one or the LE Limited Discoverable Mode flag is set to one then the Host shall
> consider the device as a discovered device, otherwise the advertising data
> shall be ignored."
>
> We do not do that right now. Moreover - we simply ignore the flags, and just treat every advertising event as device found.

Actually we check it, but on the BlueZ side (as you know, our host
stack is composed of kernel+userspace). From
adapter_emit_device_found() in src/adapter.c:

        if (dev->le) {
                gboolean broadcaster;

                if (dev->flags & (EIR_LIM_DISC | EIR_GEN_DISC))
                        broadcaster = FALSE;
                else
                        broadcaster = TRUE;

                emit_device_found(adapter->path, paddr,
                [...]

But note that we still send the "DeviceFound" D-Bus signal, but with a
"Broadcaster" property which UI can use to ignore the device.

Filtering on the kernel requires parsing Adv. data, and may not allow
us to implement Broadcaster role on BlueZ (and on external
applications as well) in future.

IMHO the kernel should still notify userspace of the device, then
BlueZ can filter out the Broadcaster devices as necessary, *unless* we
plan to parse all AD information on kernel, which is not a good idea
IMHO.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
