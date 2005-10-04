Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Thomas Keitzl <c3t0@yahoo.de>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] BlueZ on Sony Vaio notebook with builtin
 Bluetooth
Message-Id: <20051004150009.5f3d02f9.c3t0@yahoo.de>
In-Reply-To: <4341EB2C.1040804@ozob.net>
References: <20050930205939.3e5081ff.c3t0@yahoo.de>
	<4341EB2C.1040804@ozob.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Date: Tue, 4 Oct 2005 15:00:09 +0200

Gene Imes <ebi7@ozob.net> wrote:

> c3t0@yahoo.de wrote:
> > Hi,
> > I'm new to this mailinglist and to be honest I'm also new to mailinglists at all.
> > 
> > I recently bought a second-hand notebook (Sony Vaio PCG-Z1M) and I'm trying to get everything
> > to work atm. Almost everything works quite fine except the bluetooth-device, which is
> > built-in.
> > 
> > I don't have problems turning the bluetooth-device on and off using sonypi and spicctrl
> > as the blue led on the laptop, which indicates the bluetooth-device-status, reacts on my
> > spicctrl commands. Unfortunatly the BlueZ-utils doesn't detect any bluetooth-device even 
> > though I activated it via "spicctrl -l1" and loaded the hci-usb-modul (bluetooth itself 
> > is compiled in the kernel).
> > 
> 
> Try to compile bluetooth as modules.
> 
> -- 
> Gene Imes                               www.ozob.net


Thanks for your answer, Gene.
I tried to compile bluetooth as modules. Unfortunately this didn't change a lot.
'hciconfig' still can't find any devices...

>#lsmod
>
>Module                  Size  Used by
>hci_usb                11136  0
>l2cap                  19652  0
>bluetooth              40068  2 hci_usb,l2cap
>snd_pcm_oss            48616  0
>snd_mixer_oss          17664  1 snd_pcm_oss
>intel_agp              19616  1
>ehci_hcd               26308  0
>hw_random               4308  0
>8250_pci               16640  0
>8250                   17792  1 8250_pci
>serial_core            18624  1 8250
>ohci1394               31044  0
>ieee1394               96504  1 ohci1394
>ipw2100               136640  0
>ieee80211              45572  1 ipw2100
>ieee80211_crypt         4680  2 ipw2100,ieee80211
>evdev                   7424  0
>ide_scsi               14084  0
>agpgart                28264  1 intel_agp

Thomas Keitzl

	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
