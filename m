Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Mats Erik Andersson <mats.andersson64@comhem.se>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <BAY102-W23476BE4A95129E0C076DBF0070@phx.gbl>
References: <BAY102-W23476BE4A95129E0C076DBF0070@phx.gbl>
Date: Mon, 09 Jul 2007 13:02:27 +0200
Message-Id: <1183978947.5105.9.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] configure: error: Bluetooth library is required
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Dear Robert,

s=F6n 2007-07-08 klockan 16:52 +0000 skrev Robert Rawlins:
> Thanks guys for your help on this so far,
>  =

> I've now tried the following command when configuring my utils:
>  =

> ./configure --with-bluez=3D/usr/local/lib
>  =

> and
>  =

> ./configure --with-bluez=3D/usr/local
> =

> And still come up against the same issue with the configuration
> telling me that it cannot find bluez, which really is bizarre and the
> make install for the libs confirms where they have been install
> as /usr/local/lib.
>  =

> inside that directory i can see the folowing files:
>  =

> libbluetooth.so.2.7.0
> libbluetooth.so.2
> libbluetooth.a
> libbluetooth.la
> libbluetooth.so
>  =

> Is there anything missing? Any other ideas? I'm running debian
> and have apt-get which i used to use for this kind of thing,
> unfortunately the only release of bluez i can find on there is a 3.7
> and we really need to be working with the latest build on this
> project. I believe there is some kind of svn for the latest build on
> debian but i wasted a couple of hours trying to get that working with
> no luck.
>  =


Did you remember to add your header files to

    /usr/local/include/bluetooth/    ?

Namely those that come from bluez-libs-3.12.
They are too easily forgotten, unless you are using debhelper
to build your own packages, and then installed =


   libbluetooth2_1rr.deb    and   libbluetooth2-dev_1rr.deb

or whatever you happened to call them.

Good luck,    Mats E A

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
