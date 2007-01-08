Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Mon, 8 Jan 2007 20:39:07 +0200
From: Johan Hedberg <johan.hedberg@nokia.com>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20070108183907.GA12105@jh-mbp>
References: <45A28E40.10705@idlum.be>
MIME-Version: 1.0
In-Reply-To: <45A28E40.10705@idlum.be>
Subject: Re: [Bluez-devel] Accented characters in friendly name properly
	handled in BlueZ?
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

Hi Pierre-Yves,

On Mon, Jan 08, 2007, Pierre-Yves Paulus wrote:
> I'm using the D-Bus API to get the friendly name of a terminal wich name 
> contains accented chars. In the String I get, each accented character 
> (eg not a 1-byte ASCII char) gets replaced by 2 chars, each with value 0x2e.
> 
> Is the problem coming from BlueZ or from the D-Bus bindings layer? Where 
> should I look to get a clue?

It's a bug in the validation code responsible for storing the 
friendly name. It has been fixed in the 3.8 release.

JOhan

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
