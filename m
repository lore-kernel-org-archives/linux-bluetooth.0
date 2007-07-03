Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <18a15270707021204o3ffc0021pc3f0d4b0ec278c39@mail.gmail.com>
References: <18a15270707021204o3ffc0021pc3f0d4b0ec278c39@mail.gmail.com>
Date: Tue, 03 Jul 2007 05:28:26 +0200
Message-Id: <1183433306.6351.19.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Cc: cbe-oss-dev@ozlabs.org, bluez-devel@lists.sf.net
Subject: Re: [Bluez-devel] [PATCH] bluetooth: reset unexpected connections
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
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Ranulf,

> Send a reset command to any device that sends us data when there is no
> active
> connection to that device. This hopefully discourages the device from
> sending 
> any more data which causes the syslog to fill up rapidly otherwise.
> 
> Signed-off-by: Ranulf Doswell <ralf@ranulf.net>
> 
> ---
> 
> An example device which causes this problem is the Sony Playstation
> six-axis 
> controller which continues sending data even after the host is
> rebooted as
> the linux kernel stack returns before the controller's stack times
> out.

this is not a proper fix for this problem. And you only reset the local
host controller. There is no way to send a reset to the remote device.

Did you ever used hcidump and try to find out, why the other side still
things that we are connected. Especially why the local controller things
that we are still connected.

The PS3 remote controller (and the PS3 itself) have special hacked up
version of Bluetooth firmware to play nice with remote wakeup. So it
might simply be an issue with them and it might be better we declare
them broken instead of adding nasty crap in a clean Bluetooth core. Your
patch is nasty crap since I haven't seen any real argument why we should
reset our local controller in that case. It is wild guessing.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
