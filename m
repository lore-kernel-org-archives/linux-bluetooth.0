Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] a2dp timing
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <42443FDB.3070205@xmission.com>
References: <42439ADA.5000006@xmission.com>
	 <1111756476.9195.105.camel@pegasus>  <42443FDB.3070205@xmission.com>
Content-Type: text/plain
Message-Id: <1111771895.9195.133.camel@pegasus>
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
Date: Fri, 25 Mar 2005 18:31:35 +0100

Hi Brad,

> > In the case of an ALSA plugin, we may simple use the timing of the ALSA
> > system itself. However it would be great if the SBC encoder would also
> > calculate the time of the PCM fragment.
> 
> ok, I will look at the plugin again. I was discouraged before by the 
> complexity and by the fact that a lot of alsa clients won't let you 
> choose a userspace plugin device (and even with those that do, you have 
> to remember and type in an alsa device name to reach a userspace plugin)

the flag for that is there, but the ALSA core does not use it. Seems
like I need to remind Takashi to add it.

> >>	frame_len = read_header(fd, &sbc_info);
> >>	bytes_read = read(fd, killbuffer, frame_len);
> > 
> > And then you need to sleep some time before reading/dropping the next
> > SBC frame.
> 
> of course from the plugin, these won't be read() calls, they will be 
> calls into the sbc lib.

In case of the plugin you can simply drop the PCM fragment.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
