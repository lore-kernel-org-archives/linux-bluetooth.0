Return-Path: <cyrus@holtmann.org>
From: "Liu, Raymond" <raymond.liu@intel.com>
To: "marcel@holtmann.org" <marcel@holtmann.org>, "johan.hedberg@nokia.com"
	<johan.hedberg@nokia.com>
CC: "bluez-devel@lists.sourceforge.net" <bluez-devel@lists.sourceforge.net>,
	Vinicius Gomes <vinicius.gomes@openbossa.org>
Date: Thu, 20 Nov 2008 15:04:46 +0800
Subject: obexd: register_record function for PBAP client
Message-ID: <0463F45F3606F4428ED35AC8C709F92E0217A1E9@pdsmsx502.ccr.corp.intel.com>
References: <0463F45F3606F4428ED35AC8C709F92E0217A025@pdsmsx502.ccr.corp.intel.com>
 <2a9506370811192003u1c3d7f27qe50472922b7b33@mail.gmail.com>
In-Reply-To: <2a9506370811192003u1c3d7f27qe50472922b7b33@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <bluez-devel.lists.sourceforge.net>

Hi holtmann, johan

	I am writing PBAP client code for obex-client. While I found that the regi=
ster_record function which adds record to SDP is in the manager.c file. Whi=
le for FTP and OPP, they don't need a SDP record in Client side. So it's ok=
. But for PBAP Client, the spec requires the PBAP client to register its re=
cord PCE in SDP.
	So, Should we move this function out to some library? Or I just copy the c=
ode into client side?

Raymond
