Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <0B0B4E49-71C5-4D33-A5E6-6304B2EFDA7F@ciziunas.com>
References: <0B0B4E49-71C5-4D33-A5E6-6304B2EFDA7F@ciziunas.com>
Date: Sun, 18 Jun 2006 20:57:30 +0200
Message-Id: <1150657050.8816.15.camel@localhost>
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

> I am having trouble getting my Samsung phone to permit my linux box  
> to use it as an rfcomm device.  The phone in question is a Samsung  
> t809.  From what I can tell, the phone attempts to authenticate to  
> the computer with the pin I gave it, it then successfully pairs, and  
> tries "Getting a service list...".  This is where things go wrong.   
> The phone errors out with a "Service not found".  It then refuses to  
> permit me to authorize the computer to use it as an rfcomm device.  I  
> think it the latter has everything to do with some flawed logic that  
> the phone designers had that if it gets a "Service not found", it is  
> not really paired with the device.  Attached is an hcidump output,  
> perhaps someone more intelligent than myself can enlighten me on what  
> I can do to handle this situation?  Thanks!

I only see connections from the phone to your Linux box and thus it is
totally okay that it asks for supported services and disconnects if it
doesn't find any. Establish the connection from the Linux box.

Regards

Marcel




_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
