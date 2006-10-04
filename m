Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <45232AE9.40605@xmission.com>
References: <4521D857.8000705@vasmac.com>  <45232AE9.40605@xmission.com>
Date: Wed, 04 Oct 2006 10:27:33 +0200
Message-Id: <1159950453.1601.5.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] SCO packet processing
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

Hi Brad,

> > I realize SCO handling has not been a priority and it sort of works.
> > Is there much interest in getting it right?
> 
> I'm very interested in it but I've only been able to address the
> application side of things. It looks like you've dug in and reached a
> decent understanding of where problems are.
> 
> Developers of embedded systems are passing linux/bluez over because
> voice is too important to just have it "mostly" work.
> 
> It's unfortunate that Fabien is not still working at it too. I was
> hoping he would keep a dialog going long enough to find an approach that
> Marcel likes but it seems like Fabien got tired of pushing it.

I am happy about any patches, but they must be clean and preferable not
breaking any kernel<->userspace API. Improving the SCO support would be
really nice.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
