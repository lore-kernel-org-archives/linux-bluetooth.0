Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4044A898.2080408@realss.com>
From: Zhang Weiwu <zhangweiwu@realss.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-users] connectivity with FreeBSD bluetooth LAN access server.
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
Date: Tue, 02 Mar 2004 23:30:32 +0800

Hello. I'm trying to figure out how to use freebsd connect my notebook 
(running Sun Java Desktop, a varienty of SuSE) to my LAN. The so called 
LAN access server runs FreeBSD 5.2 (maybe called "GN", group ad-hoc 
Network controller or perhaps "NAP", Network Access Point in Linux 
concept, but I'm not sure.)

Now on Linux side I think I have correct modules loaded. I think I have 
gone that far to have the correct L2CAP settings because the FreeBSD 
serverbox can do l2ping(1) to Linux and get respond. l2ping(1) is a 
L2CAP ping tool in FreeBSD. I can also ues Linux inquiry/scan near by 
bluetooth devices. Now what? I'm not sure of the concepts, what should I 
do now?

The FreeBSD server is running rfcomm_pppd(1) listening to channel 1, in 
ppp(1) settings the server accept ppp connection without authtication, 
no chap nor pap. I hope these FreeBSD concept won't make you feel 
strange, I was using FreeBSD all the years, just migrated to Linux 
recently. In my office Windows bluetooth client simply browse and find 
the server, click to build a dial out connection, type in random 
user/password and get connected. MAC OS user connects just fine, only to 
build a virtual RS-232 device using "bluetooth serial utility", and dial 
on that device using "null modem" driver, fill in random 
username/password and connect.

I don't know why I googled around but webpages don't talk too much about 
FreeBSD bluetooth concepts like "ppp over rfcomm connection". instead I 
found a PAN how to:
<http://bluez.sourceforge.net/contrib/HOWTO-PAN/chann>
That really puzzled me! I played pand some time, I keep getting 
"connection refused" in log message.

On my Linux notebook, using pand --search, in the /var/log/message there 
are records that pand tried to connect to the server and get refused. 
Using sdptool(1) browse the server, I can get the service list (that is 
a LAN access service on channe1 and supporting RFCOMM/L2CAP services).

In the FreeBSD world I connect to bluetooth LAN access server using 
rfcomm_pppd(1), something like "rfcomm_pppd -c -C 1 -l client" means 
connect as client to channel 1 with the ppp(1) started using config 
label "client". The ppp(1) utility do proxy arp and so like to let the 
bluetooth client behave just like a normal box on the LAN. Now Linux 
seems completely different to me.

Now all the concepts to me messed up. I am not familiar with Linux, I 
don't even know what log/config file should I provide. Please someone 
help me figure out what's the problem, I'll be very graceful. Just 
telling me what document to follow would do me good help. Thank you!



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
