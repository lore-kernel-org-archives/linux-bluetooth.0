Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] HCID problem? (Help)
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <c93f2a29050702205255ad3171@mail.gmail.com>
References: <c93f2a29050702074045ad46dd@mail.gmail.com>
	 <1120315516.10273.0.camel@pegasus>
	 <c93f2a2905070219331de8b1a0@mail.gmail.com>
	 <c93f2a29050702205255ad3171@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1120404768.10273.65.camel@pegasus>
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
Date: Sun, 03 Jul 2005 17:32:48 +0200

Hi Andy,

> More information coming... 
> 
> I dump the data at both PC & arm box when I connect from Nokia, it
> turns out that after request the Service Attribute, the PC side prints
> a connect request, but at arm side, it prints a disconnect request
> (with reason 0x13, user ended request), but obviously the Nokia does
> not send a disconnect request. the reasons are:
> 
> Before this request, all the other information are the same &
> correct: 
> write link policy settings, change connection packet type, Service
> search request, service attribute requestion. for all these request,
> the bluez gives the correct response data (serial profile, channel 3).

I need an "hcidump -X -V" to understand what is going on.

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
