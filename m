Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <42B56293.9060309@sdgsystems.com>
From: Todd Blumer <todd@sdgsystems.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [PATCH] TI BTS for hciattach
References: <20050619030502.89EF71243E@sc8-sf-spam2.sourceforge.net>
In-Reply-To: <20050619030502.89EF71243E@sc8-sf-spam2.sourceforge.net>
Content-Type: text/plain; charset=ISO-8859-1
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
Date: Sun, 19 Jun 2005 08:18:27 -0400

Marcel,
I will check with TI about the possibility of getting you documentation and / or development kit. Maybe we can loan you an iPAQ hx4700.

(Yes, the code did come from windows, and a re-write is fine. I didn't take the time at this point, since it was working.)
--
Todd

--
Subject: Re: [Bluez-devel] [PATCH] TI BTS for hciattach
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
Date: Sun, 19 Jun 2005 01:24:46 +0200
Reply-To: bluez-devel@lists.sourceforge.net

Hi Todd,


>> This proposed patch implements the TI BTS (Bluetooth script) mechanism.
>> I have attached the diff and new files to be built along with hciattach.
>> I have also attached a sample BTS file (the one that goes along with the
>> BRF6150 plus firmware, as found in the iPAQ hx4700). The code is a bit
>> chatty (prints BTS comment lines), but provides feedback as to what is
>> being done with the chip. Comments / Suggestions welcome.
>  
>

is it possible to get a development kit with the BRF6150 from TI? I like
to test this new code.

Do we get the full specification of BTS? I think we need to rewrite some
parts of the TI code. I don't like the coding style and parts of it look
too much like crappy Windows code.

Regards

Marcel





-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
