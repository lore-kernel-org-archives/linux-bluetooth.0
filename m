Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Johannes Kapune <listen@kapune.de>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <448F0E0A.7020308@stfw.eu>
References: <1150148335.7372.7.camel@johannes_01.kapune.local>
	<448DEA20.5000806@stfw.eu>
	<1150219383.7401.5.camel@johannes_01.kapune.local>
	<448F0E0A.7020308@stfw.eu>
Date: Thu, 15 Jun 2006 01:08:14 +0200
Message-Id: <1150326495.7768.9.camel@johannes_01.kapune.local>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Can't play mp3, what I'm missing?
Reply-To: bluez-users@lists.sourceforge.net
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

Hi,

Am Dienstag, den 13.06.2006, 20:12 +0100 schrieb Zhares:

> try to replace the line :
>     security auto;
> 
> by:
>     security user;
> or:
>     security none;
> 
> here is an extract of the hcid,conf that was installed with ubuntu:
> 
>          # Security Manager mode
>          #   none - Security manager disabled
>          #   auto - Use local PIN for incoming connections
>          #   user - Always ask user for a PIN
>          #

in all cases the same result: it does not work!


> fwiw, the itech r35 wouldn't allow a connection from my pc until i
> changed hcid's link mode from
> 
> lm accept,master;
>
> to
>
> lm accept;
> 
> and restarted hcid. It may be because at the time the headset was also
> connected to my cellphone... later on it didn't have this requirement.
>
> headsets that can do a2dp and headset/handsfree may prefer or require
> being master so they don't have to do a scatternet to communicate to >
> two
> devices at the same time.
>
> brad


This in my configuration file:

device {
	# auth disable;
	# encrypt disable;
	iscan enable;
	pscan enable;
	name "BlueZ %h (%d)";
	class 0x700100;
	lm accept;
	lp rswitch,hold,sniff,park;
}
options {
	# security auto;
	# security none;
	security user;
	autoinit yes;
	pairing multi;
}


Next I tried when the headphone is in pairing-mode:
# hcitool inq
Inquiring ...
        00:0A:94:A0:59:3B       clock offset: 0x3453    class: 0x240404

And the same in headphone-normal-mode:
# hcitool inq
Inquiring ...

Is this correct?


When trying to play a mp3 I get this result:

# mpg123 --au - Din_Tei.mp3 | ./a2play 00:0A:94
:A0:59:3b
subbands = 8 blocks = 16 bitpool = 32
High Performance MPEG 1.0/2.0/2.5 Audio Player for Layer 1, 2, and 3.
Version 0.59q (2002/03/23). Written and copyrights by Joe Drew.
Uses code from various people. See 'README' for more!
THIS SOFTWARE COMES WITH ABSOLUTELY NO WARRANTY! USE AT YOUR OWN RISK!
Title  : Dragostea Din Tei               Artist: Haiducii
Album  :                                 Year  : 2004
Comment: I&T okay                        Genre : Blues

Playing MPEG stream from Din_Tei.mp3 ...
MPEG 1.0 layer III, 192 kbit/s, 44100 Hz stereo
len=2048
Header size=28
Sample Rate:44100
Channels:2
Using address: 00:0A:94:A0:59:3b
Found A2DP Sink
Found A2DP Sink at the destination
Can't connect to 3B:59:A0:94:0A:00. Connection refused(111)
cannot open psm_cmd = 25


what's the meaning of psm_cmd = 25


Thanks 
Johannes



_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
