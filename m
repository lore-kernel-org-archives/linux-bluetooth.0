Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] HCID problem? (Help)
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <c93f2a29050702074045ad46dd@mail.gmail.com>
References: <c93f2a29050702074045ad46dd@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1120315516.10273.0.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 02 Jul 2005 16:45:15 +0200

Hi Andy,

> HCI command do not complete after "inquiure request" completed
> succesfully.
> 
> I run "hcitool inq" & "hcidum", the output is as following:
> 
> HCIDump - HCI packet analyzer ver 1.16
> device: hci0 snap_len: 1028 filter: 0xffffffff
> < HCI Command: Inquiry (0x01|0x0001) plen 5
>   33 8B 9E 08 00
> > HCI Event: Command Status (0x0f) plen 4
>   00 01 01 04
> > HCI Event: Inquiry Result (0x02) plen 15
>   01 91 DC AC EE 02 00 01 00 00 04 22 50 C5 57
> > HCI Event: Inquiry Complete (0x01) plen 1
>   00
> 
> (based on the packet dump, the inquery is succesful, and hcid should
> complete), but hcitool output is:
> Inquiring ...
> Inquiry failed.: Connection timed out
> 
> Is it a HCID problem? How can I fix it? I thought it will also cause
> packet lost & program hang.

what kernel and libs/utils are you using. And what do you think has hcid
to do with an inquiry?

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
