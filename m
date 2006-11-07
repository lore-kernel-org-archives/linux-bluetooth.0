Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Tue, 7 Nov 2006 16:52:57 +0100
From: Stefan Seyfried <seife@suse.de>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Message-ID: <20061107155257.GB22290@suse.de>
References: <4550A095.6060000@gmx.de>
MIME-Version: 1.0
In-Reply-To: <4550A095.6060000@gmx.de>
Subject: Re: [Bluez-users] usb-device cannot be found by other bluetooth
	devices
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

Hi Smobbl

(i would complain to your parents about that name :-)

On Tue, Nov 07, 2006 at 04:04:53PM +0100, Smobbl_Bobbl wrote:
> hi!
> =

> can someone help me to make my usb-stick "searchable" by other devices?
> =

> i installed mandriva linux 2007, with all the bluetooth things.
> i can send files to other devices (handy, pda...), but if i search in my =

> handy for other near devices, i cannot find the usb-stick!
> if i want the handy to pair with the pc (initiated by pc), the handy =

> says i have to input my password. if i do so, my phone shows a =

> progressbar, but in the end it fails.

do you have a passkey-agent registered?
> =

> can someone help me to make my usb-stick "searchable" by other devices?

use "apitest" to set the DiscoverableTimeout to 0:

    apitest SetDiscoverableTimeout 0

then set your device to discoverable:

    apitest SetMode discoverable

verify your settings with

    apitest IsDiscoverable
    apitest GetMode
    apitest GetDiscoverableTimeout

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
