Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <7D0614E0-109E-4E3F-9017-79874501E212@ciziunas.com>
References: <0B0B4E49-71C5-4D33-A5E6-6304B2EFDA7F@ciziunas.com>
	<1150657050.8816.15.camel@localhost>
	<7D0614E0-109E-4E3F-9017-79874501E212@ciziunas.com>
Date: Sun, 18 Jun 2006 22:10:29 +0200
Message-Id: <1150661429.8816.24.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Samsung T809/D820 association issues.
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Vincas,

> When I try to get the computer to initiate, I get a "connection  
> refused".  Attached is the hcidump output of an  "echo ATZ > /dev/ 
> rfcomm0" , which does result in "rfcomm0: connection refused".  I did  
> "Authorize" the linux box from the phone's menu, so I'm still  
> somewhat confused as to why it's denying.

check with sdptool what services the phone supports on which channels.

Regards

Marcel




_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
