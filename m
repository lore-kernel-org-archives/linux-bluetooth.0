Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Michal Semler (volny.cz)" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] RE: Logitech multimedia keys off by one
References: <406C1E19.7090003@ntlworld.com> <1080911347.2836.62.camel@pegasus>
In-Reply-To: <1080911347.2836.62.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200404021856.17235.cijoml@volny.cz>
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
Date: Fri, 2 Apr 2004 18:56:16 +0200

Dne p=E1 2. dubna 2004 15:09 Marcel Holtmann napsal(a):
> Hi Oli,
>
> > Also, a question to Mr Holtmann: The latest release of the Bluez package
> > with bluez-libs-2.6 and bluez-utils-2.6 - does this negate the need for
> > the CVS version for tools like hid2hci and bthid?
>
> the libs2 and utils2 are the next generation and they are completely
> independent from the current version. Actually with bluez-libs-2.6 it
> should be possible to port the bthid to use the old library. I fixed
> some internal stuff and this should make it possible to get the HID
> descriptor from a device.

GREAT! Marcel pls do it as soon as possible! :)*****


>
> At the moment I am also thinking of moving pand and dund into the utils
> package to lower my maintenance overhead.

It is a good choice.

Michal

>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id=3D1470&alloc_id=3D3638&op=3Dcli=
ck
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
