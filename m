Return-Path: <James@superbug.demon.co.uk>
Message-ID: <3F17FD1A.9050003@superbug.demon.co.uk>
Date: Fri, 18 Jul 2003 14:58:50 +0100
From: James Courtier-Dutton <James@superbug.demon.co.uk>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
CC: bluez Dev <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: Bluetooth headset with Bluetooth usb dongle
	status.
References: 
	<E19a5DI-0002jL-00@sc8-sf-list2.sourceforge.net>	<3F1752C5.5020701@dsto.defe
	nce.gov.au> 	<3F17E4EF.5060401@superbug.demon.co.uk>
	<1058533496.25379.237.camel@pegasus>
In-Reply-To: <1058533496.25379.237.camel@pegasus>
Content-Type: text/plain; CHARSET=us-ascii; FORMAT=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel Holtmann wrote:
> Hi James,
> 
> 
>>The playback problem is a scheduling problem.
>>The "hci_usb_tx_complete" function uses the scheduler to kick off the 
>>next transmission, but the scheduler is too slow, and the correct method 
>>to use is getting the "hci_usb_tx_complete" function to retrieve the 
>>next packet to send from a ring buffer, and send it immeadiately during 
>>the "hci_usb_tx_complete" function. This is how the current usbaudio.c 
>>does it, so it proves that this method will work.
>>So, I will need to implement a ring buffer.
>>At the same time I want to implement sound output via alsa, so I want to 
>>make sure we have a good api to achieve that.
>>alsa requires certain information from the sound card (ring buffer 
>>position etc.), and I will have to make sure that the information alsa 
>>needs in available, by maybe adding new api calls through the sco layer 
>>to the usb-hci.c layer. I think it would be a good idea to completely 
>>separate the isoc(sound) urb path from the int/bulk/control urb path.
>>We also have the added complication that the alsa ring buffer is 
>>composed of just sound samples, but the sco layer converts that to 
>>packets with a header so the hci-usb.c layer has to deal with packets 
>>instead of samples.
>>For 8 bit mono sound, SCO creates packets with 3 header bytes, and 24 
>>sound samples. hci-usb.c then has to take each 27 byte packet and cut it 
>>down into 3 slices each 9 bytes in length. All packet sizes and slice 
>>sizes vary depending on 8/16 bits samples, and mono/stereo etc.
> 
> 
> the seperate handling of ISOC is a good idea. Max told me that ISOC
> URB's consumes USB bandwith and because of the fact that they are not
> needed all the time, we have to start and stop them dynamicly, if a SCO
> link is established or killed.

