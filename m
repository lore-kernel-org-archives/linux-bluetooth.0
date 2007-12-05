Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <4756AC23.5020207@hccnet.nl>
Date: Wed, 05 Dec 2007 14:48:19 +0100
From: Remy Bosch <reboli@hccnet.nl>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <005b01c8366a$5b6e07b0$9901a8c0@kcoe74512670e8>	<475545AC.2030509@gmail.com><000d01c83672$7fecdbe0$9901a8c0@kcoe74512670e8>	<47554E19.6000803@gmail.com>
	<01b301c8371d$eb932f10$9901a8c0@kcoe74512670e8>
In-Reply-To: <01b301c8371d$eb932f10$9901a8c0@kcoe74512670e8>
Subject: Re: [Bluez-users] how to use bluetooth audiotools	inbluez-utils-3.22
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Leiyu wrote:
> Dear All,
>
> sorry for typing error, I send it again 
>  I create ~/.asoundrc  and modify it to contain 
>  pcm.bluetooth {
>    type bluetooth
>    device 00:18:6a:00:01:06
>  }
>
> then call " mplayer -ao alsa:device=bluetooth /wulai.mp3" to play music and  meet the errors:
> alsa-lib:pcm_bluetooth.c1240:(bluetooth_init) connection fail
> alsa-init:playback open error: Connection refused
>   

I got similar. It won't work out of the box. Most appliances - to my
knowledge - have a pin like '0000' which has to be send out, but don't
see any reference in hcid.conf manual.
Searching around the net points me to bluez-pin at
http://gpe.handhelds.org/projects/bluez-pin.shtml. Do we still need an
separate program to pass a pin?
For a while I used gnome-bluetooth which asked for a pin, and the info
is now stored under /var/lib/bluetooth/00:0B:6B:92:41:57/
If I remove this dir, the audio device won't work and give errors. I
place the dir back and it's music to my ears. Literally.
What to do for new apps without gnome-bluetooth? I'd like to avoid as
much bloat as possible which include - imho - gnome/kde.

Thanks

R. Bosch


-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
