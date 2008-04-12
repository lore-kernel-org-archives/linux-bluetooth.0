Return-Path: <cyrus@holtmann.org>
Message-Id: <0D66FC67-0CE2-4BFD-BA90-4627158FD98D@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <48008B46.3080601@suse.de>
Mime-Version: 1.0 (Apple Message framework v919.2)
Date: Sat, 12 Apr 2008 22:02:07 +0200
References: <194c6ea30804110133x276fd249p245cb6cbfd699f48@mail.gmail.com>
	<E673024B-BC5B-44C7-806D-38CA69FD680E@holtmann.org>
	<48008B46.3080601@suse.de>
Subject: Re: [Bluez-users] bluez3.30 audio/serial plugin issue
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Stefan,

>> it seems the solution to this is to use --enable-glib. For some  
>> reason
>> our eglib plugin loader doesn't work always. I never saw this problem
>> and still can't reproduce it.
>
> If you want to debug it, i could e.g. provide you with a qemu image of
> openSUSE FACTORY where it is reproducible.
>
> OTOH, if eglib is going away anyway, maybe there are more important  
> things to
> debug ;-)

I would like to ignore it, but I can't. Can you do a ls -la inside the  
installed plugins directory. Maybe libtool is messing this up. Or  
maybe is still tries to load the *.la files and fails, because of  
that. So please try to remove the *.la files since these are  
unimportant, but I can't tell libtool to not install them.

Regards

Marcel


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
