Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0508220527500878ab@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] bluetoothd D-Bus interface proposals(draft 00.05)
In-Reply-To: <8c9e090508220504100c127e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <e1effdeb05081614151ee4f4bd@mail.gmail.com>
	 <9307f5f2050816154545b6f046@mail.gmail.com>
	 <e1effdeb05081805054a0be4aa@mail.gmail.com>
	 <9307f5f2050818135877575293@mail.gmail.com>
	 <8c9e090508191027e4646f1@mail.gmail.com>
	 <1124709468.23599.27.camel@pegasus>
	 <8c9e090508220504100c127e@mail.gmail.com>
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
Date: Mon, 22 Aug 2005 09:27:10 -0300

Hi folks,


It's possible register multiple D-Bus object paths. My suggestion=20
for handle multiple adapters is register a default path and paths
based on the device address.=20
eg: suppose two adapters(11:22:33:44:55:66, 77:88:99:00:11:22)

The possible paths are:

/org/bluez/bluetoothd/hci (default path - first adapter)
/org/bluez/bluetoothd/112233445566/hci (first adapter)
/org/bluez/bluetoothd/778899001122/hci (second adapter)

/org/bluez/bluetoothd/pan (default path - first adapter)
/org/bluez/bluetoothd/112233445566/pan (first adapter)
/org/bluez/bluetoothd/778899001122/pan (second adapter)
...

The service to list the adapter must be moved to the main path
(/org/bluez/bluetoothd) or to a new one /org/bluez/bluetoothd/devices.

The message handle function will become more complex, but I don't
see other solution.

Regards,
Claudio.

On 8/22/05, Elvis Pf=FCtzenreuter <elvis.pfutzenreuter@gmail.com> wrote:
>=20
> =20
> > this is a wrong argument. The case with only one adapter is the special
> > case. Multiple adapters are default.
>=20
>  You mean, e.g. a computer with multiple dongles?=20
> =20
>=20
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
