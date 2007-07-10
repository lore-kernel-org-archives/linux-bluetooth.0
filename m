Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <5307d89f0707101513u15ed1f65i5721ae23ac14ef07@mail.gmail.com>
Date: Wed, 11 Jul 2007 00:13:08 +0200
From: "Patrick Libert" <patrick.libert@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1183623412.6351.92.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
References: <5307d89f0706301124p2326b5d9k34a95779fccc0248@mail.gmail.com>
	<1183623412.6351.92.camel@aeonflux.holtmann.net>
Subject: Re: [Bluez-users] Info Dinovo
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

On 7/5/07, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Patrick,
>
> > I'm using Dinovo keyboard and mouse for a long time now with ubuntu.
> > With ubuntu Dapper it worked perfect.
> > All I did is modify /etc/init.d/bluetooth:
> > I changed HIDD_ENABLED=1
> > and I added HIDD_OPTIONS="-i xx:xx:xx:xx:xx:xx --connect
> > XX:XX:XX:XX:XX:XX  --master --server  "
>
> was wrong in the beginning and is still wrong.

Is the /etc/init.d/bluetooth not the right file for loading hidd
-server at startup
Indeed when in a type in a terminal:  hidd -server it will work correctly.
Can you tell me where to load hidd --server with ubuntu
>
> > Then I did "sudo hidd --search" and pressed the pairing button on the
> > keyboard and it works perfectly, even when I reboot.
> >
> > Now, with the latest editions from ubuntu this doesn' work anymore.
> > When I reboot my computer, or wait to long, my keyboard is lost.
> > A lot of people are complaining about this on ubuntuforums.org.
> > Could you tell me what I should change?
>
> No idea what is wrong here, but it is actually working fine with hidd in
> --server mode only and with the new input service.
>
> Regards
>
> Marcel
>
>
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by DB2 Express
> Download DB2 Express C - the FREE version of DB2 express and take
> control of your XML. No limits. Just data. Click to get it now.
> http://sourceforge.net/powerbar/db2/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
