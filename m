Return-Path: <cyrus@holtmann.org>
From: Ajay Pillai <Ajay.Pillai@csr.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: GATT and GATT based Profiles architecture - Query
Date: Fri, 17 Jun 2011 09:30:08 +0000
Message-ID: <8DCFA6B89B9E70418E47A2348D55495A4781711C@banasiexm01.ASIA.ROOT.PRI>
References: <4df91d74.0b73650a.190f.17ad@mx.google.com>
	<1308175855.2196.7.camel@aeonflux>
	<BANLkTikuyizJeF9xhAo22dv8LJ+JxeTskg@mail.gmail.com>
	<1308191356.2196.9.camel@aeonflux>
	<8DCFA6B89B9E70418E47A2348D55495A478165D6@banasiexm01.ASIA.ROOT.PRI>
 <BANLkTimiLXWNfv=hwzDTMd7U8nphUSvMQg@mail.gmail.com>
In-Reply-To: <BANLkTimiLXWNfv=hwzDTMd7U8nphUSvMQg@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

I saw another post from you which seemed to indicate that the GATT DBUS API is not
meant to be used extensively in systems for implementing profiles or for general App integration.
(Please correct me if I interpreted wrong)

However this information coupled with the tightly coupled nature of the GATT based profiles (as derived from your reply) in BlueZ, is giving 
me an impression that the current development direction in BlueZ can severely curb the freedom of device implementers 
to use the capability of GATT. (not sure if you have discussed this before an concluded, in which case I would be interested to be pointed to another post)

The way I see it is that the pace of profile spec ratification in the SIG or the pace of development of profiles in BlueZ will probably be too slow
for the larger community of device manufacturers and Application developers for platforms like Android.
Besides, the usecases being addressed by the profiles in pipeline would probably be only a fraction of the real potential of GATT, which device manufacturers might want to tap into.

This makes me think that more focus needs to be given to the GATT DBUS API, than what is implied by your earlier post.

Do you have plans for making the GATT DBUS API more feature complete?
Do you see problems in including GATT Servers too in it?
Are you open to stronger contributions to the GATT DBUS API? ( I am interested to do that)

You posted earlier:
>To be able to implement a full GATT profile externally (client role),
>we would need to expose the full GATT (or even ATT) stack over D-Bus.
>For instance, have methods for each GATT operation, and signals for
>notifications/indications.

>Is that really what we want? If yes, the Attribute API could have to
>be severely redesigned. It was not (and currently still not is)
>intended for that.
Could you elaborate what is the scope of this redesign?

I am interested to know if system integrators can have a mutually exclusive choice between external profiles using BlueZ GATT and BlueZ built-in profiles.

Thank you
ajay



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
