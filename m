Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Questions about BlueZ in  commercial use
From: Marcel Holtmann <marcel@holtmann.org>
To: KeiHachi <keihachi@swissinfo.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <002801c45dfb$c533d760$0364a8c0@haruo>
References: <003401c45c2b$b6eab240$0364a8c0@haruo>
	 <1088359746.3774.20.camel@pegasus>  <000c01c45d2c$ed2e5f80$0364a8c0@haruo>
	 <1088442828.6030.27.camel@pegasus>  <002801c45dfb$c533d760$0364a8c0@haruo>
Content-Type: text/plain
Message-Id: <1088530908.6030.310.camel@pegasus>
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
Date: Tue, 29 Jun 2004 19:41:49 +0200

Hi KeiHachi,

> # I wonder why the article I posted is always handled as another thread in the sourceforge archive.
> #But the article or reply from you or other people is handled in the same thread properly.
> #How should I reply to be handled in the same thread in the archive on the sourceforge site.??

in most cases this is a problem of a broken mailer. I use Evolution and
the only thing I do is hit the "Reply to All" button and write my
answer.

> > so what profiles do you wanna support on your PDA?
> 
> It isn't decided yet.
> But I think DUN, and GOEP related profiles(like OPP) are mandatory.

Everything that is based on RFCOMM or BNEP is absolutly unproblematic.

> And probably A2DP and AVRCP are required from the market needs strongly.

>>From my personal opinions I agree, but at the moment I don't really see
the market moving. Actually I don't know why.

> > > I expect that the transparent data as well as the voice data go through the HCI layer.
> > 
> > Mostly the PCM interface is easier to handle. What kind of host
> > transport layer are you planning to use? USB or UART?
> 
> I think UART will be use.

Then you should forget thinking about SCO over HCI. You will run into
UART bandwith problems when you have to support more than one profile at
one time. Best example is PAN + Headset/Handfree.

> > I will ask the open source audio experts, but I only wanna do that after
> > the AVDTP support is ready and usable.
> 
> I agree. Your opinion is right.
> 
> However I know AVDTP is harder to implement than other profiles,
> because I studied it before.

The problem is that they use multiple L2CAP connections with the same
PSM for different protocols. This is totally stupid, because you can
only differ between them on the order of their creation. However the
basic mode looks very simple. Right now it looks like that I will
support AVDTP as a sequential packet socket.

> > > we want to get a minimum of the service level agreement based on a contract at least.
> > 
> > I can't offer you anything like that at the moment, but if you are
> > really need this and you wanna pay for it, we can talk about it.
> 
> That's fine. I'm very glad at your comment.
> 
> But in this moment, I can't negotiate with you because I don't have such an authority.
> I'm sorry.
> 
> I will bring back to inform my boss and our team of this,
> then we will discuss what we should do.

No problem for me, because I don't like talking about theoretical stuff.
I prefer to talk about facts. If you know what you want, we can talk
about what is possible and what not. And I can help you with not driving
into a dead end.

> > you can always ask such a question. In general this is always possible,
> > but depending on my free time and the amount of money you wanna spend, I
> > will say yes or no.
> 
> Yes, of course. I fully understand.
> 
> I am still in a investigating phase now,
> we cannot negotiate about details until later.
> First we have to discuss in our team.

See above.

> > I forgot to put a smiley after my comment ;)
> 
> Oh, It doesn't matter. ; )
> Please forgive me if I make a rude comment or break unwritten rules like a comment witten without smiley.
> Because I am not westerner, I don't fully understand your Western culture.

No you didn't anything wrong. The smiley means for me that you should
take me comment too serious. In this case this applies to the Affix
stack, because I don't take this stack really serious.

> > This is what Nicholas and I defined as fork. I really intend to do this
> > if the BlueZ project got enough money for a qualification.
> 
> I understand. Thank you for your information.
> 
> 
> Again, I will input these informations to our team, then we will discuss what we should do in deeply.
> 
> Thanks a lot for your kindness.

You are welcome.

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
