Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Andreas <andreas.knuth@daimlerchrysler.com>
Message-ID: <loom.20050318T140410-908@post.gmane.org>
References: <20050318104405.27323.qmail@web60903.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] Re: adding sdp service record attributes
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
Date: Fri, 18 Mar 2005 13:13:40 +0000 (UTC)

Ka Kin Cheung <michaelhku2002 <at> yahoo.com.hk> writes:


> 1.Is there any extra thing I have to put so that the
> service record and attributes are set in my PC
> permanently and not being erased after reboot?

Small shell script ?

> 2.After I add the service record and attribute, I wish
> to let T610 to search my PC as headset. So, is there
> any extra thing that I have to put in my code?

I guess you has to change your device class of your BT-device to phone. Please 
have a look into the hcid config file.

> 3.Is it possible that to browse the services in T610,
> and even other mobile devices, and then add the
> service records and attributes automatically?

Where? In our own SDP database? What would you like to reach with those?





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
