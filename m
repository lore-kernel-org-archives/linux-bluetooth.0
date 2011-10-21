Return-Path: <cyrus@holtmann.org>
From: Vijaykumar Dadmode <Vijaykumar.Dadmode@csr.com>
To: "'Anderson Lizardo'" <anderson.lizardo@openbossa.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: Query regarding BLE GetPrimaryServices()
Date: Fri, 21 Oct 2011 12:06:01 +0000
Message-ID: <F82830D409D80E4881C83250E051B74B4784F664@banasiexm01.ASIA.ROOT.PRI>
References: <F82830D409D80E4881C83250E051B74B4784BC9E@banasiexm01.ASIA.ROOT.PRI>
	<F82830D409D80E4881C83250E051B74B4784F461@banasiexm01.ASIA.ROOT.PRI>
 <CAJdJm_M+G_b=CDmt9R9mO+RPb8oN5BfxTjnbV3O1WVxxL1LNfA@mail.gmail.com>
In-Reply-To: <CAJdJm_M+G_b=CDmt9R9mO+RPb8oN5BfxTjnbV3O1WVxxL1LNfA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

> This is already done automatically, when you do either CreateDevice()
> or CreatePairedDevice(). See the device_browse_primary() calls in
> src/device.c and src/adapter.c

How do we get the primary services when we have already called a "CreateDevice() or CreatePairedDevice()", "CONNECTED" state over dbus? 

Thanks,
Vijay


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
