Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] New SDP client library
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <5.1.0.14.2.20031008172506.020cef30@unixmail.qualcomm.com>
References: <5.1.0.14.2.20031008172506.020cef30@unixmail.qualcomm.com>
Content-Type: text/plain
Message-Id: <1065715616.14514.44.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: 09 Oct 2003 18:06:50 +0200

Hi Max,

> >in the last two months I have done much work with the current SDP
> >implementation. The library is full featured and works fine for me in
> >all situations, but the programming interface is a mess. It is not easy
> >to get the service name or the number of the RFCOMM channel. You have to
> >play with internal SDP lists, pointer of pointer stuff and static
> >assigned UUID's. Since I already have rewritten most of the HCI part
> >from scratch for the new Bluetooth library,
> Hmm, what do you mean by that ? As far as I can (in CVS) core functions 
> like hci_open(), hci_send_request(), etc are the same. 

I started with an empty hci.c file and begin looking at the old library.
And of course most functions will be the same, because they are simple,
correct and worked fine for over two years now. The hci_types.h file
will be more amazing ;)

> >The simple interface will have of course a lot of limitations, but these
> >can all be eliminated by using the full interface if needed. I tested
> >the new version with all my devices on my desktop and it works flawless.
> Cool.

Not so cool as I thought in the first place :( While working with the
new library and testing them on other profiles like BIP, HID and HCRP
for example, things are getting worse again. It is hard to see the
complete picture of SDP.

> >I will now clean up the internal stuff a little bit and then place it
> >into the libs2 CVS instead of the "old" one. Comments?
> Looks good to me. We've been talking about simplifying SDP library
> for quite a while. And I completely support the idea.

The current CVS misses some more macros I have already coded, but not
yet commited. They will make the work with SDP much easier. In the case
of BIP, HID and HCRP we really need good SDP support.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
