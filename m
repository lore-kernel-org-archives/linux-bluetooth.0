Return-Path: <maxk@qualcomm.com>
Message-Id: <5.1.0.14.2.20030324174756.0f0efff8@unixmail.qualcomm.com>
Date: Mon, 24 Mar 2003 17:51:21 -0800
To: david.libault@inventel.fr, Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [Bluez-devel] BlueZ Qualification
Cc: Daryl Van Vorst <dvpub@telus.net>, bluez-devel@lists.sourceforge.net, Halam.Rose@7layers-UK.com
In-Reply-To: <3E26CE2101C0104A@mel-rta6.wanadoo.fr> (added by
	postmaster@wanadoo.fr)
References: <5.1.0.14.2.20030306133725.025f46d8@mail1.qualcomm.com>
	<1046706518.14907.133.camel@linux>
	<5.1.0.14.2.20030306133725.025f46d8@mail1.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <bluez-devel.lists.sourceforge.net>

At 12:47 AM 3/7/2003, David LIBAULT wrote:
>This ACLsession program will help us do the L2CAP MTU negotiation test and 
>we'll all see if fixing it in the main stream code is that much of a big 
>deal, and what the 7layers BQB can reasonably accept.
>
>>
>> >        2) write a script for each test case
>>
>> Anybody willing to contribute that ?
>>
>
>Inventel can contribute with some test cases scripts using l2capsession. 
>We'll do that if l2capsession "kind of way to do things" is retained. For the 
>L2CAP tests (ACLsession) we have nothing yet.
>
>> It sounds like we need to create a module in CVS and start putting things
>> that we need together. Any suggestion for a name ? "qube" ?

Here you go. 
I implemented aclsession and created one common build tree for
qualification utils.

QUBE - Qualification Utilities for BluEz
http://bluez.sourceforge.net/download/bluez-qube-0.1.tar.gz

(it has your l2session thing in there).

Max
