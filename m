Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <427EE734.4030303@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Regarding a2recv
References: <20050506060525.32b209ca.henryk@ploetzli.ch>	<20050508125039.1494.qmail@web8305.mail.in.yahoo.com> <20050509005413.3787d2d7.henryk@ploetzli.ch>
In-Reply-To: <20050509005413.3787d2d7.henryk@ploetzli.ch>
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
Date: Sun, 08 May 2005 22:29:40 -0600

Henryk

> there should only be one struct that includes a struct avdtp_header and
> a union with all the other optional signalling contents. Then there
> would have to be specialised read()/write() functions which figure out
> (based on the header) how long the packet actually is and automatically
> send/receive that many bytes. However, that would also require
> modification of a2play so I thought I'd ask first.

I think this part sounds better, especially if Marcel thinks this is 
closer to what it will look like if/when it's "kernelized" :)

The only tricky part is the MAX_ADDITIONAL_CODEC stuff. Make sure we 
only try to send one codec when we're reporting our sink's capabilities 
and accept multiple codecs when we're reading capabilities.

Maybe what you're proposing will clean up the "optional" error codes in 
places like open_stream_rsp. The header would look different so you 
could distinguish the error codes and compute the size properly when 
sending. Be sure we accept the extended size with the error codes when 
receiving.

Brad


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
