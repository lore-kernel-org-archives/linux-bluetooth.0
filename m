Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <F82830D409D80E4881C83250E051B74B4784F461@banasiexm01.ASIA.ROOT.PRI>
References: <F82830D409D80E4881C83250E051B74B4784BC9E@banasiexm01.ASIA.ROOT.PRI>
	<F82830D409D80E4881C83250E051B74B4784F461@banasiexm01.ASIA.ROOT.PRI>
Date: Wed, 19 Oct 2011 10:30:31 -0300
Message-ID: <CAJdJm_M+G_b=CDmt9R9mO+RPb8oN5BfxTjnbV3O1WVxxL1LNfA@mail.gmail.com>
Subject: Re: Query regarding BLE GetPrimaryServices()
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Vijaykumar Dadmode <Vijaykumar.Dadmode@csr.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Oct 19, 2011 at 10:10 AM, Vijaykumar Dadmode
<Vijaykumar.Dadmode@csr.com> wrote:
> Hi ,
> Could you please let me know "How do we retrieve the primary services from Client over DBUS APIs when we are already 'CONNECTED' to the server device "  ?

This is already done automatically, when you do either CreateDevice()
or CreatePairedDevice(). See the device_browse_primary() calls in
src/device.c and src/adapter.c

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
