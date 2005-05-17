Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] problems syncing with bluetooth on multisync:
	evolution/blueotooth plugin
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1116359055.8933.6.camel@linux.site>
References: <1116313073.10074.8.camel@linux.site>
	 <4289A32A.1040907@citromail.hu>  <1116327973.21185.1.camel@linux.site>
	 <1116329361.10063.44.camel@pegasus>  <1116333932.32701.4.camel@linux.site>
	 <1116334551.10063.83.camel@pegasus>  <1116359055.8933.6.camel@linux.site>
Content-Type: text/plain
Message-Id: <1116366743.10063.122.camel@pegasus>
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
Date: Tue, 17 May 2005 23:52:23 +0200

Hi Tamer,

> I made what you wrote me: 
> 
> 1. bluepin is on my system not installed, only bluez-pin
> 2. sdp and hci were started (switched on at yast and listed with the
> command ps -A)
> 3. In yast2 the bluetooth section was switched "asking user for
> password"
> 4. I run multisync and tried to test a connection on my phone's channel
> 11

are you sure that channel 11 is the correct one? The hcidump says that
there is no service running on that channel.

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
