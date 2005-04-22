Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4268E475.8060807@gmx.ch>
From: Marco Trudel <mtrudel@gmx.ch>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] missing <linux/limits.h> include in storage.c	and
 hcitool.c
References: <4268DD2A.40604@gmx.ch> <1114168962.32265.66.camel@pegasus>
In-Reply-To: <1114168962.32265.66.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Fri, 22 Apr 2005 13:48:05 +0200

Hello Marcel

> this can't be, because we don't include header files from the kernel and
> so <linux/*> and <asm/*> are taboo.

I'm sorry. I should have mentioned that PATH_MAX is missing.
that would have been helpful...


> Does simply including <limits.h> is also working?

I checked the available headers. looks like sys/param.h is the choice.
(But just because it includes <linux/limits.h>)


regards
Marco


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
