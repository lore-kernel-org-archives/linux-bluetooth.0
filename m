Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] can't get bthid
From: Marcel Holtmann <marcel@holtmann.org>
To: Mykel <Mykel@mWare.ca>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <408C72DA.4070205@mWare.ca>
References: <408C4D8D.7090104@yahoo.com.au>  <408C5F5C.1040501@mWare.ca>
	 <1082941746.28880.111.camel@pegasus>  <408C72DA.4070205@mWare.ca>
Content-Type: text/plain
Message-Id: <1082973170.28880.114.camel@pegasus>
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
Date: Mon, 26 Apr 2004 11:52:50 +0200

Hi Mykel,

> Hey hey! I got somewhere! (Thanks! I'm so happy about this!) But after
> reboot, I'm not sure what I was doing wrong... It seems I need to hit
> connect every time I restart... Maybe I have the sequence of commands
> wrong?
> 
> bthid -d
> hcid
> bthid -c xx:xx:xx:...

you should start hcid before you start any other Bluetooth daemon and
the "bthid -c" is only needed once. The HID device will reconnect by
itself after you pressed a key.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
