Return-Path: <cyrus@holtmann.org>
Date: Tue, 6 Apr 2010 19:19:31 +0100 (BST)
To: Garry Paxinos <paxinos@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: upper limit of bonded devices?
In-Reply-To: <j2tf3ae2ce11004061008x26da852el996b017a5115d595@mail.gmail.com>
References: <r2if3ae2ce11004061001mc539e7eaq206d43ffb12fb2d2@mail.gmail.com> <j2tf3ae2ce11004061008x26da852el996b017a5115d595@mail.gmail.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-2115410775-1270577971=:823"
Message-Id: <1270577971.764253.580.nullmailer@galant.ukfsn.org>
From: Iain Hibbert <plunky@rya-online.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-2115410775-1270577971=:823
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 6 Apr 2010, Garry Paxinos wrote:

> Is there a practical upper limit of the number of devices that can be
> bonded to a single computer?
>
> I am considering reworking the bonding code to use a MySQL DB to store
> the list of devices, but was wondering if there was any other limit
> (either coding or practical).=A0=A0 For example, can a single computer
> bond with 1k devices?=A0 what about 100K or even 1M ?

There is no reason it cannot pair with such a number of devices though I
can't think how you will fit them all in your pocket..

=2E.but bear in mind that it cannot connect with more than 7 in a Bluetooth
piconet at any one time. (perhaps with other transports it can do more)
and because pairing generally involves human interaction, it is not a
frequently occurring event.

I suspect the vast majority of usage case is pairing with <10 in the
lifetime of the device and that using a MySQL database would be just
overkill.. but perhaps there are other, more minimal, data-storage front
ends that can be used (cdb?), if you wanted to provide generic access to
the information..

regards,
iain

--0-2115410775-1270577971=:823--


