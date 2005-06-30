Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] problems when connect Nokia 7650 to an arm box
	with BlueZ
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <c93f2a29050629200733f9acd6@mail.gmail.com>
References: <c93f2a29050629200733f9acd6@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1120108334.15397.141.camel@pegasus>
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
Date: Thu, 30 Jun 2005 07:12:14 +0200

Hi Andy,

> I am currently connect Nokia 7650 to an arm box (kernel 2.4.27) via
> Serial Profile using BlueZ(libs-2.14, utils-2.14, hcidump-1.16).  The
> problems are:
>  
> 1. Every twice connections, one success, and the other said time out.
> 2. After receive about 5 message from arm box, it do not send back any
> data, from hcidump output, it simplely stalls.
> 3. Every twice sending message from Nokia, one success, and one has no
> effects, hcidump has no output also.
> 4. If I start hcidump before connection, then I can never connect
> successfully.
>  
> But everything seems to work well when I connect the Nokia 7650 to a
> PC.

update bluez-libs and bluez-utils and you should also update your
kernel. The 2.4.27 is quite old and it might have bugs.

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
