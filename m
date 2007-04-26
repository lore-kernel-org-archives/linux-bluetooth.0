Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <00cd01c787cc$44fda460$8935c70a@dlh.st.com>
References: <00cd01c787cc$44fda460$8935c70a@dlh.st.com>
Date: Thu, 26 Apr 2007 21:40:50 +0200
Message-Id: <1177616450.14980.117.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Esco implementation patch
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Sumeet,

> Actually when the ADD_SCO_CONNECTION is not supported a command complete is
> generated with the status 0x01 (Unknown HCI Command). The controller doesn't
> know about this command at all. If the controller had known about this
> command then it will generate a command status with suitable status code.

I reviewed that patch and the current attempt to support eSCO is wrong
and eSCO shouldn't be an alternate if SCO fails. In case the LMP_ESCO
features bit is set, then we should always use the new eSCO commands to
setup the audio link. Only in case of Bluetooth 1.1 adapters and earlier
we fall back to the old SCO setup. My understanding is that the new eSCO
setup routine of Bluetooth 1.2 chips or later can handle the remote
Bluetooth 1.1 devices without problems.

Please also use le32 for 32-bit size variables in HCI commands and
events. Don't diff *.mod.c files. These are auto-generated.

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
