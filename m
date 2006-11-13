Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: kilian <Kilian.Lackhove@web.de>
To: bluez-users@lists.sourceforge.net
Date: Mon, 13 Nov 2006 19:07:13 +0100
References: <mailman.19693.1163411759.8777.bluez-users@lists.sourceforge.net>
In-Reply-To: <mailman.19693.1163411759.8777.bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Message-Id: <200611131907.13234.Kilian.Lackhove@web.de>
Subject: Re: [Bluez-users] Ubuntu edgy + Keyboard + dbus + security mode 3
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

> > I am using Ubuntu Edgy (bluez-utils 3.7.1-ubuntu-4) and an apple wireless
> > keyboard pro.
> >
> > Right now the keyboard is running without encryption and
> > authentification.
> >
> > I read i had to add the "dbus_pin_helper" option to my hcid.conf and run
> > bluez-pin --dbus. But as i run "bluez-pin --dbus" nothing happens (even
> > if i run it during "hidd --search" on another console)
> >
> > The log says Unknown Option "dbus_pin_helper line 26 "
> >
> > So whats wrong and what can i do to encrypt the connection?
>
> make sure "hidd --server --encrypt" is running. And the old PIN helper
> stuff is deprecated. Make sure a passkey agent is running to answer any
> PIN requests.
>
> Regards
>
> Marcel
>

Hi,

I added the --encrypt option to my /etc/defaults/bluetooth and restarted the 
deamon while running "bluez-pun --dbus". After a few seconds my keyboard 
worked again and hcitool con showed 

ACL XX:XX:XX:XX:XX:XX handle 42 state 1 lm MASTER AUTH ENCRYPT

But even though everything seemed to have worked fine, I wasnt asked for a 
pin... So my Question: Is everything really alright (and secure) now?


Regards,

Kilian

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
