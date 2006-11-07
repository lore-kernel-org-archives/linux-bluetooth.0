Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Tue, 7 Nov 2006 11:58:36 +0100
From: Stefan Seyfried <seife@suse.de>
To: Peter.Weiss@consol.de, BlueZ users <bluez-users@lists.sourceforge.net>
Message-ID: <20061107105836.GK11347@suse.de>
References: <11418107.1162886121971.OPEN-XCHANGE.WebMail.www@kalender.consol.de>
MIME-Version: 1.0
In-Reply-To: <11418107.1162886121971.OPEN-XCHANGE.WebMail.www@kalender.consol.de>
Subject: Re: [Bluez-users] How to identify Bluetooth hardware on Acer
	notebook
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

On Tue, Nov 07, 2006 at 08:55:21AM +0100, Peter Weiss wrote:
> Hello,
> =

> I don't know how to setup my bluetooth interface on my Acer Notebook
> (a built in one):
> =

> Reading the docs I think it's connected to the serial port:

I don't think so.
 =

> # dmesg | grep serial
> serial8250: ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
> # setserial -g /dev/ttyS1        =

> /dev/ttyS1, UART: 16550A, Port: 0x02f8, IRQ: 3
> =

> The bluetooth module is loaded:

[...]

> I think that's because the internal modem is connected to ttyS1.

I also don't think so, but that's a different thing :-)

> So, how do I get access to the bluetooth controller?

probably by "modprobe hci_usb"

> How can I identify the bluetooth hardware?

probably with "lsusb"

I have not seen a built-in BT device that was not USB for a long time.
Maybe you need to switch it on with some hotkey first or use the acerhk
package.
-- =

Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, N=FCrnberg  | "Well, surrounding them's out." =


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
