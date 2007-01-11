Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45A5F420.1050103@gmx.de>
Date: Thu, 11 Jan 2007 09:24:00 +0100
From: Siegbert Baude <siegbert.baude@gmx.de>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <44F6B7AE.1030209@jambit.com>	<4582A310.60905@jambit.com>	<4583A020.2040808@xmission.com>	<4587D051.8080703@jambit.com>	<458864F1.4070104@xmission.com>	<4589371F.2000507@palmsource.com>
	<45A54D5B.8030001@xmission.com>
In-Reply-To: <45A54D5B.8030001@xmission.com>
Subject: Re: [Bluez-devel] How to use sbc.c ?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hello Brad,

Brad Midgley wrote:
> The tables we have are different because we have changed the algorithm
> over time and adapted the tables to avoid some computation. We also
> split the tables as a result of how they are used.
> 
> On top of that, we converted the values to integers which doesn't help
> make it easy to follow.
> 
> I hope it's not impossible to follow :(

At least it's difficult. ;-)
Maybe a short comment line would be nice which describes the steps from
the original tables to the ones found in the code. The perfect solution
would be the original matrix in the code and some pre-processor magic to
calculate the derived ones during compile time. If you describe the
necessary steps I could have a look at it, because I need to optimize
the synthesize methods for our project on a fixed-point DSP anyways.

Best regards
Siegbert

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
