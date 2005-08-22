Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <430A4D5F.7090201@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] AGC and anti-noise patch for btsco kernel module
References: <20050819193855.GA25514@uni-duesseldorf.de> <43078EF3.4050702@xmission.com> <20050821192634.GA10231@uni-duesseldorf.de> <430954A6.40107@xmission.com> <20050822120911.GA5397@uni-duesseldorf.de> <20050822183820.GA18410@uni-duesseldorf.de> <20050822185341.GA18549@uni-duesseldorf.de>
In-Reply-To: <20050822185341.GA18549@uni-duesseldorf.de>
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
Date: Mon, 22 Aug 2005 16:10:39 -0600

Andreas,

The adaptive strategy you chose seems like it will work well. That was 
very quick coding and good intuition on the noise problem! I'll try the 
patch.

Converting our kernel module to an alsa userspace driver is on the 
roadmap and I believe your approach could be used there as well.

Marcel will probably ask why we don't fix the problem in the bluez 
layers if that's where it is, so every SCO app benefits.

Can you surround the adaptive stuff and swapping stuff with two 
different macros so we can select them independently? Like USE_ADAPTIVE 
and USE_AUTOSWAP or something?

Brad


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
