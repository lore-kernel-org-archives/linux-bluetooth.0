Return-Path: <maxk@qualcomm.com>
Message-Id: <5.1.0.14.2.20031008172506.020cef30@unixmail.qualcomm.com>
Date: Wed, 08 Oct 2003 17:35:53 -0700
To: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [Bluez-devel] New SDP client library
In-Reply-To: <1061810955.972.100.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <bluez-devel.lists.sourceforge.net>

At 04:29 AM 8/25/2003, Marcel Holtmann wrote:
>Hi Folks,
>
>in the last two months I have done much work with the current SDP
>implementation. The library is full featured and works fine for me in
>all situations, but the programming interface is a mess. It is not easy
>to get the service name or the number of the RFCOMM channel. You have to
>play with internal SDP lists, pointer of pointer stuff and static
>assigned UUID's. Since I already have rewritten most of the HCI part
>from scratch for the new Bluetooth library,
Hmm, what do you mean by that ? As far as I can (in CVS) core functions 
like hci_open(), hci_send_request(), etc are the same. 

>The simple interface will have of course a lot of limitations, but these
>can all be eliminated by using the full interface if needed. I tested
>the new version with all my devices on my desktop and it works flawless.
Cool.

>I will now clean up the internal stuff a little bit and then place it
>into the libs2 CVS instead of the "old" one. Comments?
Looks good to me. We've been talking about simplifying SDP library
for quite a while. And I completely support the idea.

Thanks
Max
