Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <600883.33976.qm@web38512.mail.mud.yahoo.com>
References: <600883.33976.qm@web38512.mail.mud.yahoo.com>
Date: Fri, 06 Jul 2007 08:13:46 +0200
Message-Id: <1183702426.6351.125.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] hcitool
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

Hi Robert,

> Using the HCI tool utility I am trying to change the packet to HV1 but
> I get an error 
> 
> $ sudo hcitool cc --ptype=HV1  xx:xx:xx:xx:xx:xx
> Can't create connection: Input/output error
> 
> I get this error only if I try to change the packet types to HV1 HV2
> and HV3. For Data packets it works fine.

run hcidump -X -V to see a more verbose error. However don't even do
this at all. The hcitool cc command is for developers only. We use it
for testing. It has implications that you obviously don't understand
right now and trust me on that one. It is not what you want.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
