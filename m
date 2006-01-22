Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <20060122122523.46811.qmail@web32014.mail.mud.yahoo.com>
From: Dani Camps <danicamps81@yahoo.com>
Subject: Re: [Bluez-devel] Problems when inserting snd_bt_sco module in the kernel
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <43D2A400.4030709@xmission.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1113169200-1137932723=:39049"
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 22 Jan 2006 04:25:23 -0800 (PST)

--0-1113169200-1137932723=:39049
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

 
Hi Brad, 
 
 Thanks for your quick reply.
 When I try to compile the snd_hwdep kernel module with:
 
---------------------------------------------------------------------------------------------------------------
 # make -C /usr/src/kernels/2.6.12-1.1372_FC3-i686/ CONFIG_SND_HWDEP=m 
modules modules_install
 
 make: Entering directory `/usr/src/kernels/2.6.12-1.1372_FC3-i686'
   CHK     include/linux/version.h
   CHK     include/asm-i386/asm_offsets.h
 make[1]: *** There is no rule to build the object `init/main.o', 
needed for `init/built-in.o'.  Stop.
 make: *** [init] Error 2
 make: Leaving directory `/usr/src/kernels/2.6.12-1.1372_FC3-i686'
 
 
---------------------------------------------------------------------------------------------------------------
 As you can see I get that error when trying to build snd_hwdep.
 Even though, I can insert snd_hwdep in the kernel by doing:
 #modprobe snd_hwdep
 
 After doing this, and having the Bluetooth dongle plugged in and the 
bluetooth service started, this is my output of lsmod:
 
---------------------------------------------------------------------------------------------------------------
 #lsmod
 Module                  Size  Used by
 snd_hwdep               9376  0
 rfcomm                 41565  0
 l2cap                  29509  5 rfcomm
 hci_usb                18121  2
 bluetooth              55237  7 rfcomm,l2cap,hci_usb
 i915                   18753  1
 drm                    68949  2 i915
 parport_pc             28293  1
 lp                     12873  0
 parport                40073  2 parport_pc,lp
 autofs4                28229  0
 wlan_wep                5504  1
 tun                    11329  0
 sunrpc                164229  1
 pcmcia                 28897  2
 microcode               7009  0
 nls_utf8                2113  1
 ntfs                  177808  1
 dm_mod                 57333  0
 video                  15685  0
 button                  6609  0
 battery                 9285  0
 ac                      4805  0
 md5                     4033  1
 ipv6                  262977  8
 ohci1394               39945  0
 ieee1394              303545  1 ohci1394
 yenta_socket           21449  2
 rsrc_nonstatic         12737  1 yenta_socket
 pcmcia_core            50013  3 pcmcia,yenta_socket,rsrc_nonstatic
 uhci_hcd               35025  0
 ehci_hcd               40013  0
 i2c_i801                8653  0
 i2c_core               21313  1 i2c_i801
 snd_intel8x0m          19780  5
 snd_intel8x0           34752  2
 snd_ac97_codec         78332  2 snd_intel8x0m,snd_intel8x0
 snd_pcm_oss            51360  0
 snd_mixer_oss          18432  3 snd_pcm_oss
 snd_pcm                99080  6 
snd_intel8x0m,snd_intel8x0,snd_ac97_codec,snd_pcm_oss
 snd_timer              33412  1 snd_pcm
 snd                    58884  16 
snd_hwdep,snd_intel8x0m,snd_intel8x0,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
 soundcore              10785  3 snd
 snd_page_alloc         10244  3 snd_intel8x0m,snd_intel8x0,snd_pcm
 8139too                29505  0
 mii                     5569  1 8139too
 ath_pci                58788  0
 ath_rate_onoe           7816  1 ath_pci
 wlan                  108508  4 wlan_wep,ath_pci,ath_rate_onoe
 ath_hal               147536  2 ath_pci
 joydev                  9345  0
 ext3                  130633  1
 jbd                    83161  1 ext3
 
---------------------------------------------------------------------------------------------------------------
 
 Here is when I try to insert the snd_bt_sco, but it crashes like I 
decribed in my previous email.
 
 The enviroment where I am trying to insert snd_bt_sco is correct or do 
I need some extra other module, or snd_hwdep must be rebuilt and 
inserted again ? In that case any idea about the error that I get when trying 
to build snd_hwdep ?
 
 Regarding my bluetooth dongle, I am not trying to workaround any 
Broadcom problem, I just want to use my headset :), is then absolutely 
necessary that I get a USB dongle with a CSR bluetooth chipset? Which brands 
are shipping USB dongles with CSR bluetooth chipsets ?
 
 Thanks a lot
 
 Dani
 

		
---------------------------------
 
 What are the most popular cars?  Find out at Yahoo! Autos
