Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <40435E1B.7000900@gammah.com>
From: TM <bluez@gammah.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Socket permissions
References: <000101c3ffa4$a060e550$46a57e40@thores>
In-Reply-To: <000101c3ffa4$a060e550$46a57e40@thores>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Mon, 01 Mar 2004 10:00:27 -0600

I did 
# chown root hciconfig
# chmod 4711 hciconfig 

which sets that program setUID root. This should solve that problem, but setting programs setuid root *could* cause a problem for security. Since all my bluez stuff is on a laptop that's rarely online, the risk is negligible for me.

-t.

Thor Egil Skaug wrote:
> When I use the hciconfig, hcitool, etc. applications that depend on
> raw-data hci-sockets,
> I have to be logged in as root for it to work. If not I get a permission
> denied error.
> 
> Which files do I have to alter permissions on in order for a normal user
> to do this?
> 
> I am using Linux 2.4.25, hci_usb + usb-uhci, Belkin USB dongle (CSR).
> 
> Thor
> 
> 
> -------------------------------------------------------
> SF.Net is sponsored by: Speed Start Your Linux Apps Now.
> Build and deploy apps & Web services for Linux with
> a free DVD software kit from IBM. Click Now!
> http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
