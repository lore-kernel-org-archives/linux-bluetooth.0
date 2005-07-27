Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <42E76684.20301@csr.com>
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re:How can I set CSR module as PCM master?
References: <20050727090711.69181.qmail@web15702.mail.cnb.yahoo.com>
In-Reply-To: <20050727090711.69181.qmail@web15702.mail.cnb.yahoo.com>
Content-Type: text/plain; charset=UTF-8
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
Date: Wed, 27 Jul 2005 11:48:36 +0100

宁 宁 wrote:
> Hi,
> thanks Steven and Peter.
> I have no other PS tools except pskey,so I cann't set PSKEY PCM_CONFIG32.  
>  And if the module's default is PCM master,it should generate clock and sync,but it don't
> ,so the MC145483 doesn't work! I didn't change other settings except PCM map using
> "pskey -i hci0 mapsco 1"! The Codec's sample format is 13-bit,but the CSR module's is
> 16-bit, is that the matter?

This doesn't matter. PSKEY_PCM_FORMAT overrides the HCI Voice_Settings
(for the input format, not for the air format). By default, that's set
to produce 13 bit data - just what the MC145483 wants.

You are running some slightly unusual firmware for an HCI module. The
firmware you're running is more normally associated with having an
application on chip. Is it possible there's an application on board
which is messing things up? (Of course, if it's a dual boot dongle then
we'd expect there to be an application on chip, but it'll shut down in
HCI mode).

> If not,what's wrong?

I've no idea.

The codec you've got and the setup you're using (BlueCore is PCM master
on an MC145483 codec) is exactly the one we use for all our regression
tests. Hence, I'm really, really sure it works.

Is there any possibility of a PCB problem? What module or dongle are
you using? Do you have a Casira you can use for comparison?

	- Steven
-- 


**********************************************************************
This email and any files transmitted with it are confidential and
intended solely for the use of the individual or entity to whom they
are addressed. If you have received this email in error please notify
the system manager.

**********************************************************************



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
