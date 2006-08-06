Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Sun, 6 Aug 2006 12:38:03 -0700
From: John Gruenenfelder <johng@as.arizona.edu>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Message-ID: <20060806193803.GA3758@as.arizona.edu>
References: <20060806022037.GA2763@as.arizona.edu>
	<44D6339E.5050500@xmission.com>
MIME-Version: 1.0
In-Reply-To: <44D6339E.5050500@xmission.com>
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

On Sun, Aug 06, 2006 at 12:23:26PM -0600, Brad Midgley wrote:
>John
>
>Are you into hacking?
>
>I need to find out the status on the sco alsa driver kernel work, but it
>may improve things if you use it with the alsa sco plugin. It's now in
>cvs but I haven't rewritten the docs. It's all a work in progress at the
>moment.
>
>Brad

That depends on what needs hacking.  :)
I'm no stranger to C or to programming, but my experience with the internals
of ALSA is quite limited.

To that end, I have the alsa plugins compiled now, but I'm rather unsure how
to make use of them.  The phone app I've been using, iaxcomm, does not use
ALSA directly, so it's probably not of much use.  Ekiga, however, does use
ALSA natively so I can use that instead.

The ALSA documentation describes using plugins in a very general sense.  I see
that there is an asound.conf file in the alsa-plugins directory for use in my
.asoundrc file.

I'm definitely willing to test, but I'll need a little help sticking all the
parts together.


-- 
--John Gruenenfelder    Research Assistant, UMass Amherst student
                        Systems Manager, MKS Imaging Technology, LLC.
Try Weasel Reader for PalmOS  --  http://gutenpalm.sf.net
"This is the most fun I've had without being drenched in the blood
of my enemies!"
        --Sam of Sam & Max

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
