Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] What's the best way to go about device detection?
From: Marcel Holtmann <marcel@holtmann.org>
To: Rob Raper <djrobx@hotmail.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <BAY14-F23luevz176Rb00048253@hotmail.com>
References: <BAY14-F23luevz176Rb00048253@hotmail.com>
Content-Type: text/plain
Message-Id: <1084710239.4184.14.camel@pegasus>
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
Date: Sun, 16 May 2004 14:23:59 +0200

Hi Rob,

> Sorry for the newbie questions or if I'm missing some obvious concepts, but 
> I can't find any documentation for bluez, I've been primarily hacking 
> samples and learning by experimentation.  My RFCOMM implementation from a 
> single server to a single phone works perfectly, my problem has to do with 
> detection of a bluetooth device and signal strengths.
> 
> I'm writing an application that involves having cell phones that 
> automatically attach to servers when they come into range; like a 'roaming' 
> application.    When the phone gets closer to another server (when going 
> from room to room), the previous server should detach from it and the next 
> server will attach.  These servers are connected in their own way over 
> ethernet and coordinate the hand-off.
> 
> So, the server needs to look for available phones and report their signal 
> strengths, even if they're connected to another server.   When one 
> connection becomes significantly stronger, it will perform a coordinated 
> hand off (coordated by ethernet, not bluetooth).

without knowing the source code it is hard to say, but actually I think
this is a Bluetooth topology problem. Looks like that you are builing
complex scatternets and the master/slave roles and the role switch are
going to hit you badly.

You should start using RSSI for signal strength, because link quality is
a vendor specific value and differ from Bluetooth chip manufacturer to
the other. The other big advantage with RSSI is that with Bluetooth 1.2
you get it for free from an inquiry.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
