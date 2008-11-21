Return-Path: <cyrus@holtmann.org>
From: "Liu, Raymond" <raymond.liu@intel.com>
To: Vinicius Gomes <vinicius.gomes@openbossa.org>, "johan.hedberg@nokia.com"
	<johan.hedberg@nokia.com>, "marcel@holtmann.org" <marcel@holtmann.org>
CC: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Fri, 21 Nov 2008 10:44:20 +0800
Subject: obexd: Application parameter for PBAP in gwobex?
Message-ID: <0463F45F3606F4428ED35AC8C709F92E0217A4F5@pdsmsx502.ccr.corp.intel.com>
References: <0463F45F3606F4428ED35AC8C709F92E0217A025@pdsmsx502.ccr.corp.intel.com>
	<2a9506370811192003u1c3d7f27qe50472922b7b33@mail.gmail.com>
	<0463F45F3606F4428ED35AC8C709F92E0217A0CC@pdsmsx502.ccr.corp.intel.com>
	<0463F45F3606F4428ED35AC8C709F92E0217A0E4@pdsmsx502.ccr.corp.intel.com>
 <0463F45F3606F4428ED35AC8C709F92E0217A293@pdsmsx502.ccr.corp.intel.com>
In-Reply-To: <0463F45F3606F4428ED35AC8C709F92E0217A293@pdsmsx502.ccr.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Vinicius, johan, holtmann
=09
	In the current obexd, gw_obex_get function do not handle the application p=
arameter for PBAP function head. I heard that someone have a patch for this=
, but I can not find it on the list's archive. Can you kindly share me the =
information?

	And if there are no such patch I plan to write another pce_gw_obex_get fun=
ction for this purpose, for I think add too much input parameters in the gw=
_obex_get function might not be a good choice. How do you think about it?

Raymond
