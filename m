Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] /dev/rfcommX device not created in time
From: Marcel Holtmann <marcel@holtmann.org>
To: Steven Yap <syap@shaw.ca>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1084674433.3927.14.camel@obsolescence>
References: <1084674433.3927.14.camel@obsolescence>
Content-Type: text/plain
Message-Id: <1084708820.4184.9.camel@pegasus>
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
Date: Sun, 16 May 2004 14:00:20 +0200

Hi Steven,

> I'm using Debian unstable with kernel 2.6.5, udev 0.024, bluez-pan
> 1.1rel-3 and I'm observing a timing problem with udev and the rfcommX
> device.
> 
> I'm trying to network my Palm Tungsten T3 with my computer but pppd 
> never gets call. When I click on the Network Services' "Connect" button
> on the T3, I see from the log that dund complains about the failure to
> create /dev/rfcommX device:
> 
> May 15 18:12:34 obsolescence hcid[2886]: link_key_request
> (sba=00:02:72:B1:45:02, dba=00:07:E0:2E:28:9C) 
> May 15 18:12:35 obsolescence dund[7424]: RFCOMM TTY creation failed. No
> such file or directory(2)
> May 15 18:12:36 obsolescence udev[7431]: creating device node
> '/dev/rfcomm0'
> May 15 18:13:07 obsolescence udev[7442]: removing device node
> '/dev/rfcomm0'
> 
> However, udev does create the /dev/rfcomm0, just not fast enough
> apparently. In a little experiment, as soon as I see the line:
> 
> udev[7431]: creating device node '/dev/rfcomm0' 
> 
> I run "sudo pppd /dev/rfcomm0 call btpalm" and this allows the T3
> to grab an IP address and setup IP networking between the T3 and my
> computer. From that point on, I can surf the Web from the T3 without
> any problems.
> 
> Are there other Bluez users out there who are using udev who has 
> managed to workaround/fix this problem? 

the bluez-utils-2.7 contains the pand and the dund and I already fixed
that problem there.

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
