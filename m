Return-Path: <cyrus@holtmann.org>
Message-ID: <4C518373.6000706@aircable.net>
Date: Thu, 29 Jul 2010 10:34:43 -0300
From: Manuel Naranjo <manuel@aircable.net>
MIME-Version: 1.0
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: Johan Hedberg <johan.hedberg@gmail.com>,
	BlueZ <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH][RFC] Fix SDP resolving segfault
References: <4C46324D.5070800@aircable.net>	<20100721101934.GA12188@jh-x301>	<4C470E2D.7000607@aircable.net>	<AANLkTi=8=BUThjVdc4EN_8uupGKmdgHQzGOe560Cv+pm@mail.gmail.com>	<AANLkTi=jzZScnCK6rFpKjBJesnw=71y5hNG3kDBhxv1u@mail.gmail.com>	<4C505806.3040508@aircable.net>	<AANLkTikRQfhAKm-UW+on+ZeEp709z_ku_NDjeVD_US1b@mail.gmail.com> <AANLkTi=9Top+9kRwtZj-nZw8szQU4ff9CTSNSGuexmEL@mail.gmail.com>
In-Reply-To: <AANLkTi=9Top+9kRwtZj-nZw8szQU4ff9CTSNSGuexmEL@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Luiz,
> I guess I finally figure out what could be the source of your
> problems, we are not removing the watches when caching the session and
> since the context is already freed bt_cancel_discovery doesn't work.
>
> The attached patch should fix this problem, Im also reseting the
> internal data of the session by doing sdp_set_notify so if we are not
> closing the session it will then reset the callback and data to NULL.
>    

Looks like a possible fix nice work thanks!.

Unfortunately I will not be able to test until next week. I let you know 
when I get some results, I got my netbook today in a mall with some more 
debug messages, I added a few calls to error in the search_cb that 
prints all the pointer numbers when it gets called, that will get some 
more information. I could fix the problem this way as well, but this is 
working on the simpthon not on the cause like yours.

You think the hole problem is because of the cache? Wow I never thought 
it that way. But it makes sense. It also makes sense to move cleanup 
processes inside the cleanup function.

I will give this a try and let you know. Maybe I can results before the 
Tuesday, but I doubt it.

Manuel

