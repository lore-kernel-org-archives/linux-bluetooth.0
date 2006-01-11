Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] bluetooth settings in debian
From: Fredy Pulido =?ISO-8859-1?Q?L=F3pez?= <digitalfredy@debiancolombia.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20060106100921.4675.qmail@web60620.mail.yahoo.com>
References: <20060106100921.4675.qmail@web60620.mail.yahoo.com>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1136943042.3165.23.camel@yoda.digitalfredy.org>
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
Date: Tue, 10 Jan 2006 20:30:42 -0500

El vie, 06-01-2006 a las 10:09 +0000, ronny hidayat escribi=F3:
> Hello again,
> =20
> Do you know what command should I use to send/receive file via
> bluetooth ?
> Where should I put PIN number ?
The PIN number is in /etc/bluetooth/pin but if your pin_helper not read
it (it's the default in debian) you needs change your pin_helper
> Are there any documentation too ?
> =20
> Thanks
> Ronny
>=20
> Marcel Holtmann <marcel@holtmann.org> wrote:
>         Hi Ronny,
>        =20
>         > I have Linux Debian 2.6, bluetooth & Bluez already
>         installed.
>         > But I don't know how to change setting for bluetooth (like
>         friendly
>         > name & services).
>         > How / Where can I find those settings ?
>        =20
>         Look at /etc/bluetooth/hcid.conf.
>        =20
>         > I want to make program like rfcomm server that can receive
>         connection
>         > up to 7 client and then sending messages between them.
>         > Does bluez support this ?
>        =20
>         Yes.
>        =20
>         > Maybe anyone has documentation or sample program for t his ?
>        =20
>         Look at the source code of bluez-utils.
>        =20
>         Regards
>        =20
>         Marcel
>        =20
>=20
> Send instant messages to your online friends
> http://uk.messenger.yahoo.com=20
>=20



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
