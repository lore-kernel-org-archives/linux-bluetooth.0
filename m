Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Questions about BlueZ in  commercial use
From: Marcel Holtmann <marcel@holtmann.org>
To: "Nicholas A. Preyss" <nalp@gmx.net>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20040627214233.GA26576@gmx.net>
References: <003401c45c2b$b6eab240$0364a8c0@haruo>
	 <1088359746.3774.20.camel@pegasus> <20040627191016.GA26191@gmx.net>
	 <1088363397.3774.64.camel@pegasus> <20040627203414.GB26191@gmx.net>
	 <1088369388.3774.88.camel@pegasus>  <20040627214233.GA26576@gmx.net>
Content-Type: text/plain
Message-Id: <1088408222.3774.127.camel@pegasus>
Mime-Version: 1.0
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
Date: Mon, 28 Jun 2004 09:37:03 +0200

Hi Nicholas,

> > the current USB subsystem (as of 2.6.7) is not as bad as you think.
> > Actually it is working very nice and even the hci_usb driver didn't
> > crash anymore. Anyhow the problem is not USB. We made all of them by
> > ourself :(
> 
> I think the problem is USB. It is too complicated for the least cost
> market. So many manufacturers built chips or firmware for USB devices
> which are not spec compliant. Additionaly there are so many bad 
> programmed driver.

I had a small chat with Oliver Neukum about some design issues of the
USB subsystem. And yes, some parts are too complex and some companies
are unable to read specifications and understand them the right way. The
problem is that you can't prevent this.

Even in the case of Bluetooth where the qualifications tests are very
complex and try to test every aspect of a bad implementation. Some
devices are broken, but they are still qualified and must work.

On the other side parts of the specifications are bad. I may remind you
of our discussion on who has to terminate the ACL link if no other
protocol or application is using it.

> I think this is a design failure, even if it only appears as bad driver
> implementations.

The Bluetooth USB (H:2) devices are a little bit complex. A design must
grow along the needs of the real USB devices. The USB guys are now aware
of it and you can expect changes within the 2.7 kernel lifetime.

> > I really like the Debian way of forking a stable version and only doing
> > security or bugfixes. The problem is that this needs a lot of man power
> > and costs a lot of time. I know what I am talking about, because I did
> > all the 2.4 kernel backports of the Bluetooth subsystem.
> 
> A company would need to do this for the version they use in production
> systems only. So it should be possible.

Yes thats right, but from my point a specific company fork won't drive
the community forwards. This actually depends of course on how the
company talks back to us.

> > If we got a number of companies that help sponsoring the BlueZ itself
> > and its official qualification I can think of such a fork. At that point
> > it makes sense to me and is worth the extra work.
> 
> I didn't thought of you maintaining such a stable fork. But like in the
> debian project, the developers who need this high quality standard, care
> for the branch themselves. Then you need to assure only, that all fixes you
> apply are documented and published, even if you fix them with a new feature
> that doesn't go into the stable tree.

We use Bitkeeper for the kernel trees and CVS for the BlueZ library and
utils. I think everything like this is quite well documented.

However this is not the first time I talked about a fork. One year ago
or so when WideRay starts to qualify there BlueZ based product we also
talked about the qualifcation needs. It will be necessary to fork a
qualified version of BlueZ and you need someone who maintains it. This
must not me, but this is a fork that I will support. For other forks you
better should convince me that its worth ;)

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
