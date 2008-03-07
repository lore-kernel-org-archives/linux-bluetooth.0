Return-Path: <cyrus@holtmann.org>
Message-Id: <0FC90F4B-F2CB-4770-BF2F-01DE48E3C975@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <75FAE26125E34CEBB2A6589F506A6784@iMe>
Mime-Version: 1.0 (Apple Message framework v919.2)
Date: Fri, 7 Mar 2008 13:16:04 +0100
References: <fqnfkk$9np$1@ger.gmane.org> <1521D68760504C61837D70AA89588A3E@iMe>
	<A3582650-894E-4E59-A156-42D2C5D973C0@holtmann.org>
	<75FAE26125E34CEBB2A6589F506A6784@iMe>
Subject: Re: [Bluez-users] How to change the Hci packet size?
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

Hi,

> Thanks.. but I remember something in the Bluetooth standard like  
> 'continue'
> flag in each HCI packet.. Who is responsible to fill this?

the L2CAP layer will fill this in.

Regards

Marcel


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
