Return-Path: <James@superbug.demon.co.uk>
Message-ID: <4042575B.20305@superbug.demon.co.uk>
Date: Sun, 29 Feb 2004 21:19:23 +0000
From: James Courtier-Dutton <James@superbug.demon.co.uk>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] SCO. Some ideas.
References: <40421024.20602@superbug.demon.co.uk>	 <1078074126.1942.31.camel@pegasus>  <40423226.8050007@superbug.demon.co.uk> <1078087109.1942.54.camel@pegasus>
In-Reply-To: <1078087109.1942.54.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel Holtmann wrote:
> Hi James,
> 
> 
>>This is something I need to be able to understand better.
>>What should actually be adjusting the voice setting? To me it seems 
>>sensible that we should try to get the voice setting to match the alsa 
>>PCM samples if we can.
>>Of course, another approach is getting the application to set the voice 
>>setting, and then open the SCO link, and then force alsa to use whatever 
>>voice setting the SCO link was set to. We would get the application to 
>>inform alsa about this voice setting via an ioctl.
> 
> 
> we only need to know about the input coding. The ALSA driver maybe needs
> to convert the PCM samples to the input coding of the Bluetooth device.
alsa handles format conversion automatically, all we have to tell alsa 
is which formats we can do, and alsa does the rest. So, if alsa is not 
allowed to modify the hciconfig hci0 voice XX setting, it can just be 
told what it is via an IOCTL and then tell alsa to do conversions for 
any other formats.

> 
> 
>>The alsa-driver receives a trigger() api call from an alsa based 
>>application. It would be nice to pass this trigger() function on down 
>>the stack to whichever bluetooth hci driver we are using (hci_usb or 
>>whatever else), and that hci driver handle it appropriately.
>>I just gave the usb_submit_urb() as an example of what the hci_usb.c 
>>driver would do when it received the trigger() call.
>>For example. The SCO link is open, but no actual sound samples start 
>>being sent or received from the CPU until the trigger() call.
> 
> 
> I don't see any need for it.

Some audio applications need this feature, which is why alsa provides it.

> 
> 
>>I was using the HCI USB driver as an example only.
>>The alsa-driver receives a pointer() from the alsa based application. we 
>>need to pass a call to the HCI driver (hardware independently) which 
>>would return the frame pointer. I don't think the concept of a 
>>frame_pointer is USB specific. Any Bluetooth hardware driver will use a 
>>frame_pointer.
> 
> 
> I don't get this either, because we don't need to interface with any
> hardware drivers.

Some audio applications need this "pointer" feature, which is why alsa 
provides it.
An example of this is playback of DVDs.
Video output needs to be kept closely in sync with the audio, and this 
"pointer" and "trigger" feature allow the application to closely control 
exactly when the sound plays. "trigger" handles the "start the sound 
exactly now", and "pointer" provides feedback, saying that "sound sample 
xyz is currently playing, so display video frame xyz now". "pointer" 
also provides for "audio is playing 0.25 seconds ahead of video, adjust 
it to match".
These are not hardware specific features, all sound hardware has these 
features, including bluetooth audio, and we just need some way for 
higher layers to get access to the values.
Another example is Voice over IP. If using a headset, one might want to 
use it to make VoIP calls over the internet. One of the most important 
issues with VoIP is latency. The lower the latency, the more natural the 
conversation will be. Long latency produces conversations will long 
breaks in between and possible delayed echos. It is a lot more difficult 
to have a natually smooth conversation if the latency is high. These 
"pointer" and "trigger" and "period_time_elapsed" functions allow for 
applications to program minimum latancy that any particular hardware can 
handle.

> 
> 
>>Maybe I should look at the patch first, but ..
> 
> 
> You can find it in the mailing list archive.
> 
> 
>>I cannot see anywhere in the current HCI layer api where I can find out 
>>which HCI SCO packet is currently(in realtime) being output. All I know 
>>is that if I send an HCI SCO packet down the stack, it will get queued, 
>>and at some point be output. That is not good enough.
> 
> 
> Why would you wanna know this? If you send too much data, the Bluetooth
> chip itself will drop the packets.
Hopefully my explanation above regarding DVDs will answer this.

> 
> Regards
> 
> Marcel
> 
> 
> 
> 

Cheers
James
