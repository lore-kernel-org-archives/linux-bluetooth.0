Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41B849BC.5060002@suche.org>
From: "suche.org" <admin@suche.org>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
References: <41B81ACB.1080807@xmission.com>	 <1102589835.9988.114.camel@pegasus>  <41B83BA8.5010001@suche.org> <1102594031.9988.171.camel@pegasus>
In-Reply-To: <1102594031.9988.171.camel@pegasus>
Content-Type: text/html; charset=ISO-8859-15
Subject: [Bluez-devel] Re2: starting btsco-in-libalsa
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
Date: Thu, 09 Dec 2004 13:49:00 +0100

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content=3D"text/html;charset=3DISO-8859-15"
 http-equiv=3D"Content-Type">
  <title></title>
</head>
<body bgcolor=3D"#ffffff" text=3D"#000000">
<br>
<blockquote cite=3D"mid1102594031.9988.171.camel@pegasus" type=3D"cite">
  <blockquote type=3D"cite">
    <blockquote type=3D"cite">
      <pre wrap=3D"">	pcm.aiptek {
		type a2dp
		bdaddr "00:0B:xx:xx:xx:xx"
	}

Assuming that /usr/lib/alsa-lib/libasound_module_pcm_a2dp.so exists this
works as it should. So we have PCM at the input side of this plugin and
we send SBC over AVDTP to our headphone.
 =20
      </pre>
    </blockquote>
    <pre wrap=3D"">i think this goes to the wrong direction.
1. Even if there exist alsa library for many programms it is sufficent
to use /dev/dsp and /dev/audio.
This mean that the soundcard driver should work independent of the
alsa library.
    </pre>
  </blockquote>
  <pre wrap=3D""><!---->
this is too short thinking. There are parts that don't belong inside the
kernel. And SBC encoding and decoding is one of them.
  </pre>
</blockquote>
OK that is an point that i can understand. But the btsco daemon does
not handly any conversion.<br>
He is only responsible for managing the "hardware" Meaning 2 points:<br>
- handle the hardware connection rfcomm / sco<br>
- pipe the volume information betwen the mixer and the headset.<br>
He does not do any conversion and also he only interact between kernel
modules as an linking glue.<br>
<blockquote cite=3D"mid1102594031.9988.171.camel@pegasus" type=3D"cite">
  <blockquote type=3D"cite">
    <pre wrap=3D"">without the alsa lib
So why not be conesquent and put btsco int the snd-bt-sco module ?
Like other hardware the module is tooled via command line or IOCTL
wich bt-device it should handle.
    </pre>
  </blockquote>
b) There is an gerneral interface dsp/audio/mixer wich become crippled<br=
>
  <pre wrap=3D""><!---->
Bluetooth is not only hardware. What you see is a dongle, but on top
there is a complete stack. We interface with L2CAP and this is a
software layer.
  </pre>
</blockquote>
Hm here came L2CAP in ? Currently i see that there is an rfcomm
connection for controll<br>
and an SCO connection there the audio data is transmitted.<br>
<br>
btsco connect to rfcomm and connect/disconnect sco with sound module
and send mixer infos.<br>
there i do not se the point there whe deamon handle L2CAP. And i think
the discussion is there to<br>
move this part.<br>
I think an good comparision would be the Network to Bluetooth sound<br>
Mozilla=A0 --- HTTP --- tcp=A0=A0=A0=A0=A0=A0=A0=A0=A0 ---=A0=A0=A0=A0 ip=
 --- arp --- 802.3 =A0 =A0 =A0=A0
=A0=A0=A0 --- kable<br>
KPhone ---=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dsp/audio ---=A0=A0=A0=A0=
 sco/rfcomm=A0 --- bluethooth
--- on air<br>
<br>
btsco is in the level of sco/rfcomm.<br>
This could be compared with the routing engine that decide=A0 on wich
device an packet went.<br>
There sco is the tcp/udp channel and rfcomm the icmp.<br>
<br>
The situation is similiar in antoher point the basic routing is done in
the kernel so that tcp stack is usable.<br>
And external routing deamon is used for higher layer routing wich
interact with the internal routing.<br>
<br>
For bluetooth headset this would mean basic function is done in the
kernel (connection handling, volume controll).<br>
data conversion and spezial sound protocol in userspace.<br>
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
