Return-Path: <cyrus@holtmann.org>
Message-ID: <47EA793A.7040003@gmail.com>
Date: Wed, 26 Mar 2008 17:26:34 +0100
From: Jiri Slaby <jirislaby@gmail.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: Maxim Krasnyansky <maxk@qualcomm.com>,
 bluez-devel@lists.sourceforge.net
Subject: Re: [PATCH] HIDD: add psm offset possibilty
References: <1206543023-10767-1-git-send-email-jirislaby@gmail.com> <DBFFAB62-8CD8-4827-93A2-19B6E884AD27@holtmann.org>
In-Reply-To: <DBFFAB62-8CD8-4827-93A2-19B6E884AD27@holtmann.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

On 03/26/2008 05:18 PM, Marcel Holtmann wrote:
> Hi Jiri,
> 
>> This feature allows using cell phones as remote controllers, because it
>> usually denies to bind psms lower than 0x1000.
> 
> you have to explain why this is needed and useful since even creating 
> the HID device needs root capabilities.
> 
> And why for example using the input service with its D-Bus API is not 
> working for you.

Sorry, I wasn't clear enough.

The daemon runs on standard PC, and on mobile phone there is an java application 
(on whatever platform) which can bind only psms >= 0x1000 (on most phones). So 
to allow taking control of hid by a cell phone, hidd must listen on odd psms >= 
0x1000 (i use hidd --server on pc, java-client in my current application [1]).

[1] http://decibel.fi.muni.cz/cgi-bin/gitweb.cgi?p=l2cap.git;a=summary

regards,
--js
