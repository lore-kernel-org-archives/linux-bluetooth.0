Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <420D3997.9040406@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] btsco and headsets questions
References: <20050211223950.23217.qmail@web50203.mail.yahoo.com>
In-Reply-To: <20050211223950.23217.qmail@web50203.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Fri, 11 Feb 2005 16:02:47 -0700

Paul

> I did some hacks on btsco2 and now I can press connect button on my HS and it disconnects the SCO
> channel. Then I press it again twice, and it connects the SCO channel again.

you mean twice in a row means you want to connect? why not have it 
toggle like most phones do?

as long as your patch doesn't introduce a dependency on the kde stuff, 
we should have a serious look.

i'd rather have a context diff than the complete file. (use cvs diff -u)

brad


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
