Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Michal Semler <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: bluez-users@lists.sourceforge.net, tsw@johana.com
Subject: Re: [Bluez-users] New bluetooth device.  Now what?
References: <20041003100129.15441.qmail@web60805.mail.yahoo.com>
In-Reply-To: <20041003100129.15441.qmail@web60805.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200410031244.29938.cijoml@volny.cz>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 3 Oct 2004 12:44:29 +0200

edit /etc/bluetooth/rfcomm.conf

and then rfcomm bind all and start communicate

M.

Dne ne 3. =F8=EDjna 2004 12:01 Tom Watson napsal(a):
> OK, I've got the kernel stuff working to my USB dongle.  It is a D-Link
> DBT-120, and up to that point it all is OK.
>
> Now I want to connect to a device.  It is an Earthmate Blue Logger GPS
> (quite a nice little yellow box!).  My assumption is that eventually I wa=
nt
> the equivalent of a "serial" type connection that a program similar to
> "minicom" can talk to.
>
> I've entered a few commands, and I'm a little frustrated.  How do I get
> something like this to work?
>
> Some commands that DO work are:
> [bluetooth]$ hcitool inq
> Inquiring ...
>         00:90:4B:2A:9D:9D       clock offset: 0x219e    class: 0x001f00
> [bluetooth]$ hcitool scan
> Scanning ...
>         00:90:4B:2A:9D:9D       Earthmate Blue Logger GPS
>
> Some that DON'T are:
> [bluetooth]$ rfcomm show rfcomm0
> Get info failed: No such device
> [bluetooth]$ rfcomm bind rfcomm0
> Can't create device: Operation not permitted
>
> I think I have the configuration file OK, but I'm not exactly sure.
>
> Do I need to have some configuration file setup?  The documentation isn't
> very clear here (as I can see).  Do I access this with RFCOMM??  How do I
> connect to the device with 'minicom'??  Do I need to setup some device
> files??
>
> I have half working, but not a full connection.  It is almost there, but
> not quite.
>
> Help.....
>
> =3D=3D=3D=3D=3D


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
