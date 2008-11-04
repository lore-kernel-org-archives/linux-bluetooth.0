Return-Path: <cyrus@holtmann.org>
Message-ID: <49107D3D.40906@powercraft.nl>
Date: Tue, 04 Nov 2008 17:50:05 +0100
From: Jelle de Jong <jelledejong@powercraft.nl>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <491079A8.2010403@powercraft.nl>
In-Reply-To: <491079A8.2010403@powercraft.nl>
Subject: Re: [Bluez-devel] why do the keyboard en mouse not reconnect on
 startup of bluetoothd (see hcidump and bluetooth debug logs)
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Jelle de Jong wrote:
> Hello everybody,
> 
> I attached a logfile with hcidump and bluetooth --debug logs
> 
> I have two trusted devices but the do nor reconnect after staring up
> bluetoothd. hcidump does show that they are sending information. What is
> going on here?
> 
> Kind regards,
> 
> Jelle
> 

I did some more debugging on this issue, and it seems this is the situation:

when a device is turned on then paired with an running bluetoothd the
device works. then you restart your system or the bluetoothd without
switching the devices off/on. So the device is still running as before
the reboot. hicdump shows it successfully transmits the data, but
bluetoothd does not do anything with the data. When turning the device
off and then on hcidump shows a disconnect and mode change and after
that bluetootd will connect the device again and its working. This means
turning off on all devices after bluetoothd restarts. This is kind of a
bug in my opinion, what do the developers think?

I am willing to donate some dutch stroopwafels if this can be fixed.

Kind regards,

Jelle

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
