Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: 2.6.2 errors with DBT-120 (B2)
From: Marcel Holtmann <marcel@holtmann.org>
To: "Todd E. Johnson" <tejohnson@yahoo.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <402E4E02.9020600@yahoo.com>
References: <402E2E29.7040207@yahoo.com> <1076769794.14758.2.camel@pegasus>
	 <402E4E02.9020600@yahoo.com>
Content-Type: text/plain
Message-Id: <1076851622.14758.22.camel@pegasus>
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
Date: Sun, 15 Feb 2004 14:27:08 +0100

Hi Todd,

> I am attempting a simple proof of concept at the moment using the KDE 
> Bluetooth Framework.
> 
> I have configured  the local device class in hcid.conf to: "class 0x700408"
> 
> Then the KDE BTDialer needs the following set prior to using the app:
> 
> 'hciconfig hci0 voice 0x0060'
> 
> Once the app launches it connects via rfcomm to the phone and initiates 
> the followin AT commands (Here are the commands, with phone response)
> 
> AT+CIND=?
> +CIND: 
> ("battchg",(0-5)),("signal",(0-5)),("batterywarning",(0,1)),("chargerconnected",(0,1)),("service",(0,1)),("call",(0,1)),("roam",(0,1))
> OK
> AT+CIND?
> +CIND: 2,5,0,0,1,0,0
> OK
> AT+CMER=3,0,0,1
> OK
> AT+CLIP=1
> OK
> AT+CIND=?
> +CIND: 
> ("battchg",(0-5)),("signal",(0-5)),("batterywarning",(0,1)),("chargerconnected",(0,1)),("service",(0,1)),("call",(0,1)),("roam",(0,1))
> OK
> AT+CIND?
> +CIND: 2,5,0,0,1,0,0
> OK
> AT+CMER=3,0,0,1
> OK
> AT+BVRA=1
> 
> (As you can probably see above, the phone needs charging)
> 
> Upon initiation of 'AT+BVRA=1' the phone will ask "Say a Name or a 
> Command", which I can not hear, nor can it hear me.
> 
> And I am attempting to use the "Hands Free" dialer.  Vox seemed to work 
> with 2.4, but a new 2.6.2 kernel seems to break this.  I would assume 
> that this means it is using SCO over HCI since I no longer hear the 
> voice prompts from my phone, and the phone can not hear me.

I don't know what the problem with 2.6.2 and SCO over HCI and at the
moment I have no time to investigate. If your Bluetooth chip is CSR
based you can check the SCO mapping with "hciconfig hci0 revision".

> Ultimately I wish to use the phone for hands free calls, but  I will 
> also use the phone for vehicle offboard connectivity using the "Dial-Up 
> Networking" to obtain data for the vehicle.  For example, Navigation 
> data, E-Mail, Calendar, etc.
> 
> I am testing with a Sony Ericsson T608 (from Sprint).  The phone works 
> fine with a Jabra BT-200.
> 
> I'm moving towards following specifications defined at 
> http://www.ami-c.org/, but I am a little ways from achieving my final goal.
> 
> Sorry to seem completely clueless, but I am just beginning to use this 
> functionality within my setup, and I'm still learning.  Thanks for the 
> information so far!

Go ahead and start playing with BlueZ :)

Regards

Marcel




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
