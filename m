Return-Path: <cyrus@holtmann.org>
From: Tim Chick <chick@computergeek.freeserve.co.uk>
To: bluez-devel@lists.sourceforge.net
Date: Fri, 18 Jan 2008 20:17:35 +0000
References: <BAY102-W17970DD14D6076D3F44BCBF0420@phx.gbl>
In-Reply-To: <BAY102-W17970DD14D6076D3F44BCBF0420@phx.gbl>
MIME-Version: 1.0
Message-Id: <200801182017.36181.chick@computergeek.freeserve.co.uk>
Subject: Re: [Bluez-devel] Same Old Speed Issues
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

On Friday 18 January 2008 15:04:58 Robert Rawlins wrote:
> At the moment I've tried using both ussp-push and open-obex push clients to
> transfer the file, both giving me the same results. I'm achieving roughly
> 25Kbytes/s transfer speed both up and down. I've tried running these same
> dongles from my Windows PC and achieve well over 100kBytes/s. (This is
> transmitting to a Sony k850i handset which is v2.0 + EDR). This would lead
> me to believe its not an issue with the Dongle, more likely something with
> my Linux configuration
>

Have you tried changing the OBEX block size - try forcing the minimum size to 
64kB-1?

Cheers,
Tim


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
