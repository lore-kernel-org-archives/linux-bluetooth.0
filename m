Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4045F5AF.2000107@superbug.demon.co.uk>
From: James Courtier-Dutton <James@superbug.demon.co.uk>
MIME-Version: 1.0
To: Simon Vogl <vogl@soft.uni-linz.ac.at>
CC: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] sco links
References: <4045E93F.4040900@soft.uni-linz.ac.at>
In-Reply-To: <4045E93F.4040900@soft.uni-linz.ac.at>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Wed, 03 Mar 2004 15:11:43 +0000

Simon Vogl wrote:
> hi,
> can anyone help me with my sco link? in about 50% of cases, the audio data
> has an offset of one byte, resulting in terrible noise. I think I saw a
> flag in a packet header somewhere that indicates the number of bytes to 
> skip
> until the audio data starts -- I looked through the bt specs several 
> times now
> but can't find it again. Anyone has a clue for this?
> Simon
> 

The terrible noise will be lost interrupts

Cheers
James



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
