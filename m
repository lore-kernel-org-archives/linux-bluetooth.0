Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: soraberri <421246@posta.unizar.es>
Message-ID: <d0ktcr$n2i$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-devel] btsco and alsa driver interaction
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
Date: Tue, 08 Mar 2005 20:11:31 +0100



I have studied btsco.c code (the userspace code part), but I'm scared of 
the kernel part. It's my first match with a kernel driver and it has won 
the game... so, I would like to ask you just to figure out how the big 
black box is behaving.

My impression is that in btsco daemon, once we get the descriptor for 
the SOCK_STREAM socket we just need to hook it to the hwdep device, and 
it seems that it is done this way -more or less-

	sd=sco_connect(	&local,
			&bdaddr,
			&sco_handle,
			&sco_mtu));

	bt_sco_set_fd(handle, sd);

where _handle_ represents the device. So I imagine that all what is 
happening with the SCO channel is "carried" into the device. Is it right?


I also imagine that when we poll data from the hwdep interface, we are 
not polling SCO data type (which I assume it is being drived 
automatically); instead, we are polling for volume-control data type 
which is enigmatically (for me) generated at the core of the driver. Is 
it right?

The question is, 'when does the following condition evaluate TRUE  ?

if (!snd_hwdep_poll_descriptors_revents(handle, &pfds[nfds - 1], 1, 
revents) && revents & POLLIN) {

a) when we have used the write function some point before, like this:
snd_hwdep_write(handle, volumes, sizeof(volumes));

b) only when the driver is initialized at the begining

c) or, periodically at some interval defined in the driver code...

well, sorry if these answers are a bit obscure, they are just to give 
you an idea of how poor is what I can imagine. I think what I wish to 
know is 'when and why will the hwdep interface produce the events we are 
listening for'?

Thanks a lot in advance

Luis Peiro



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
