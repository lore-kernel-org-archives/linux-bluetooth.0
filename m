Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] SCO. Some ideas.
From: Marcel Holtmann <marcel@holtmann.org>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <40421024.20602@superbug.demon.co.uk>
References: <40421024.20602@superbug.demon.co.uk>
Content-Type: text/plain
Message-Id: <1078074126.1942.31.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 29 Feb 2004 18:02:06 +0100

Hi James,

> As SCO over bluetooth is only really suitable for audio sound data, I 
> see no real problem with alsa being the only interface in linux to send 
> data over a bluetooth SCO connection. (only the actually sco data, not 
> the bluetooth profile control)
> Does anyone see a problem with that?

there are two interfaces with Bluetooth 1.2. SCO/eSCO audio and eSCO
data. This means we need an ALSA interface and a socket interface.

> If people think we should also make it easy to add an OSS driver, and 
> also a network socket driver, we could maybe work out some devision 
> between the SCO specifics and the ALSA specifics. But for a first 
> attempt, we should keep the SCO and ALSA driver tightly matched.

We need the socket driver, but we don't need an OSS driver. But I see no
problem with this, because the RFCOMM layer also includes socket and TTY
support at the same time.

> Therefore maybe making the bluetooth sco and alsa-sco module being the 
> same module, with an ioctl interface so that a user space application 
> can handle the creation of bluetooth profile SCO pairing.

Yes. Only one kernel module called sco.

> For example, if using a Headset profile, the alsa PCM and alsa MIXER 
> device would only appear if the userspace application had already set up 
> the RFCOMM connections. The userspace application would also have to 
> have set up the bluetooth specific details for the SCO connection, so 
> that when alsa opens the PCM, it has enough information to open a SCO 
> connection.

ALSA don't open the SCO connection. This is part of the application that
implements the profile. In the case of the headset profile, you must
first have the RFCOMM connection and then the SCO link. No SCO link
without an ACL link.

> I have looked at this for the alsa->sco->bluetooth->hci_usb  drivers.
> The alsa driver has to be able to do the following: -
> 1) open - this should check that all bluetooth connections are up that 
> need to be up in order for SCO data to pass. It could do this via 
> interaction with the userspace bluetooth profile.

If there is no SCO link -> failure.

> 2) close - close everything neatly.

Of course, but the SCO link should be closed by the application.

> 3) hw_params - allocate buffers etc. for the pcm audio as well as the 
> hw_params config. Can be called multiple times, so re-alloc of buffers 
> should be allowed for. hw_params are things like sample rate, number of 
> channels, PCM format. Obviously there are limits on what these values 
> can take when using bluetooth. 16bit PCM, 8bit PCM, 8bit A-law, 8bit 
> u-Law. Start by also limiting it to 1 PCM channel. I.E. Mono and not stereo.

The possible values depends on the voice setting.

> 4) pcm_prepare - actually set the hw_params. e.g. do the equivalent of 
> hciconfig hci0 voice XX, where XX depends on the hw_params.
> Also selecting usb alt profiles.
> The only difference between hw_params and pcm_prepare is that 
> pcm_prepare is called for xrun recovery.

I am not sure if we should allow the ALSA driver to change the voice
settings. As I know it is not possible to change the voice setting of an
already existing SCO link.

> 5) trigger - actually start/stop usb_urbs (e.g. call 
> usb_submit_urb/usb_unlink_urb now.)

Not part of the ALSA driver. This is a problem of the HCI USB driver.

> 6) pointer - get hw_usb_frame_pointer and modify the result to simulate 
> an audio ring buffer of the size configured in the hw_params.
> When retrieving the pointer, one should also retrieve the valid range 
> that the pointer can have, so one can adjust for pointer wrap around.
> For usb, this would be the usb_get_current_frame_number() for the 
> pointer, and dev->bus->iso_sched_frames for the range of values it can take.

The SCO interface is not driver specific. So no interaction we the HCI
USB driver.

> 7) period_time_elapsed - hci_usb should call this on each urb_complete 
> call. For our use, it seems sensible to make 1 urb == 1 alsa period.
> 
> If we can let the alsa bluetooth audio driver have access to the 
> hardware pointers (in this case the usb current frame pointers), we will 
> get a much more accurate idea of exactly which audio sample is currently 
> being played.
> 
> Also, letting alsa control period and buffer sizes, and getting that to 
> directly determine usb urb sizes, we would give complete control of 
> buffer sizes to the application, which is vital for low latency 
> applications like Voice over IP.

No. ALSA <-> SCO is driver and hardware independent.

> Summary: -
> we need to provide up to the sco level, control of low level usb 
> interface isoc parameters. E.g. prepare, trigger, pointer, 
> period_time_elapsed, hw_params.
> 
> If people are happy with this proposal, I will start writing the alsa 
> driver, and also start adding to the bluetooth -> hci_usb driver api to 
> allow for it. The api will only change for SCO data handling, as Bulk 
> and Int handling don't need such fine controls.

Let me repeat it. The upper interface to SCO is driver and hardware
independent.

We need to extend the HCI USB driver to support start/stop of ISOC URB's
on demand and to select the right alternate settings. And this means to
split the hash for number of ACL/SCO connections and send a notification
to the driver if a new connection is created/released of if the voice
settings are changed. We already talked about this stuff. I had already
a patch for it, but the hash split was missing.

The ALSA <-> SCO driver should be written with the current API provided
by the HCI layer. Check how the current SCO driver gets and sends its
data packets. Start with this driver and don't worry so much about the
USB specific part. Use voice setting 0x0060 as the only supported value
at the moment.

Regards

Marcel




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
