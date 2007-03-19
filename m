Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: David Stark <dave@davidstark.name>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <45FF1D5B.7030403@sportlaan.adsl.utwente.nl>
References: <45FF1D5B.7030403@sportlaan.adsl.utwente.nl>
Date: Mon, 19 Mar 2007 22:52:03 +0000
Message-Id: <1174344724.30217.6.camel@cronus.homenet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Use SCO links to a phone
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

On Mon, 2007-03-19 at 23:31 +0000, Berend Dekens wrote:
> Hi everyone,
> 
> Maybe I'm barking up the wrong tree here but I'm trying to link my phone
> with my pc (trying to build a carpc so the computer will act as a 
> carkit) and I found some old tool somewhere that generates a handfree
> connection, but its old and broken. Then I found alsa-bluetooth and gave
> that a whirl.
> 
> Even though that project seems to ride in the right direction (at least
> there is talk about SCO -voice- connections) I can't figure out what I
> should use and how to set it up. The main problem besides having to set
> up the SCO link, is that I need access to the rfcomm part of channel 3
> (HF) as well because I need to parse status data, be able to answer
> calls and initiate them.
> 
> I've googled my ass off but it looks like I'm one of the few people on
> the planet who are trying to figure this out: SCO support is in the
> kernel but I can't find a single guide (not one!) that actually seems to
> do something with the SCO module...
> 
> It could ofcourse be that I don't need the alsa-bluetooth stuff at all
> but after spending roughly 140 hours of reading and experimenting I'm
> throwing in the towel...
> 
> Cheers,
> Berend Dekens

Hi.

I may be barking down the wrong tree, so to speak, but I think all the
functionality you need is present in gammu, and whenever I've used gammu
over rfcomm, it's been fine on channel 1.

Dave


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
