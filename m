Return-Path: <rthiaga1@urbana.css.mot.com>
Message-ID: <411166F7.2020500@urbana.css.mot.com>
Date: Wed, 04 Aug 2004 17:45:11 -0500
From: Radha Thiagarajan <rthiaga1@urbana.css.mot.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: multi rfcomm/sco connection
References: <20040618175410.28510.qmail@webmail.aruba.it>	 <1087582530.4309.121.camel@pegasus>	 <20040618183339.20830.qmail@webmail.aruba.it>	 <1087583875.25061.2.camel@pegasus>	 <20040618184232.25439.qmail@webmail.aruba.it>	 <1087584576.25061.6.camel@pegasus>	 <20040716140215.564.qmail@webmail2.aruba.it> <1089991775.5119.18.camel@pegasus>
In-Reply-To: <1089991775.5119.18.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel,

We need clarification from you about two things regarding SCO.

1) We noticed that the SCO module has different behavior when dealing 
with BDADDR_ANY as opposed to a specific bluetooth address. If a device 
is told to listen for a SCO connection with BDADDR_ANY, and then creates 
an outgoing SCO connection to a device using BDADDR_ANY, the connection 
succeeds. Later, if an incoming SCO connection is received, the listen 
socket will accept the connection (thus producing two SCO connections 
over 2 ACL connections to 2 different devices).

This is all fine, but if instead, we bind the listen socket with a 
specific device address (instead of BDADDR_ANY) and then try to make the 
outgoing SCO connection using the specific address, it will fail 
claiming that the address is already in use. This looks like 
inconsistent behavior, given that even if we specify BDADDR_ANY and we 
only have one interface, both connections will be using the same interface.

So, in short, if BlueZ is asked to use a specific interface for both 
incoming and outgoing SCO connections, it will refuse to carry out the 
bind calls, but if BDADDR_ANY is used, it will allow both connections. 
Therefore, it appears to be a bug - either BlueZ really can't handle 
more than one SCO at a time and it is being tricked into doing it, or it 
should allow the user to specify the address and not complain.


2) Consider two devices A and B. A uses BlueZ while B does not. Let us 
also assume that B can handle more than one SCO per ACL connection.  Let 
us say that there is a SCO connection between A and B already. Then B 
initiates a second SCO connection on the same ACL to A. Looking at the 
source for this situation, it appears that  the device A will overwrite 
the SCO socket values with the new one that was just established (since 
it allows only one SCO per ACL). Is this the intended behavior?

Thanks,
Radha


On 07/16/2004 10:29 AM, Marcel Holtmann wrote:

>as I said, between two devices BlueZ supports only one ACL link and one
>SCO link. These links a bi-directional so you can play and capture audio
>data at the same time. The limit to one SCO link is only a per ACL link
>limitation. If you open a second ACL to another device you can also have
>a second SCO link bound to that connection.
>
>Regards
>
>Marcel
>
>  
>
