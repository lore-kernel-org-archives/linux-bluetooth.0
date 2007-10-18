Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <47175ACD.8030609@free.fr>
Date: Thu, 18 Oct 2007 15:08:29 +0200
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <BAY117-W36EE4B29F3D4550A7C9847C09E0@phx.gbl>	<4717360C.7090801@free.fr>
	<BAY117-W28974EACDCC899AC3DF807C09E0@phx.gbl>
In-Reply-To: <BAY117-W28974EACDCC899AC3DF807C09E0@phx.gbl>
Subject: Re: [Bluez-devel] SCO connection timed out issue
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Please find some comments below
> 
>       * Im confused about what you said about the sco function on STLC2500C.According to the IC datasheet of STLC2500C downloaded from 'www.st.com', it says that this chip supports SCO link. So are you saying that this chip simply can't support SCO under linux?(i have a couple of evaluation software of STLC2500C evaluation board under windowXP.It seems that under windows , its SCO link works.But im not very sure about this.)

It's basically not in the datasheet, but it is how things are. The chip 
supports SCO but not over hci, only over PCM.
It won't work with windows either :-(

> 
>       * i followed your hint and used the command "hciattach ttyUSB0 stlc2500" and then got the following information: 
> Loading file /lib/firmware/STLC2500_R4_02_04.ptc
> Loading file /lib/firmware/STLC2500_R4_02_02_WLAN.ssf 
> STLC2500 R4.2 12102005 12:40:14 
> ZAV100012 05HW Id= V440BAA 
> 
> i copied 2 files:
> STLC2500_R4_02_02_WLAN.ssf
> STLC2500_R4_02_04.ptc
> from the bluez-firmware-1.2/st to the /lib/firmware folder. 
> 
> i didn't use the "hciattach ttyUSB0 stlc2500 921600" cause this will give the following error:
>  pl2303 ttyUSB0: pl2303 driver does not support the baudrate requested (fix it)
>  It seems the pl2303(the serial-USB converter IC on STLC2500C evaluation board) driver does not support the baudrate of 921600.

Yes that's true, you need a 2.6.23 kernel for this high speed. With 
2.6.18 you should be able to go to 460800 bps though, please retry with 
hciattach ttyUSB0 stlc2500 460800


> 
>  So up to now , some good improvements have been made thanks to your suggestion. Anyway , i got the same err when i tried to connect using the command :aplay -D bluetooth /1.wav
>  aplay: main:550: audio open error: Input/output error
> hcid[318]: Service owner exited: :1.2
> hcid[318]: Audio service (audio) was killed by signal 7
> hcid[318]: link_key_request (sba=00:80:E1:00:00:00, dba=00:0D:3C:EB:53:F0) 

I have no idea of what's going wrong either. If you attach gdb to the 
bluetoothd-service-audio and show me where the program breaks i could 
tell more.

Cheers,

Fabien

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
