Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb050811101346f4ddd6@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] bluetoothd D-Bus interface proposals(draft 00.03)
In-Reply-To: <42F36564.9010505@palmsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <e1effdeb05080412401bc562f6@mail.gmail.com>
	 <42F36564.9010505@palmsource.com>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 11 Aug 2005 14:13:02 -0300

Hi folks,


I am sending a new draft(v00.03) of the bluetoothd D-Bus interfaces.

BlueZ community, please send your feedback. I need collect your opinions
and discuss with Marcel.

The most important part for now is hci, hciconfig, sdp and bluetoothd.

The documents are available at:
http://www.cin.ufpe.br/~ckt/bluez/

Fred, thanks for your comment. I am not sure if is useful send
signal for connection/disconnection from hci. I think they should
be restricted to object hierarchy subsection(pan, dun, rfcomm, ..).
But we can discuss with the BlueZ community in order to verify if
these signals will be required or not.


Regards,
Claudio.


On 8/5/05, Frederic Danis <frederic.danis@palmsource.com> wrote:
> Hello Claudio,
>=20
> I think it could be usefull to get remote device
> connection/disconnection signal from hci.
>=20
> Regards,
> Fred
>=20
> -----------------------------------------------
> It is not by improving the oil lamp that one invents the electric bulb!
> -----------------------------------------------
> Danis Frederic            PalmSource Europe
> Software engineer
> Mail : mailto:frederic.danis@palmsource.com
> -----------------------------------------------
>=20
>=20
>=20
> Claudio Takahasi wrote:
>=20
> >Hi folks/Marcel,
> >
> >I am sending a new version of bluetoothd D-Bus interfaces document.
> >
> >When you have time, please look this document to see if the interfaces
> >names, object paths and services are following your ideas.
> >
> >The documents are available at:
> >http://www.cin.ufpe.br/~ckt/bluez/
> >
> >
> >Regards,
> >Claudio
> >
> >
> >-------------------------------------------------------
> >SF.Net email is Sponsored by the Better Software Conference & EXPO
> >September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practi=
ces
> >Agile & Plan-Driven Development * Managing Projects & Teams * Testing & =
QA
> >Security * Process Improvement & Measurement * http://www.sqe.com/bsce5s=
f
> >_______________________________________________
> >Bluez-devel mailing list
> >Bluez-devel@lists.sourceforge.net
> >https://lists.sourceforge.net/lists/listinfo/bluez-devel
> >
> >
>=20
>=20
> -------------------------------------------------------
> SF.Net email is Sponsored by the Better Software Conference & EXPO
> September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practic=
es
> Agile & Plan-Driven Development * Managing Projects & Teams * Testing & Q=
A
> Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
