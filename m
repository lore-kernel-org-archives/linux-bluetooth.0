Return-Path: <ubaldo@eja.it>
Message-ID: <20040618183339.20830.qmail@webmail.aruba.it>
References: <20040618175410.28510.qmail@webmail.aruba.it>
            <1087582530.4309.121.camel@pegasus>
In-Reply-To: <1087582530.4309.121.camel@pegasus>
From: "ubaldo" <ubaldo@eja.it>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: multi rfcomm/sco connection
Date: Fri, 18 Jun 2004 20:33:39 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
List-ID: <bluez-devel.lists.sourceforge.net>


>> I would like to understand why it is not possible to establish more than one 
>> sco connection and more than an rfcomm connection with and usb-dongle. 
> 
> it is possible to establish up to 30 RFCOMM connections into each
> direction. The number of SCO connections is limited to one per ACL link.

Does it mean that for each SCO connection I need another bt-dongle, or there 
is a way to allow multi SCO connection with the same bt-dongle?
