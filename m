Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Jukka Laurila <jplauril@cc.hut.fi>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <Pine.GSO.4.61.0601082205170.8744@vipunen.hut.fi>
Message-ID: <Pine.GSO.4.61.0605141903230.17906@vipunen.hut.fi>
References: <Pine.GSO.4.61.0601082205170.8744@vipunen.hut.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: [Bluez-users] FIXED: Re: sdptool browse fails with ISSC dongle and Nokia 6630 in
 Ubuntu Breezy
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
Date: Sun, 14 May 2006 19:15:25 +0300 (EEST)

On Sun, 8 Jan 2006, Jukka Laurila wrote:

> When I do "sdptool browse 00:11:9F:C8:D9:36" (that's the address of my Nokia 
> 6630) sdptool gives the error:
>
>  Service Search failed: Connection timed out
>
> The following error appears in syslog:
>
>  sdptool: sdp_read_rsp: Client timed out
>
> "hcidump -X -V" done during the "sdptool browse" says the following. There is 
> a pause of about 20 seconds in the indicated place:

> System: Ubuntu 5.10 "Breezy Badger"
> Kernel: 2.6.12-10-386
> Bluez software versions are those from Ubuntu Breezy:
> ii  bluez-cups                             2.20-0ubuntu3 ii  bluez-hcidump 
> 1.23-0ubuntu1 ii  bluez-pcmcia-support                   2.20-0ubuntu3 ii 
> bluez-pin                              0.25-1ubuntu1 ii  bluez-utils 
> 2.20-0ubuntu3
>
> The USB dongle is a cheapo model branded "Prodigi". lsusb says:
> Bus 001 Device 017: ID 1131:1001 Integrated System Solution Corp.
>
> The phone is a Nokia 6630, firmware V4.03.36, 08-04-05. I have set the 
> desktop machine as paired and authorized in the phone.

I just want to inform you that I managed to trace this 
problem to a Bluetooth related program I had installed on 
the phone. The problem remained even after changing the 
dongle and updating the firmware of the phone to the latest 
version, but when I uninstalled the apparently misbehaving 
program, sdptool browse started to work properly. The 
program in question is, to my knowledge, not publically 
available, so I can't disclose what it was.


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
