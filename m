Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Questions about BlueZ in  commercial use
From: Marcel Holtmann <marcel@holtmann.org>
To: KeiHachi <keihachi@swissinfo.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <000d01c45ebe$72d6e660$0264a8c0@haruo>
References: <003401c45c2b$b6eab240$0364a8c0@haruo>
	 <1088359746.3774.20.camel@pegasus>  <000c01c45d2c$ed2e5f80$0364a8c0@haruo>
	 <1088442828.6030.27.camel@pegasus>  <002801c45dfb$c533d760$0364a8c0@haruo>
	 <1088530908.6030.310.camel@pegasus>  <000d01c45ebe$72d6e660$0264a8c0@haruo>
Content-Type: text/plain
Message-Id: <1088619095.4540.126.camel@pegasus>
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
Date: Wed, 30 Jun 2004 20:11:35 +0200

Hi KeiHachi,

> > The problem is that they use multiple L2CAP connections with the same
> > PSM for different protocols. This is totally stupid, because you can
> > only differ between them on the order of their creation. However the
> > basic mode looks very simple. Right now it looks like that I will
> > support AVDTP as a sequential packet socket.
> 
> Probably it can be realized as a socket.
> But some functionalities, like a SEP concept, should be considered in deeply.

I already did that and in the fact of SEP it is nothing different from a
PSM or RFCOMM channel. Actually because of this I thought that a socket
based implementation is the best. Along time I prefered to keep AVDTP in
userspace. However the only difficult part is the discover, because if
you don't know the SEP you must use it to find the available ones and
this includes a L2CAP connection. I must see how this gets integrated in
a nice way.

> > No problem for me, because I don't like talking about theoretical stuff.
> > I prefer to talk about facts. If you know what you want, we can talk
> > about what is possible and what not. And I can help you with not driving
> > into a dead end.
> 
> Thank you, availing of your kind offer, I have one more question.
> 
> I know the product that uses BlueZ in it, as I found it on the BlueZ site before.
> http://www.bluez.org/qualification.html
> 
> In that case, how did you or other guys help them to qualify?
> For example, did that company paid some fee, or donation?
> Were you or other guys under obligation to help them based on a contract?
> 
> Of course if you have the obligation to keep its secrets, it is OK to say nothing.

There is no secret about it. Parts of the communication can be found in
the mailing list archive. The rest was not in public, but actually only
by accident.

What we had done was to fix the L2CAP and RFCOMM protocol layers and
extend the test programs to pass the qualification tests.

There was no contract and they didn't paid us.

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
