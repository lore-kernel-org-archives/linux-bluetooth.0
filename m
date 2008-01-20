Return-Path: <cyrus@holtmann.org>
Message-ID: <4792BC6A.6000708@gmail.com>
Date: Sun, 20 Jan 2008 13:13:46 +1000
From: Eugene <it.had.even@gmail.com>
MIME-Version: 1.0
To: gunnar_thielebein@gmx.net,
	BlueZ users <bluez-users@lists.sourceforge.net>
References: <47928635.2030400@gmx.net>
In-Reply-To: <47928635.2030400@gmx.net>
Content-Type: multipart/mixed; boundary="------------050605010601000707000506"
Subject: Re: [Bluez-users] audio bluetooth connectivity in gutsy
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------050605010601000707000506
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Gunnar Thielebein writes:
> Hi group,
>
> I am trying to connect my headset in gutsy with default kernel 
> 2.6.22-14-generic. I tried all four(?) possible solutions: old sco way, 
> plugz, bluetooth-alsa (at least the package in gutsy) and bluez-audio 
> which all ends finally with a hardlock of my system when the connection
> was established with headset.
>
> Authentication and sdp browsing works fine at least in kde.
>
> I tested sound play with smplayer,mplayer,aplay,play.
>
> I also tested with the unstable packages from sid libbluez, bluez- 
> bluez-audio, gstreamer-plugins
>
> Could you tell if I need a more current kernel version than 22?
> Or is it something with my hardware?
>
> my hardware spec:
>
> Headset: HBH-PV700
> ---
> Dongle: Bus 001 Device 003: ID 0f4d:1000 Microtune, Inc. Bluetooth Dongle
> ---
> arch: amd64 - 2.6.22-14-generic #1 SMP Tue Dec 18 05:28:27 UTC 2007 
> x86_64 GNU/Linux
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Microsoft
> Defy all challenges. Microsoft(R) Visual Studio 2008.
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>
>   
My BT stereo headset works well in Ubuntu Gutsy:
Linux gr11n 2.6.22-14-generic #1 SMP Sun Oct 14 23:05:12 GMT 2007 i686 
GNU/Linux
I use bluez version 3.24 compiled from sources. Audacious also works 
without troubles.
You should describe your problem with more details (logs and 
configuration files), to understand it clearly.

Regards,
Eugene

--------------050605010601000707000506
Content-Type: text/x-vcard; charset=utf-8;
 name="it_had_even.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="it_had_even.vcf"

begin:vcard
fn:Eugene
n:;Eugene
version:2.1
end:vcard


--------------050605010601000707000506
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--------------050605010601000707000506
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--------------050605010601000707000506--
