Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <BAY117-W32E1C83B212B6BF5287DA2C09E0@phx.gbl>
From: "" <semiyd@hotmail.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Thu, 18 Oct 2007 12:13:04 +0000
In-Reply-To: <4717360C.7090801@free.fr>
References: <BAY117-W36EE4B29F3D4550A7C9847C09E0@phx.gbl>
	<4717360C.7090801@free.fr>
MIME-Version: 1.0
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
Content-Type: multipart/mixed; boundary="===============1834923978=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1834923978==
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Hi Fabien:
     Thanks a lot for the info!
      * Im confused about what you said about the sco function on STLC2500C.According to the IC datasheet of STLC2500C downloaded from 'www.st.com', it says that this chip supports SCO link. So are you saying that this chip simply can't support SCO under linux?(i have a couple of evaluation software of STLC2500C evaluation board under windowXP.It seems that under windows , its SCO link works.But im not very sure about this.)
      * i followed your hint and used the command "hciattach ttyUSB0 stlc2500" and then got the following information:

Loading file /lib/firmware/STLC2500_R4_02_04.ptc
Loading file /lib/firmware/STLC2500_R4_02_02_WLAN.ssf

 STLC2500 R4.2 12102005 12:40:14 ZAV100012  05
       HW Id= V440BAA

i copied 2 files:
STLC2500_R4_02_02_WLAN.ssf
STLC2500_R4_02_04.ptc
from the bluez-firmware-1.2/st  to the /lib/firmware folder.

i didn't use the "hciattach ttyUSB0 stlc2500 921600" cause this will give the following error:

pl2303 ttyUSB0: pl2303 driver does not support the baudrate requested (fix it)

It seems the pl2303(the serial-USB converter IC on STLC2500C evaluation board) driver does not support the baudrate of 921600.

So up to now , some good improvements have been made thanks to your suggestion. 
Anyway , i got the same err when i tried to connect using the command :aplay -D bluetooth /1.wav

aplay: main:550: audio open error: Input/output error
hcid[318]: Service owner exited: :1.2
hcid[318]: Audio service (audio) was killed by signal 7
hcid[318]: link_key_request (sba=00:80:E1:00:00:00, dba=00:0D:3C:EB:53:F0)

http://wiki.bluez.org/wiki/HOWTO/AudioDevices 
says that i can use bluez only without btsco or plugz.It says using the command "aplay -D bluetooth /1.wav" is just fine.
So i really have no idea if there's any other command i can use in order to connect the headset based on A2DP.
i also don't know whether this "aplay -D bluetooth /1.wav" is aimed to connect the headset with A2DP or SCO.....?



Thank a lot.



semiyd

> Date: Thu, 18 Oct 2007 12:31:40 +0200
> From: fabchevalier@free.fr
> To: bluez-devel@lists.sourceforge.net
> Subject: Re: [Bluez-devel] SCO connection timed out issue
>
> Hi,
>
> Sorry i have to say you this, but you're basically trying to make sth
> work that will never make it ;-)
>
> * STLC2500C does not support sco over hci, so unless your development
> has an audio codec hardwired to the BT chip, you're screwed :-(
> * You need latest bluez-utils CVS to have any chance for your chip
> to run at decent speed, which is required for a2dp streaming. You should
> then use the follwing syntax to start the chip at max speed: hciattach
> /dev/ttyUSB0 stlc2500 921600
>
> Apart from that this is know to work.
>
> Regards,
>
> Fabien
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc.
> Still grepping through log files to find problems? Stop.
> Now Search log events and configuration files using AJAX and a browser.
> Download your FREE copy of Splunk now>> http://get.splunk.com/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel

_________________________________________________________________
News, entertainment and everything you care about at Live.com. Get it now!
http://www.live.com/getstarted.aspx


--===============1834923978==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--===============1834923978==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1834923978==--
