Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] can't get bthid
From: Marcel Holtmann <marcel@holtmann.org>
To: Mykel <Mykel@mWare.ca>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <408C5F5C.1040501@mWare.ca>
References: <408C4D8D.7090104@yahoo.com.au>  <408C5F5C.1040501@mWare.ca>
Content-Type: text/plain
Message-Id: <1082941746.28880.111.camel@pegasus>
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
Date: Mon, 26 Apr 2004 03:09:06 +0200

Hi Myke,

> I have the exact same problem! I just joined this mailing list yesterday 
> to ask this same question.
> I have a BlueTooth equipped laptop and I have the Logitech cradle 
> plugged in... I have no idea what I'm doing tho. I've seen 
> http://www.bueche.ch/comp/mx900/mx900.html and followed what I can, but 
> I still get the same errors.
> 
> But like I said, I'm just doing this stuff blindly, I'm quite clueless 
> at most of this. :(

you must start a daemon instance first. Run "bthid -d" before trying to
use the "-c" switch.

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