--0-1113169200-1137932723=:39049
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div id="RTEContent"> <pre><tt>Hi Brad, <br> <br> Thanks for your quick reply.<br> When I try to compile the snd_hwdep kernel module with:<br> <br>---------------------------------------------------------------------------------------------------------------<br> # make -C /usr/src/kernels/2.6.12-1.1372_FC3-i686/ CONFIG_SND_HWDEP=m <br>modules modules_install<br> <br> make: Entering directory `/usr/src/kernels/2.6.12-1.1372_FC3-i686'<br>   CHK     include/linux/version.h<br>   CHK     include/asm-i386/asm_offsets.h<br> make[1]: *** There is no rule to build the object `init/main.o', <br>needed for `init/built-in.o'.  Stop.<br> make: *** [init] Error 2<br> make: Leaving directory `/usr/src/kernels/2.6.12-1.1372_FC3-i686'<br> <br> <br>---------------------------------------------------------------------------------------------------------------<br> As you can see I get that error when trying to build snd_hwdep.<br> Even though, I can insert snd_hwdep in the kernel by doing:<br>
 #modprobe snd_hwdep<br> <br> After doing this, and having the Bluetooth dongle plugged in and the <br>bluetooth service started, this is my output of lsmod:<br> <br>---------------------------------------------------------------------------------------------------------------<br> #lsmod<br> Module                  Size  Used by<br> snd_hwdep               9376  0<br> rfcomm                 41565  0<br> l2cap                  29509  5 rfcomm<br> hci_usb                18121  2<br> bluetooth              55237  7 rfcomm,l2cap,hci_usb<br> i915                   18753  1<br> drm                    68949  2 i915<br> parport_pc             28293  1<br> lp                     12873  0<br> parport                40073  2 parport_pc,lp<br> autofs4                28229  0<br> wlan_wep                5504  1<br> tun                    11329  0<br> sunrpc                164229  1<br> pcmcia                 28897  2<br> microcode               7009  0<br> nls_utf8                2113  1<
 br> ntfs
                  177808  1<br> dm_mod                 57333  0<br> video                  15685  0<br> button                  6609  0<br> battery                 9285  0<br> ac                      4805  0<br> md5                     4033  1<br> ipv6                  262977  8<br> ohci1394               39945  0<br> ieee1394              303545  1 ohci1394<br> yenta_socket           21449  2<br> rsrc_nonstatic         12737  1 yenta_socket<br> pcmcia_core            50013  3 pcmcia,yenta_socket,rsrc_nonstatic<br> uhci_hcd               35025  0<br> ehci_hcd               40013  0<br> i2c_i801                8653  0<br> i2c_core               21313  1 i2c_i801<br> snd_intel8x0m          19780  5<br> snd_intel8x0           34752  2<br> snd_ac97_codec         78332  2 snd_intel8x0m,snd_intel8x0<br> snd_pcm_oss            51360  0<br> snd_mixer_oss          18432  3 snd_pcm_oss<br> snd_pcm                99080  6 <br>snd_intel8x0m,snd_intel8x0,snd_ac97_codec,snd_pcm_oss<br> snd
 _timer  
            33412  1 snd_pcm<br> snd                    58884  16 <br>snd_hwdep,snd_intel8x0m,snd_intel8x0,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer<br> soundcore              10785  3 snd<br> snd_page_alloc         10244  3 snd_intel8x0m,snd_intel8x0,snd_pcm<br> 8139too                29505  0<br> mii                     5569  1 8139too<br> ath_pci                58788  0<br> ath_rate_onoe           7816  1 ath_pci<br> wlan                  108508  4 wlan_wep,ath_pci,ath_rate_onoe<br> ath_hal               147536  2 ath_pci<br> joydev                  9345  0<br> ext3                  130633  1<br> jbd                    83161  1 ext3<br> <br>---------------------------------------------------------------------------------------------------------------<br> <br> Here is when I try to insert the snd_bt_sco, but it crashes like I <br>decribed in my previous email.<br> <br> The enviroment where I am trying to insert snd_bt_sco is correct or do <br>I need some ex
 tra
 other module, or snd_hwdep must be rebuilt and <br>inserted again ? In that case any idea about the error that I get when trying <br>to build snd_hwdep ?<br> <br> Regarding my bluetooth dongle, I am not trying to workaround any <br>Broadcom problem, I just want to use my headset :), is then absolutely <br>necessary that I get a USB dongle with a CSR bluetooth chipset? Which brands <br>are shipping USB dongles with CSR bluetooth chipsets ?<br> <br> Thanks a lot<br> <br> Dani</tt></pre> </div><p>
		<hr size=1> <BR> 
What are the most popular cars?  Find out at <a href="http://us.rd.yahoo.com/evt=38382/_ylc=X3oDMTEzNWFva2Y2BF9TAzk3MTA3MDc2BHNlYwNtYWlsdGFncwRzbGsDMmF1dG9z/*http://autos.yahoo.com/newcars/popular/thisweek.html 
">Yahoo! Autos</a>

--0-1113169200-1137932723=:39049--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
