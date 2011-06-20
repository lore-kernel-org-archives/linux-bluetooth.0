Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BANLkTimHLO1dJYeapKQdTdOTpzfVjKrhdA@mail.gmail.com>
References: <BANLkTimHLO1dJYeapKQdTdOTpzfVjKrhdA@mail.gmail.com>
Date: Mon, 20 Jun 2011 08:56:37 -0400
Message-ID: <BANLkTi=8q0usxLXQ5uB82CwN8=zXgwn-Jw@mail.gmail.com>
Subject: Re: [RFC] Attribute IO Driver
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Jun 20, 2011 at 8:35 AM, Claudio Takahasi
<claudio.takahasi@openbossa.org> wrote:
> This is the current driver definition:
> struct btd_attio_driver {
>        const char *name;
>        const char **uuids; /* UUIDs of primary services */
>        int (*probe) (struct btd_device *device, GSList *uuids);   /*
> List of Primary Services: UUID and start/end handles */
>        void (*remove) (struct btd_device *device);
>        int (*connected) (struct btd_device *device, GAttrib *attrib);
>        void (*disconnected) (struct btd_device *device);
> };
>
> * Open issues:
> 1. How to request re-connections. The current code shares the GAtrrib,
> I am trying to avoid sharing the GAttrib reference creating a ATT
> command queue. The idea is to inform the queue when the device is
> probed, allowing offline operations and automatic connection request.
> If there is at least one item in the queue the device will be added in
> the "automatic" connection list. Using a command queue, it MAY be
> possible to remove the "connected" and "disconnected" callbacks.
> 2. Move attio.c source to device.c?
> 3. should Generic API be a "built-in" ATT IO driver? (I moved to
> plugins/attribute.c), it looks more clean to me. Same "level" of
> Service/SDP plugin.
> 4. Passive scanning: it will be necessary to re-connect

Just to complement the list of open issues:

5. We plan to drop the connected/disconnected callbacks. Most profiles
(except proximity) will not need them, and as Claudio mentioned, we do
not want to tie the profiles to an active connection. For those who
need a handler for connected/disconnected events, we can implement a
"btd_adapter_register_connected_callback" (just like the existing
btd_adapter_register_powered_callback() in src/adapter.c).

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
