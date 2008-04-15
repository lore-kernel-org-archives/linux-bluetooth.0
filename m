Return-Path: <cyrus@holtmann.org>
Message-ID: <194c6ea30804142026j670952dake4b521389687f8ad@mail.gmail.com>
Date: Tue, 15 Apr 2008 11:26:45 +0800
From: "dong yan" <semiydsemiyd@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <E673024B-BC5B-44C7-806D-38CA69FD680E@holtmann.org>
MIME-Version: 1.0
References: <194c6ea30804110133x276fd249p245cb6cbfd699f48@mail.gmail.com>
	<E673024B-BC5B-44C7-806D-38CA69FD680E@holtmann.org>
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

Hi Marcel:

    problem solved by adding --enable-glib.thanks.



semiyd


2008/4/11, Marcel Holtmann <marcel@holtmann.org>:
> Hi,
>
> >    i just upgraded my bluez from 3.26 to 3.30...It's said that all
> > audio/serial...services are moved into plugin libraries...
> >    It seems i got a problem while loading these new plugins,here's
> > the log:
> >
> > hcid[173]: Bluetooth HCI daemon
> > hcid[173]: Enabling debug information
> > hcid[173]: HCI dev 0 registered
> > hcid[173]: Starting SDP server
> > hcid[173]: Adding rec : 0x4d8c0
> > hcid[173]: with handle : 0x1
> > hcid[173]: Adding rec : 0x4d980
> > hcid[173]: with handle : 0x0
> > hcid[173]: Service classes 0x00
> > hcid[173]: Creation of inotify context failed
> >
> > hcid[173]: Loading plugins /bluetooth//lib/bluetooth/plugins
> > hcid[173]: Can't load plugin:
> > /bluetooth//lib/bluetooth/plugins/libaudio.so: invalid mode for
> > dlopen(): Invalid argument
>
> it seems the solution to this is to use --enable-glib. For some reason
> our eglib plugin loader doesn't work always. I never saw this problem
> and still can't reproduce it.
>
> Regards
>
> Marcel
>
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by the 2008 JavaOne(SM) Conference
> Don't miss this year's exciting event. There's still time to save $100.
> Use priority code J8TL2D2.
> http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
