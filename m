Return-Path: <maxk@qualcomm.com>
Message-Id: <5.1.0.14.2.20030516101849.0d55f0f0@unixmail.qualcomm.com>
Date: Fri, 16 May 2003 10:35:16 -0700
To: "Daryl Van Vorst" <daryl@wideray.com>, "'Marcel Holtmann'" <marcel@rvs.uni-bielefeld.de>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: RE: [Bluez-devel] Qualification Testing
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <000001c31b28$8d98f7c0$1a01010a@baked>
References: <000801c3197e$8591e290$1a01010a@baked>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <bluez-devel.lists.sourceforge.net>

At 02:25 PM 5/15/2003, Daryl Van Vorst wrote:
>Max,
>
>Regarding the L2CAP parameter negotiation.  Not sure if you saw this (see
>below).
>
>This is the one remaining problem impeding qualification. Except, of course,
>for the possibility of more failures in the next round of testing.
>
>What are your thoughts on it?
I'm trying to come up with an excuse to not implement it ;-)
Just kidding. Read below.

>> What about flowspec and flush timeout?
>> 
>> In section 6.4.2 FlushTO is listed as one of the items in the 
>> response path (along with MTU and InFlow). But in section 7.5 
>> only MTU and InFlow are listed.
>> 
>> I sent the above quote to Cetecom last week. They responded 
>> saying that MTU isn't the only negotiated parameter.

FlushTO _must_ be 0xffff for reliable ACL link. So far none of the profiles
specified use of unreliable links. 

Support for QOS is totally optional. We're only required to support 'best effort'.
Which means that even if they want something other than 'best effort' (i.e. they reject 
default settings) we won't be able to accept it simply because we don't support it.

So I'm not sure what can be negotiated there. 

btw Can this fancy Merlin viewer export trace in plain text ? I'm too lazy to install 
that stuff. And it looks like I need to see what is it exactly that they request/reject.

Max
