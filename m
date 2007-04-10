Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <461B8242.1090800@gmail.com>
Date: Tue, 10 Apr 2007 16:25:38 +0400
From: Sergey Smirnov <svs1957@gmail.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <461B4E88.9010801@gmail.com>
	<461B7E3A.4030008@sportlaan.adsl.utwente.nl>
In-Reply-To: <461B7E3A.4030008@sportlaan.adsl.utwente.nl>
Subject: Re: [Bluez-devel] btsco: Operation not supported
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Thank you for answer.
I'm sure that modules loaded:
svs-zaurus:~# lsmod|grep sco
sco                    11396  0
snd_bt_sco             13868  2
snd_hwdep               7620  2 snd_bt_sco
snd_pcm                84613  8 snd_bt_sco,snd_soc_pxa2xx,snd_soc_core,snd_pxa2xx_ac97,snd_ac97_codec,snd_pxa2xx_pcm,snd_pcm_oss
snd_page_alloc          6600  2 snd_bt_sco,snd_pcm
snd                    53876  18 snd_bt_sco,snd_hwdep,snd_soc_corgi,snd_soc_wm8731,snd_soc_core,snd_pxa2xx_ac97,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_seq_oss,snd_seq_midi,snd_rawmidi,snd_seq,snd_timer,snd_seq_device
bluetooth              52736  10 sco,rfcomm,l2cap,dtl1_cs
svs-zaurus:~#

Also I'm sure that devices was paired.
I check /var/lib/bluetooth/<BT_ADDR>
And also I can cat > /dev/rfcomm[0|1] which is tty of headset

Here is some part of hcidump while sco connect:
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> HCI Event: Command Status (0x0f) plen 4
    Add SCO Connection (0x01|0x0007) status 0x11 ncmd 4
    Error: Unsupported Feature or Parameter Value
> ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c credits 2

Berend Dekens wrote:
> Make sure you have sco support in your kernel, as a module or compiled 
> in. Don't forget to load the module..
> 
> FYI: I have my share of trouble with SCO audio links so I have no clue 
> what else you can do :)
> 
> Berend
> 
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys-and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
> 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
