Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Timeout message from kernel
From: Marcel Holtmann <marcel@holtmann.org>
To: Jeff Sutherland <jeffs@fairwayacademy.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200402151743.51707.jeffs@fairwayacademy.org>
References: <200402121636.02074.jeffs@fairwayacademy.org>
	 <200402140859.36255.jeffs@fairwayacademy.org>
	 <1076770958.14758.5.camel@pegasus>
	 <200402151743.51707.jeffs@fairwayacademy.org>
Content-Type: text/plain
Message-Id: <1076888201.2840.30.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 16 Feb 2004 00:36:42 +0100

Hi Jeff,

> /> hcitool info 00:0A:4F:00:09:5E
> Requesting information ...
> bcsp_timed_event: Timeout, retransmitting 1 pkts
>         BD Address:  00:0A:4F:00:09:5E
>         Device Name: BlueZ (0)
>         LMP Version: 1.1 (0x1) LMP Subversion: 0x20d
>         Manufacturer: Cambridge Silicon Radio (10)
>         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
>                 <3-slot packets> <5-slot packets> <encryption> <slot offset>
>                 <timing accuracy> <role switch> <hold mode> <sniff mode>
>                 <park state> <RSSI> <channel quality> <SCO link>
>                 <HV2 packets> <HV3 packets> <u-law log> <A-law log>
>                 <CVSD> <paging scheme> <power control> <transparent SCO>
>                                                                                 
> />
> 
> Heh, my hunch was correct for once, looks like it WAS an endian problem :-D

the patch is now in CVS. I suspect that the code contains other endian
problems. You always overlook some one. I really think that I need a big
endian machine at home. Are there any sponsors?

Regards

Marcel




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
