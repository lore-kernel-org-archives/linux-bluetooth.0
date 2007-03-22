Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Wed, 21 Mar 2007 21:57:52 -0700
From: Matt Zimmerman <mdz@ubuntu.com>
To: bluez-users@lists.sourceforge.net
Message-ID: <20070322045752.GM7472@alcor.net>
References: <20070311203223.GP8187@alcor.net>
	<20070311205548.GQ8187@alcor.net> <45F58229.50403@redhat.com>
	<20070322031835.GJ7472@alcor.net>
MIME-Version: 1.0
In-Reply-To: <20070322031835.GJ7472@alcor.net>
Subject: Re: [Bluez-users] Plantronics 510 headset: playback partially works,
	but not recording
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

On Wed, Mar 21, 2007 at 08:18:35PM -0700, Matt Zimmerman wrote:
> On Mon, Mar 12, 2007 at 12:39:05PM -0400, Alan Conway wrote:
> > Matt Zimmerman wrote:
> > > I found an example which used aplay -B 1000000, and that fixes the
> > > stuttering.  Still no luck yet on recording.
> > I'm trying to get a similar setup to work, here's my previos post with 
> > my status so far, would love to hear of any breakthroughs you make:
> 
> Thanks for sharing your experience.
> 
> > Trying to use a plantronics 510s with skype.
> > 
> > Update on my attempts, I've established the setup that almost works. By 
> > almost works I mean:
> > - aplay, arecord -D headset work, quality is fine for telephone use.
> 
> Interesting, so recording works for you?  I wonder what's different about
> your setup.

Could you send me an hcidump -V trace of you capturing with arecord?  I'd
like to compare it to what I see here.

-- 
 - mdz

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
