Return-Path: <maxk@qualcomm.com>
Message-Id: <5.1.0.14.2.20031009102655.05a199e8@unixmail.qualcomm.com>
Date: Thu, 09 Oct 2003 10:31:51 -0700
To: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [Bluez-devel] New SDP client library
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1065715616.14514.44.camel@pegasus>
References: <5.1.0.14.2.20031008172506.020cef30@unixmail.qualcomm.com>
 <5.1.0.14.2.20031008172506.020cef30@unixmail.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <bluez-devel.lists.sourceforge.net>

At 09:06 AM 10/9/2003, Marcel Holtmann wrote:
>> >Since I already have rewritten most of the HCI part
>> >from scratch for the new Bluetooth library,
>> Hmm, what do you mean by that ? As far as I can (in CVS) core functions 
>> like hci_open(), hci_send_request(), etc are the same. 
>
>I started with an empty hci.c file and begin looking at the old library.
>And of course most functions will be the same, because they are simple,
>correct and worked fine for over two years now. 
You cannot claim that you rewrote the whole thing from the scratch if those
functions are the same ;-).

>> >The simple interface will have of course a lot of limitations, but these
>> >can all be eliminated by using the full interface if needed. I tested
>> >the new version with all my devices on my desktop and it works flawless.
>> Cool.
>
>Not so cool as I thought in the first place :( While working with the
>new library and testing them on other profiles like BIP, HID and HCRP
>for example, things are getting worse again. It is hard to see the
>complete picture of SDP.
>
>> >I will now clean up the internal stuff a little bit and then place it
>> >into the libs2 CVS instead of the "old" one. Comments?
>> Looks good to me. We've been talking about simplifying SDP library
>> for quite a while. And I completely support the idea.
>
>The current CVS misses some more macros I have already coded, but not
>yet commited. They will make the work with SDP much easier. In the case
>of BIP, HID and HCRP we really need good SDP support.

Sounds like we should keep both (old and new) libraries for now.

Max
