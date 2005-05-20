Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] RFComm library
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1116566219.8454.4.camel@delta>
References: <1116566219.8454.4.camel@delta>
Content-Type: text/plain
Message-Id: <1116581547.8970.1.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 20 May 2005 11:32:27 +0200

Hi Will,

> Ok, so I needed some simple way to use Bluetooth in my application.
> I've basically just done some copying and pasting from the source of the
> tools hcitool and rfcomm, so I can't exactly claim any of this work as
> my own.  It's all under Marcel's GPL still, and will probably stay that
> way.  This is just so far a simple way of doing a bluetooth inquiry/scan
> and getting results back.  I'll take pointers on how to do things
> better/more effectively, but I can't guarantee much.
> What's included is the source for the library, and a sample app.
> The sample app does a bluetooth scan, finds my phone (identified by the
> name 'Will', and then connects to the serial port offered.  The AT+CBC
> that I have in there returns the battery status of my phone, it's just
> my test case.  
> Using the library is explained in the rfcomm-library.h file, and
> hopefully it makes sense.
> 
> This is just to help others who are trying to do what I needed to do,
> hopefully someone will benefit from this.

nice stuff, but I think totally unneeded. And in most cases there is no
need to create a TTY. You can use the RFCOMM socket directly which will
then result in less code.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
