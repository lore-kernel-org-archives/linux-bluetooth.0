Return-Path: <cyrus@holtmann.org>
Message-ID: <4793F2A2.9030804@gmail.com>
Date: Mon, 21 Jan 2008 06:47:22 +0530
From: Mohan Sundaram <mohan.tux@gmail.com>
MIME-Version: 1.0
To: russell <russell@rickstewart.com>,
	BlueZ users <bluez-users@lists.sourceforge.net>
References: <20080120235254.32204.qmail@station192.com>
In-Reply-To: <20080120235254.32204.qmail@station192.com>
Subject: Re: [Bluez-users] All connections disconnect immediately
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

russell wrote:
> If I put another command on the same line, for instance:
> 
>      hcitool cc $HeadsetID ; hcitool lq $HeadsetID
> 
> the 'lq' gets completed before the disconnection so I get a link quality report (240-255).
> 
> The same happens when I connect to a neighbor's computer (unbeknownst to them).
> 
> What's going on here?
It is not pairing. Bluez site has info that describe how pairing can be 
achieved.

Mohan

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
