Return-Path: <gareth@apache.org>
Date: Wed, 26 Nov 2003 14:13:40 -0800 (PST)
From: Gareth Reakes <gareth@apache.org>
To: Marcel Holtmann <marcel@holtmann.org>
cc: "Michal Semler (volny.cz)" <cijoml@volny.cz>,
   BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Problems with MS mouse and keyboard
In-Reply-To: <1069884432.9032.65.camel@pegasus>
Message-ID: <20031126141037.D25686@minotaur.apache.org>
References: <20031105093947.J63252@minotaur.apache.org>
 <20031126131925.M25686@minotaur.apache.org>  <1069882659.9032.54.camel@pegasus>
 <200311262254.21024.cijoml@volny.cz>  <20031126140017.C25686@minotaur.apache.org>
 <1069884432.9032.65.camel@pegasus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <bluez-users.lists.sourceforge.net>

Hi,


On Wed, 26 Nov 2003, Marcel Holtmann wrote:

> Hi Gareth,
>
> > 	I know the ping thing works, however I don't believe that it
> > should be necessary. I think there is either something wrong with the
> > hardware, bthid or bluez. If it is bthid or bluez then I would like to try
> > and fix it so we can all benefit :)
>
> look at my bthid code and see how I have handled it. This was working
> for me. You need a sleep() and the correct order of closing the L2CAP
> channels. Otherwise the ACL connection would not be terminated.

I modified my bthid code after you posted the other week. It still does
not work.  Ah well, this just gives me more incentive to work on the
kernel HID parser :) I will speak again after I have read your posting on
devel and had a go at implementing it.


Cheers,

Gareth
