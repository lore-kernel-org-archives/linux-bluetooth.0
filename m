Return-Path: <cyrus@holtmann.org>
From: Ajay Pillai <Ajay.Pillai@csr.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: GATT and GATT based Profiles architecture - Query
Date: Mon, 20 Jun 2011 08:42:46 +0000
Message-ID: <8DCFA6B89B9E70418E47A2348D55495A47818B76@banasiexm01.ASIA.ROOT.PRI>
References: <4df91d74.0b73650a.190f.17ad@mx.google.com>
	<1308175855.2196.7.camel@aeonflux>
	<BANLkTikuyizJeF9xhAo22dv8LJ+JxeTskg@mail.gmail.com>
	<1308191356.2196.9.camel@aeonflux>
	<8DCFA6B89B9E70418E47A2348D55495A478165D6@banasiexm01.ASIA.ROOT.PRI>
	<BANLkTimiLXWNfv=hwzDTMd7U8nphUSvMQg@mail.gmail.com>
	<8DCFA6B89B9E70418E47A2348D55495A4781711C@banasiexm01.ASIA.ROOT.PRI>
 <BANLkTimXg6_3f25sXCtZ_YU3VoWUayqbFQ@mail.gmail.com>
In-Reply-To: <BANLkTimXg6_3f25sXCtZ_YU3VoWUayqbFQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

>> The way I see it is that the pace of profile spec ratification in the SIG or the pace of development of profiles in BlueZ will probably be too slow
>> for the larger community of device manufacturers and Application developers for platforms like Android.
>> Besides, the usecases being addressed by the profiles in pipeline would probably be only a fraction of the real potential of GATT, which device manufacturers might want to tap into.
>
>I agree. But note that currently we lack use cases which justify a
>complete GATT API over D-Bus. Feel free to discuss your own use cases,
>and propose an API for them.

The point that I was trying to make is that you or me trying to figure out the possible usecases over GATT and then trying to cater to them may prove to be inadequate quite soon after widespread Ble deployment. I thought the usecases over GATT beyond those that are thought over by the SIG are best left to the imagination of the users of GATT which could be the peripheral device manufacturers. Giving BlueZ a comprehensive GATT API will enable any of these usecases and would pave the way for widespread and faster usage of Ble/GATT, at the same time giving freedom to the user to decide what usecases he/she wants in his/her BlueZ powered device.
I do not have any specific usecase in mind (or it could be that I have just too many of them), but the system of interest to me is Android.


>> Do you see problems in including GATT Servers too in it?
>> Are you open to stronger contributions to the GATT DBUS API? ( I am interested to do that)
>
>I believe we are always open to discussions and contributions :). But
>before you begin implementing your proposal, I'd suggest discussing a
>draft API first on this list. I'm sure there are other parties
>interested on helping on that as well.

Sure. I shall send out an API RFC before I start on it.


Thank you,
ajay


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
