Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "Nicholas A. Preyss" <nalp@gmx.net>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Questions about BlueZ in  commercial use
Message-ID: <20040627214233.GA26576@gmx.net>
References: <003401c45c2b$b6eab240$0364a8c0@haruo> <1088359746.3774.20.camel@pegasus> <20040627191016.GA26191@gmx.net> <1088363397.3774.64.camel@pegasus> <20040627203414.GB26191@gmx.net> <1088369388.3774.88.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1088369388.3774.88.camel@pegasus>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 27 Jun 2004 23:42:33 +0200

On  0, Marcel Holtmann <marcel@holtmann.org> wrote:
> the current USB subsystem (as of 2.6.7) is not as bad as you think.
> Actually it is working very nice and even the hci_usb driver didn't
> crash anymore. Anyhow the problem is not USB. We made all of them by
> ourself :(

I think the problem is USB. It is too complicated for the least cost
market. So many manufacturers built chips or firmware for USB devices
which are not spec compliant. Additionaly there are so many bad 
programmed driver.
I think this is a design failure, even if it only appears as bad driver
implementations.

> > The debian project shows that if you really want such high quality
> > standards for use in embedded devices e.g. it is possible to keep your
> > own stable branch. I think it is very easy with a good Changelog.
> 
> I really like the Debian way of forking a stable version and only doing
> security or bugfixes. The problem is that this needs a lot of man power
> and costs a lot of time. I know what I am talking about, because I did
> all the 2.4 kernel backports of the Bluetooth subsystem.

A company would need to do this for the version they use in production
systems only. So it should be possible.

> If we got a number of companies that help sponsoring the BlueZ itself
> and its official qualification I can think of such a fork. At that point
> it makes sense to me and is worth the extra work.

I didn't thought of you maintaining such a stable fork. But like in the
debian project, the developers who need this high quality standard, care
for the branch themselves. Then you need to assure only, that all fixes you
apply are documented and published, even if you fix them with a new feature
that doesn't go into the stable tree.

nicholas


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
