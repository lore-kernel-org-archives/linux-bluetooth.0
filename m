Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <403CB92E.1000009@grupopie.com>
From: Paulo Marques <pmarques@grupopie.com>
MIME-Version: 1.0
To: Matthew Reimer <mreimer@vpop.net>
Cc: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] How to configure a 723kbps connection?
References: <lists.bluez.users.1077037423.2665.72.camel@pegasus.SOMEWHERE> <lists.bluez.users.403291AD.7080601@csr.com> <403AC9D1.1000902@vpop.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Wed, 25 Feb 2004 15:03:10 +0000

Matthew Reimer wrote:

> 
> I tried setting the divisor to 1 manually, but then bluetooth wouldn't 
> work. Maybe PPC2003 isn't fast enough to handle interrupts at that rate?
> 

That wouldn't work because the zeevo chip would also have to be configured for 
921.6kbps. AFAIK only modems try hard to autodetected baudrate from the "at" 
command string.

There is probably a good reason for the HP guys to set up the port like that. If 
it would work at 921.6kbps they would probably use the extra bandwidth. This is 
really a shame, because I was thinking of buying a 2215 myself, but I would like 
to have a "full-speed" bluetooth (and Linux support) :(

-- 
Paulo Marques
Software Development Department - Restinfor, Lda.
Phone: +351 252 290600, Fax: +351 252 290601
Web: www.grupopie.com

"In a world without walls and fences who needs windows and gates?"



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
