Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: starting btsco-in-libalsa
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <41B849BC.5060002@suche.org>
References: <41B81ACB.1080807@xmission.com>
	 <1102589835.9988.114.camel@pegasus>  <41B83BA8.5010001@suche.org>
	 <1102594031.9988.171.camel@pegasus>  <41B849BC.5060002@suche.org>
Content-Type: text/plain
Message-Id: <1102597833.9988.207.camel@pegasus>
Mime-Version: 1.0
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
Date: Thu, 09 Dec 2004 14:10:33 +0100

Hi Thomas,

> > this is too short thinking. There are parts that don't belong inside the
> > kernel. And SBC encoding and decoding is one of them.
> >   
> OK that is an point that i can understand. But the btsco daemon does
> not handly any conversion.
> He is only responsible for managing the "hardware" Meaning 2 points:
> - handle the hardware connection rfcomm / sco
> - pipe the volume information betwen the mixer and the headset.
> He does not do any conversion and also he only interact between kernel
> modules as an linking glue.

the SCO is PCM and so there is no problem to have this inside the
kernel, but headset profile means AT commands over RFCOMM. I am not
going to put an AT parser inside the kernel.

> > Bluetooth is not only hardware. What you see is a dongle, but on top
> > there is a complete stack. We interface with L2CAP and this is a
> > software layer.
> >   
> Hm here came L2CAP in ? Currently i see that there is an rfcomm
> connection for controll
> and an SCO connection there the audio data is transmitted.

And RFCOMM is on top of L2CAP. Even if you don't have to worry about
L2CAP, it is there.

> btsco connect to rfcomm and connect/disconnect sco with sound module
> and send mixer infos.
> there i do not se the point there whe deamon handle L2CAP. And i think
> the discussion is there to
> move this part.
> I think an good comparision would be the Network to Bluetooth sound
> Mozilla  --- HTTP --- tcp          ---     ip --- arp --- 802.3
> --- kable
> KPhone ---              dsp/audio ---     sco/rfcomm  --- bluethooth
> --- on air
> 
> btsco is in the level of sco/rfcomm.
> This could be compared with the routing engine that decide  on wich
> device an packet went.
> There sco is the tcp/udp channel and rfcomm the icmp.

This is not compareable. TCP/IP is more protocol specific and the
Bluetooth stack is more profile/application specific.

> The situation is similiar in antoher point the basic routing is done
> in the kernel so that tcp stack is usable.
> And external routing deamon is used for higher layer routing wich
> interact with the internal routing.

I don't get the point what static routing versus dynamic routing has to
do with it.

> For bluetooth headset this would mean basic function is done in the
> kernel (connection handling, volume controll).
> data conversion and spezial sound protocol in userspace.

If we talk about the headset/handsfree support and if it would only be
SCO specific I would agree, but the volume control is realized using AT
commands. You don't want an AT parser inside the kernel.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
