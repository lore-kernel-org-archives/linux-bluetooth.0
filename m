Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] problems syncing with bluetooth on multisync:
	evolution/blueotooth plugin
From: Tamer Higazi <tamer23@myrealbox.com>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1116329361.10063.44.camel@pegasus>
References: <1116313073.10074.8.camel@linux.site>
	 <4289A32A.1040907@citromail.hu>  <1116327973.21185.1.camel@linux.site>
	 <1116329361.10063.44.camel@pegasus>
Content-Type: text/plain
Message-Id: <1116333932.32701.4.camel@linux.site>
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
Date: Tue, 17 May 2005 14:45:32 +0200

Dear Marcell! 
kbluetoothd is running and up. Why it still doesn't work, is something I
don't understand. Either I downloaded, compiled and installed bluez-pin.
Inside the hcid.conf I modified the line: 

# PIN helper
pin_helper /usr/bin/bluez-pin
Tamer


Could it be that the dbus pin-helper is not active?!

#dbus_pin_helper;

It is commented in the hcid.conf file


For any help

Thank you in advance

Tamer 
Am Dienstag, den 17.05.2005, 13:29 +0200 schrieb Marcel Holtmann:
> Hi Tamer,
> 
> > Thank you for your help. I discovered that 'bluez-pin' was on the system
> > not installed. I downloaded the package, but nothing happened. What
> > could it be that the same error do still exist?!
> 
> make sure that kdebluetooth is installed and running.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by Oracle Space Sweepstakes
> Want to be the first software developer in space?
> Enter now for the Oracle Space Sweepstakes!
> http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
> 



-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
