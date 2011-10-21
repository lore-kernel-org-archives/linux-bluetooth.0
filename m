Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <F82830D409D80E4881C83250E051B74B4784F664@banasiexm01.ASIA.ROOT.PRI>
References: <F82830D409D80E4881C83250E051B74B4784BC9E@banasiexm01.ASIA.ROOT.PRI>
	<F82830D409D80E4881C83250E051B74B4784F461@banasiexm01.ASIA.ROOT.PRI>
	<CAJdJm_M+G_b=CDmt9R9mO+RPb8oN5BfxTjnbV3O1WVxxL1LNfA@mail.gmail.com>
	<F82830D409D80E4881C83250E051B74B4784F664@banasiexm01.ASIA.ROOT.PRI>
Date: Fri, 21 Oct 2011 09:29:47 -0300
Message-ID: <CAJdJm_P4TTd_nb8ae-WBp_TkDaEH-QsgCJz3rgCZkeCQoPTjJg@mail.gmail.com>
Subject: Re: Query regarding BLE GetPrimaryServices()
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Vijaykumar Dadmode <Vijaykumar.Dadmode@csr.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Oct 21, 2011 at 9:06 AM, Vijaykumar Dadmode
<Vijaykumar.Dadmode@csr.com> wrote:
> Hi Anderson,
>
>> This is already done automatically, when you do either CreateDevice()
>> or CreatePairedDevice(). See the device_browse_primary() calls in
>> src/device.c and src/adapter.c
>
> How do we get the primary services when we have already called a "CreateDevice() or CreatePairedDevice()", "CONNECTED" state over dbus?

You cannot do this by hand. It is done right after connection (or
pairing, if using CreatePairedDevice). For more information on how to
read the services and characteristics over D-Bus, see
doc/attribute-api.txt.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
