Return-Path: <cyrus@holtmann.org>
Message-ID: <4884E6D3.8020102@suse.de>
Date: Mon, 21 Jul 2008 21:43:15 +0200
From: Stefan Seyfried <seife@suse.de>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <4884D04F.9000800@suse.de>
In-Reply-To: <4884D04F.9000800@suse.de>
Subject: Re: [Bluez-devel] Mouse connect problem, since 3.36?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Stefan Seyfried wrote:

> The mouse will not reconnect until I issue a "Connect" again.

One more thing: the mouse no longer seems to "time out". Before, after 30
minutes of inactivity, the mouse would disconnect and when moving it, it wo=
uld
reconnect with a message like:

input: Logitech MX1000 mouse as
/devices/pci0000:00/0000:00:1d.0/usb1/1-1/1-1:1.0/hci0/acl0007613F1B6D/inpu=
t/input8

This is no longer the case. If i leave the machine for some time, the keybo=
ard
reconnects and gets new input device, but the mouse just continues to work
without such a log message.
-- =

Stefan Seyfried
R&D Team Mobile Devices            |              "Any ideas, John?"
SUSE LINUX Products GmbH, N=FCrnberg | "Well, surrounding them's out."

This footer brought to you by insane German lawmakers:
SUSE Linux Products GmbH, GF: Markus Rex, HRB 16746 (AG N=FCrnberg)

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great priz=
es
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
