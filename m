Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <44D6339E.5050500@xmission.com>
Date: Sun, 06 Aug 2006 12:23:26 -0600
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <20060806022037.GA2763@as.arizona.edu>
In-Reply-To: <20060806022037.GA2763@as.arizona.edu>
Subject: Re: [Bluez-users] static burst with btsco
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

John

Are you into hacking?

I need to find out the status on the sco alsa driver kernel work, but it
may improve things if you use it with the alsa sco plugin. It's now in
cvs but I haven't rewritten the docs. It's all a work in progress at the
moment.

Brad

> I'm using btsco with a Plantronics M2500 headset.  The connection is up and
> working fine, for the most part.
> 
> The problem I am having now is that at seemingly random instances, the headset
> will emit a burst of static (white noise) at maximum volume to whomever I am
> talking to.
> 
> It took a while to track down because I cannot hear this.  It only occurs in
> the outbound audio stream.  The connection doesn't falter and the conversation
> can continue, though the person I am talking to is none too happy.
> 
> I'm assuming this is a bug in btsco, but I'm not sure how to narrow it down.
> I can make a recording of the audio, perhaps, or run hcidump... but because
> the problem occurs randomly it might take awhile.
> 
> What would be the best course of action to track down this problem?  What
> would be of most use to the developers?
> 
> 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
