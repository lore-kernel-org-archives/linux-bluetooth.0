Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <42443FDB.3070205@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] a2dp timing
References: <42439ADA.5000006@xmission.com> <1111756476.9195.105.camel@pegasus>
In-Reply-To: <1111756476.9195.105.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Fri, 25 Mar 2005 09:44:11 -0700

Marcel

> In the case of an ALSA plugin, we may simple use the timing of the ALSA
> system itself. However it would be great if the SBC encoder would also
> calculate the time of the PCM fragment.

ok, I will look at the plugin again. I was discouraged before by the 
complexity and by the fact that a lot of alsa clients won't let you 
choose a userspace plugin device (and even with those that do, you have 
to remember and type in an alsa device name to reach a userspace plugin)

>>	frame_len = read_header(fd, &sbc_info);
>>	bytes_read = read(fd, killbuffer, frame_len);
> 
> And then you need to sleep some time before reading/dropping the next
> SBC frame.

of course from the plugin, these won't be read() calls, they will be 
calls into the sbc lib.

brad


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
