Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Unresolved Symbols
From: Marcel Holtmann <marcel@holtmann.org>
To: the-flash@web.de
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040521161754.GB17561@mcmabrruq.sirius.net>
References: <20040520090502.GA4352@mcmabrruq.sirius.net>
	 <1085044940.4327.135.camel@pegasus>
	 <20040520114752.GA3125@mcmabrruq.sirius.net>
	 <1085056072.4327.166.camel@pegasus>
	 <20040521161644.GA17561@mcmabrruq.sirius.net>
	 <20040521161754.GB17561@mcmabrruq.sirius.net>
Content-Type: text/plain
Message-Id: <1085156734.22191.12.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 21 May 2004 18:25:34 +0200

Hi Florian,

> But, now the problem is that gnokii does not seem to be able to find my  
> bluetooth libraries/include files. I have installed bluez-libs-2.7 with  
> the --prefix=/usr option. Doing a 'configure --prefix=/usr' in the  
> gnokii-0.6.1 source directory gives
> 
> checking for the bluetooth support...
> checking for the struct sockaddr_rc in <bluetooth/rfcomm.h>... no
> checking for the MacOS X bluetooth support...
> checking CoreFoundation/CoreFoundation.h usability... no
> checking CoreFoundation/CoreFoundation.h presence... no
> checking for CoreFoundation/CoreFoundation.h... no
> checking IOBluetooth/Bluetooth.h usability... no
> checking IOBluetooth/Bluetooth.h presence... no
> checking for IOBluetooth/Bluetooth.h... no
> checking IOBluetooth/IOBluetoothUserLib.h usability... no
> checking IOBluetooth/IOBluetoothUserLib.h presence... no
> checking for IOBluetooth/IOBluetoothUserLib.h... no

actually this is a question for the Gnokii guys and you should look at
"./configure --help", because "--with-bluetooth" looks like a good
starting point.

Regards

Marcel






-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