The start and stop of ISOC will happen in the alsa snd_pcm_trigger call.
The way an alsa application would work is: -
snd_pcm_open
snd_pcm_hwparam... (set format, # channels, buffer sizes etc.)
snd_pcm_prepare (recover from under/over runs.)
snd_pcm_trigger (actually start the stream with details from hwparm.)

Then during sound output, the application might call
snd_pcm_delay (returns difference between samples sent to the device, 
and samples that have actually been played.)
snd_pcm_write (writes samples to ring buffer)
snd_pcm_drop ( emply ring buffer)
snd_pcm_close (stops the stream and frees resources.)

As you can see, most of these are almost possible with the current sco 
interface, but snd_pcm_delay is definitly not present.
The actual function call to the alsa low level driver is 
snd_pcm_get_postition().

So, my plan is to split the sco driver up a bit in accordance to your 
suggestion. (Maybe I did not make myself clear on that point)
There will be a general section, that will handle calls for general sco 
access(ring buffer, pointers into ring buffer management, adding sco 
headers, handling sco connection connect/disconnect), and then there 
will be other sections for application specific stuff. E.g. The network 
interface, alsa interface, oss interface.
My reasoning here is that if one has the oss interface, one will not 
need the alsa interface and visa versa, with the network interface being 
optional.
It seems that alsa requires that all sound cards have ring buffers, and 
pointers into these buffers. These buffers are read and the pointers 
updated via callbacks from the sound hardware. It is this reason that I 
suggest that all playback and capture via a SCO connection should be 
handled with callbacks to the SCO layer from the HCI layer, with the SCO 
layer handling the ring buffer, updating pointers into the ring buffer 
and adding sco headers. Both alsa and oss have api calls to read these 
buffer pointers, and there is no such pointer api in the current bluez 
stack.
Then all other higher layer modules (oss, alsa, network) would interface 
with this ring buffer. This would also have the benefit for providing 
flow control for the application. I.E. If the ring buffer is full, it 
blocks the write call. All ISOC connections are full-duplex, 
configurable fixed bandwidth, so the ring buffer will always be emptied 
at a fixed rate.
Another suggestion is to do all the alloc of memory and creation of 
lists/queues at the snd_pcm_trigger stages, and not during tx/rx 
complete callbacks.

> 
> My current idea of handling this is that the hci_usb driver checks for
> SCO links in connection complete and disconnect complete events. Another
> idea is to add another HCI driver method (for example hdev->notify), so
> that the HCI core can notify the driver of special events or errors.

I have not really thought about connect/disconnect yet, apart from 
linking it to snd_pcm_trigger/snd_pcm_close. I am concentrating of just 
getting reliable sound playback over a sco connection. I.e The ring 
buffer and rx/tx complete callbacks.

> 
> 
>>So, there is going to be quite a lot of manipulation of the sound 
>>samples as they pass from alsa to the bluetooth device.
>>The questions I am still trying to decide are: -
>>1) When should the conversion from alsa ring buffer to packets take 
>>place. So far the only workable solution I have come up with is that the
>>"hci_usb_tx_complete" makes a callback all the way to the sco layer, and 
>>the sco layer grabs 24 bytes form the alsa ring buffer, adds it's header 
>>and returns from the callback.
>>2) interface to alsa. I think this should happen just above the SCO 
>>layer, but also ensuring that the SCO layer has enought api links with 
>>the hci-usb.c layer to be able to service all the alsa-driver api 
>>requirements.
>>3) Once that all works, modify the other low level hardware drivers to 
>>work with it. e.g. bluecard_cs.c etc.
> 
> 
> The native integration of Bluetooth audio within Linux is one of the
> most wanted things. But we can't use ALSA for the 2.4 kernel, because it
> is not a part of the kernel. For the 2.6 this is no problem, but I also
> want to have support for OSS, because there will some people (like me)
> which still uses OSS.
Maybe split the sco driver into general helper api, and then separate 
modules for network, oss, alsa type interfaces into user land.
> 
> The integration of audio is not part of the Bluetooth drivers, because
> every Bluetooth HCI driver is only a transport driver which have to
> transport the HCI command, event, ACL and SCO data between the hardware
> and the HCI core layer. The SCO data would send from the HCI core
> through the hdev->send() callback and the driver can send the SCO data
> it gets from the hardware back with hci_recv_frame(). This means that
> all needed modifications for ALSA and OSS integration have to done in
> the HCI core or the SCO layer. And all other HCI drivers will still work
> with SCO like they do now.
The recv_frame() parts seem to work ok at the moment. (with some 
modifications as outlined in a previous email)
The main problem is the send_frame() parts. hdev->send() is the wrong 
thing to do for ISOC connections (one runs into scheduling problems, 
buffer underruns and no flow control.). A callback method from the 
hardware is much beter. (e.g. Give me X number of samples NOW!). This is 
why I suggest a ring buffer and tx/rx complete callbacks from HCI to SCO 
layer to update ring buffer pointers, and then the alsa or oss layer 
above that.
I will do alsa first because there is much less work involved.
I know the callback/ringbuffer approach works well over usb, because 
alsa has a usb-audio driver, and it works fine.

> 
> Regards
> 
> Marcel
> 
> 
