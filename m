Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41B83BA8.5010001@suche.org>
From: "suche.org" <admin@suche.org>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
References: <41B81ACB.1080807@xmission.com> <1102589835.9988.114.camel@pegasus>
In-Reply-To: <1102589835.9988.114.camel@pegasus>
Content-Type: text/html; charset=ISO-8859-15
Subject: [Bluez-devel] Re: starting btsco-in-libalsa
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
Date: Thu, 09 Dec 2004 12:48:56 +0100

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-15"
 http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Marcel Holtmann wrote:
<blockquote cite="mid1102589835.9988.114.camel@pegasus" type="cite">
  <pre wrap="">Hi Brad,

  </pre>
  <blockquote type="cite">
    <pre wrap="">I put some junk in the btsco cvs:

alsa-lib.patch
bt/

if you apply alsa-lib.patch and put bt inside alsa-lib/src/pcm then the 
idea is that you can build a userspace alsa driver.

currently it doesn't even compile... it's just based on the jack plugin 
and not yet reworked for bluetooth.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
nice start. Actually I tried this by myself some time ago, but haven't
got any further than a skeleton. The main problem I see at the moment is
that we have to develop this inside the ALSA lib source and that is bad.
The reason for this is "pcm_local.h" and its definitions that are not
installed system wide. I don't think that SND_PCM_TYPE_BLUETOOTH is
needed, but I can be wrong of course. The other thing is that this stuff
should belong to the pcm/ext/ directory. My skeleton is attached and I
used these extra lines in ~/.asoundrc

	pcm.aiptek {
		type a2dp
		bdaddr "00:0B:xx:xx:xx:xx"
	}

Assuming that /usr/lib/alsa-lib/libasound_module_pcm_a2dp.so exists this
works as it should. So we have PCM at the input side of this plugin and
we send SBC over AVDTP to our headphone.
  </pre>
</blockquote>
Hi,<br>
i think this goes to the wrong direction.<br>
1. Even if there exist alsa library for many programms it is sufficent
to use /dev/dsp and /dev/audio.<br>
This mean that the soundcard driver should work independent of the alsa
library.<br>
<br>
For me looks this very similar to the old pwc driver problem.<br>
a) An kernel module that create an hook for interact with an non kernel
module<br>
b) There is an gerneral interface dsp/audio/mixer wich become crippled
without the alsa lib<br>
So why not be conesquent and put btsco int the snd-bt-sco module ?<br>
Like other hardware the module is tooled via command line or IOCTL wich
bt-device it should handle.<br>
<br>
Than the we have and "single" module wich is responsable for handling
bluetooth sound.<br>
Currently it look more like an skeleton for me that grab data from SCO
and tell BTSCO how to configure the hardware.<br>
<br>
So what are the grounds for moving btsco to the lib inseat of moving it
to the module ?<br>
<br>
Cu Thomas<br>
</body>
</html>


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
