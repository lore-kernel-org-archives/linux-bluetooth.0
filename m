Return-Path: <cyrus@holtmann.org>
Date: Thu, 26 Jan 2012 11:00:29 +0200
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: Ulisses Furquim <ulisses@profusion.mobi>, marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Change chan_ready param from sk to chan
Message-ID: <20120126090028.GA3300@aemeltch-MOBL1>
References: <1327500571-29794-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <CAA37ikbfBGGbYfyL1HkL=LGZ4Xyghns699W0eAHKWeuV_7Zw-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAA37ikbfBGGbYfyL1HkL=LGZ4Xyghns699W0eAHKWeuV_7Zw-Q@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ulisses,

On Thu, Jan 26, 2012 at 01:04:06AM -0200, Ulisses Furquim wrote:
> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> >
> > Change is needed to remove dependency on sk when possible
> > before introducing l2cap channel lock.
> 
> What's the overall idea? We used to rely on sk lock for mutual
> exclusion, right? (please correct me if I'm wrong) I'm seeing some
> patches from you to change from sk to chan but introducing another
> lock might shake things a bit so that's why I'm asking for the big
> picture, if you have thought this through already.

Basically it is known that current implementation of some higher level
protocols like RFCOMM using kernel sockets is not the right way and shall
be changed at some point.

I've implemented basic A2MP protocol as a kernel socket and Marcel gave me
suggestion to move from sockets to internal L2CAP functions.

I've done this and since everything is locked with sk and obviously we do
not have socket I have to use following constructions:

<------8<-------------------
|  if (sk)
|          lock_sock(sk)
|  ...
|  if(sk)
|          release_sock(sk)
|
<------8<-------------------

which does not look nice and might be racy. Then comes idea to change
socket lock for L2CAP protocol to e.g. l2cap_channel_{lock,unlock}.

I have code which works but some parts looks like hacks so I try to polish
it a bit and send as RFC. Please give me comments if you think this might
be done other way.

Best regards 
Andrei Emeltchenko 

