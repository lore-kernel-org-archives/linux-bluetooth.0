Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <50B681C7.1030207@globaledgesoft.com>
References: <50B681C7.1030207@globaledgesoft.com>
Date: Fri, 30 Nov 2012 08:08:04 -0400
Message-ID: <CAJdJm_MCt+dep8XipFonUvRO5uoBiHNZeZm_80+LG7=E0DpTLg@mail.gmail.com>
Subject: Re: BLE : SMP pairing + LE_Start_encryption
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Ajay <ajay.kv@globaledgesoft.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ajay,

On Wed, Nov 28, 2012 at 5:27 PM, Ajay <ajay.kv@globaledgesoft.com> wrote:
>
> Hi,
>         how do i do smp pairing and ltk key distribution using l2cap socket
> connection?  does bluez provide any tools for LE pairing . my ultimate
> result should be enabling LE_start_encryption , which requires ltk key
> distribution (which is a part of LE_pairing).

Either using mgmt API to do pairing (see mgmt_create_bonding() in
src/mgmt.c from bluez sources and doc/mgmt-api.txt for how to do this)
or increase socket security level to at least medium using
setsockopt() (see set_sec_level() in btio/btio.c for how to do this).

In summary, you will need to use BlueZ code as reference if you want
to do these things on your own. The easier route is to use BlueZ D-Bus
API to do pairing.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
