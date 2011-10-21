Return-Path: <cyrus@holtmann.org>
From: Ajay Pillai <Ajay.Pillai@csr.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	Vijaykumar Dadmode <Vijaykumar.Dadmode@csr.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: Query regarding BLE GetPrimaryServices()
Date: Fri, 21 Oct 2011 13:04:42 +0000
Message-ID: <8DCFA6B89B9E70418E47A2348D55495A479074C8@banasiexm01.ASIA.ROOT.PRI>
References: <F82830D409D80E4881C83250E051B74B4784BC9E@banasiexm01.ASIA.ROOT.PRI>
	<F82830D409D80E4881C83250E051B74B4784F461@banasiexm01.ASIA.ROOT.PRI>
	<CAJdJm_M+G_b=CDmt9R9mO+RPb8oN5BfxTjnbV3O1WVxxL1LNfA@mail.gmail.com>
	<F82830D409D80E4881C83250E051B74B4784F664@banasiexm01.ASIA.ROOT.PRI>
 <CAJdJm_P4TTd_nb8ae-WBp_TkDaEH-QsgCJz3rgCZkeCQoPTjJg@mail.gmail.com>
In-Reply-To: <CAJdJm_P4TTd_nb8ae-WBp_TkDaEH-QsgCJz3rgCZkeCQoPTjJg@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>You cannot do this by hand. It is done right after connection (or
>pairing, if using CreatePairedDevice). For more information on how to
>read the services and characteristics over D-Bus, see
>doc/attribute-api.txt.

Does this mean that it is not possible for an Application to just come up, and list the primary services of a remote LE device that is already connected(due to another application)? (via DBUS)
Is this something that we can just add as a new API (listPrimaryServices) to the " org.bluez.Device" interface of the device object?

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


 To report this email as spam click https://www.mailcontrol.com/sr/wQw0zmjPoHdJTZGyOCrrhg== .


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
