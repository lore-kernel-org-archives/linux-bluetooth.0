Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: where can I find patch for 2.6.9?
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <4203B336.6080804@gmx.ch>
References: <c93f2a29050203210522694d38@mail.gmail.com>
	 <ctv818$aa1$1@sea.gmane.org> <1107517953.6921.3.camel@pegasus>
	 <4203A9C4.7040509@gmx.ch> <1107538283.6921.51.camel@pegasus>
	 <4203B336.6080804@gmx.ch>
Content-Type: text/plain
Message-Id: <1107540379.6921.78.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 04 Feb 2005 19:06:19 +0100

Hi Marco,

> > We are developing for 2.6 and I don't have time to do the backporting to
> > 2.4 and actually I see no reason to do this.
> 
> Well, there are reasons. But that would be a huge lot of work and would 
> only slow down the progress and development of bluez.

there is always work, but I think it is better to investigate into
switching to 2.6 instead of backporting BlueZ. The advantage of using
2.6 is that some stuff comes free house, like the BlueZ ;)

>  > People should start using
> > the new stable kernel series or pay someone to backport the stuff if
> > they wanna stick with an old kernel.
> 
> Right. That's the only way that makes sense (in my mind).
> 
> I'm curious:
> what would a backport to a specific 2.4 kernel cost?
> What time would it need?
> 
> Oh, I just see that you wrote "someone". So you wouldn't be available for 
> such a action?
> 
> Is there a list of features that are not in the 2.4 series?

I never made a list for that, but actually there are some serious dead
lock fixes for some corner cases, some protocol corrections and of
course the RFCOMM service level security that was merged mainline and
will be part of the final 2.6.11 kernel.

Since I keep track all of my changes, a simple "ls patch-2.6.* | wc -l"
revealed 138 patches. There are maybe some duplicates and some 2.6 only
patches, but there must be at least 50-60 patches of difference between
the latest 2.4 and the current 2.6 kernel.

So how much time would this take? I can't tell you right now, because
for that I have to look to all 138 patches and decide if they should be
backported or not. This also depends on the specific 2.4 kernel version
you want this backport for. And then add the testing part.

I would maybe be available for such a job, but this depends on when you
need this. And the cost question is easy, because you only have to
multiply the time with my normal price per hour ;)

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
