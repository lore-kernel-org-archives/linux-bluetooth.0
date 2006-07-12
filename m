Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Wed, 12 Jul 2006 08:35:20 +0200 (CEST)
From: Andreas Fehr <andreas@mrs.ch>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.64.0607111912500.7183@ybpnyubfg.ybpnyqbznva>
Message-ID: <Pine.LNX.4.64.0607120825590.1255@ysf-zvav.gfns.pu>
References: <Pine.LNX.4.64.0607091841010.20657@ybpnyubfg.ybpnyqbznva>
	<Pine.LNX.4.64.0607111912500.7183@ybpnyubfg.ybpnyqbznva>
MIME-Version: 1.0
Subject: Re: [Bluez-users] Installing / get running bluez-3.1
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

On Tuesday, 11. July 2006, 19:18, Andreas Fehr (as AF) wrote:

>AF: On Sunday, 09. July 2006, 19:15, Andreas Fehr (as AF) wrote:
>AF: 
>AF: >AF: Up to now, I used some version 2.x (can't remember what version as 
>AF: >AF: I uninstalled it to early). Compiling and installing the files was 
>AF: >AF: no problem, but I can't get it running.
>AF: >AF: 
>AF: >AF: I use:
>AF: >AF: - Kernel 2.6.17.4
>AF: >AF: - bluez-libs-3.1
>AF: >AF: - bluez-utils-3.1
>AF: >AF: - dbus-0.62

<snip>

>AF: >AF: With vmware and it's USB driver, I'm able to use the Bluetooth dongle, 
>AF: >AF: so the USB driver, the dongle and my hardware seem to be ok. So much for 
>AF: >AF: the good part.
>AF: >AF: 
>AF: >AF: Now, if I run rfcomm bind 0, the file /dev/rfcomm gets created:
>AF: >AF:  crw-rw-rw-  1 root dialout 216, 0 Jul  9 19:02 /dev/rfcomm0
>AF: >AF: 
>AF: >AF: rfcomm: (1)
>AF: >AF:  rfcomm0: 00:18:xx:xx:xx:xx channel 3 clean
>AF: >AF: 
>AF: >AF: But the old software that I used to use does not work.
>AF: >AF: 
>AF: >AF: minicom comes up with the message:
>AF: >AF:  minicom: cannot open /dev/rfcomm0: No route to host
>AF: >AF: 
>AF: >AF: hcitool scan prints:
>AF: >AF:  Device is not available: No such device
>AF: >
>AF: > call "hciconfig -a" and make sure "hcidump -X -V" is running in 
>AF: > another terminal to catch the setup.
>AF: 
>AF: For me, both output look reasonable. Does it help to analyse the 
>AF: problem?

Ok, I'm one step further. It looks like it is a problem with my phone 
that I wont to connect to.

With vmware, i have the same BD address as with bluez (under Linux) but 
I use different device (computer) names. It looks like the phone got 
confused by that (no reaction on the phone on connection attempt). I 
removed the pairing from the phone.

Now, I get some message to enter the pine on the phone. But not long 
enough to enter any key in the phone. Bluetooth gets disconnected after 
about 2 seconds.

Is there any information about setting up pin or pin_helper with the new 
version 3.x of bluez? I grepped bluez-util with 'pin' and 'pin_helper' 
but there was no documentation for this new version. I did not change 
anything from the old version 2.xx that I used, but it looks like the 
old configuration doesn't work anymore.

Thanks,
Andreas


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
