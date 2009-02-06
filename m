Return-Path: <cyrus@holtmann.org>
Date: Fri, 06 Feb 2009 15:12:55 +0900
From: Daehyung Jo <daehyung.jo@samsung.com>
Subject: RE: Wrong RFCOMM connection request in OPP/FTP
In-reply-to: <001a01c98817$c0bb8570$42329050$%jo@samsung.com>
To: linux-bluetooth@vger.kernel.org
Message-id: <001b01c98821$f34cba40$d9e62ec0$%jo@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
References: <001a01c98817$c0bb8570$42329050$%jo@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, again,

> I have a weird test result with OPP using bluez 4.25 and obex-data-server (ODS) 0.4.2.
> If I try to send a file from Samsung SGH-P930 to my target via OPP, ODS recognizes the connection type
> as an FTP thus FTP server
> tries to deal the request. Even if I disable OPP service and enable FTP service only, the OPP request
> is accepted.
> 
> ODS makes separate OPP and FTP rfcomm socket servers with different channel number 9 and 10 each. When
> there comes an IO event to
> the specific channel, the connect callback is invoked for each server. ODS just links IO events from
> the RFCOMM channel to the
> OPP/FTP server call-backs. Thus I think SGH-P930, which has a CSR stack, tries to connect to a
> different rfcomm channel. This maybe
> the problem of the SGH-P930 side.
> 
> The thing is that other normal phones translate the OPP connect request from SGH-P930 correctly. I
> think commercial phones have a
> error handling or correcting routine for this kind of wrong connect request so that even SGH-P930
> tries to connect through a wrong
> channel, BT stack can redirect the request if we can able to know the connection type.
> 
> So my question is how we can correct the wrong connection request and redirect to the proper one as
> other stacks do? And I wonder if
> SGH-P930 really misbehaves. How can I verify that SGH-P930 tries to connect to a wrong rfcomm channel?
> 
> I didn't tested with obexd yet but think it's not the problem of ODS only.
> 


I verified that SGH-P930 sends a file using FTP profile not OPP using hcidump.
So far I have assumed that "send via Bluetooth" function in mobile phones uses a OPP profile but that was wrong.
Some phones using CSR stack sends a file using OPP.

Have a good day :)

Best wishes,
Daehyung Jo

