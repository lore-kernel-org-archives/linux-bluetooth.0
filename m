Return-Path: <cyrus@holtmann.org>
Message-ID: <47BB1A27.9090202@wurmsdobler.org>
Date: Tue, 19 Feb 2008 18:04:23 +0000
From: Peter Wurmsdobler <peter@wurmsdobler.org>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <47BAC7BC.7050503@wurmsdobler.org>
	<e378cfb20802190657m69936857ob676ad575842c222@mail.gmail.com>
In-Reply-To: <e378cfb20802190657m69936857ob676ad575842c222@mail.gmail.com>
Subject: Re: [Bluez-users] Unable to get on D-Bus
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

Hello,

many thanks for the hints.

> 1. An earlier hcid is already running. Check ps ax | grep hcid to confirm.
> 2. You are not root while running hcid .
Neither. The reason was somewhere else.

ltib configures bluez with prefix /usr , but moves some config 
files/directories from /usr/etc to /etc . When I added dbus manually to 
ltib, I ran configure with /usr , too, but without realising that then 
dbus would not find the bluetooth related config file in 
/usr/etc/dbus-1/system.d/, because ltib would have moved it to 
/etc/dbus-1/system.d/.

Solution: make sure that bluez and dbus use the same configuration 
directories and that they are compiled with the same prefix.

One step further. More problems expected.
peter



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
