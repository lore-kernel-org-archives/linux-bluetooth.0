Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <000d01c45ebe$72d6e660$0264a8c0@haruo>
From: "KeiHachi" <keihachi@swissinfo.org>
To: "BlueZ Mailing List" <bluez-devel@lists.sourceforge.net>
References: <003401c45c2b$b6eab240$0364a8c0@haruo> <1088359746.3774.20.camel@pegasus>  <000c01c45d2c$ed2e5f80$0364a8c0@haruo> <1088442828.6030.27.camel@pegasus>  <002801c45dfb$c533d760$0364a8c0@haruo> <1088530908.6030.310.camel@pegasus>
Subject: Re: [Bluez-devel] Questions about BlueZ in  commercial use
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
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
Date: Thu, 1 Jul 2004 01:22:29 +0900

Hi, Marcel

> in most cases this is a problem of a broken mailer. I use Evolution and
> the only thing I do is hit the "Reply to All" button and write my
> answer.

Thank you.
I use OutLook Express made by Microsoft.
I reply by "Reply to All" functionality, too.
But in my case, the reply is handled as another thread.
It is strange... But I will forget it. Thank you.


> The problem is that they use multiple L2CAP connections with the same
> PSM for different protocols. This is totally stupid, because you can
> only differ between them on the order of their creation. However the
> basic mode looks very simple. Right now it looks like that I will
> support AVDTP as a sequential packet socket.

Probably it can be realized as a socket.
But some functionalities, like a SEP concept, should be considered in deeply.


> No problem for me, because I don't like talking about theoretical stuff.
> I prefer to talk about facts. If you know what you want, we can talk
> about what is possible and what not. And I can help you with not driving
> into a dead end.

Thank you, availing of your kind offer, I have one more question.

I know the product that uses BlueZ in it, as I found it on the BlueZ site before.
http://www.bluez.org/qualification.html

In that case, how did you or other guys help them to qualify?
For example, did that company paid some fee, or donation?
Were you or other guys under obligation to help them based on a contract?

Of course if you have the obligation to keep its secrets, it is OK to say nothing.


> No you didn't anything wrong. The smiley means for me that you should
> take me comment too serious. In this case this applies to the Affix
> stack, because I don't take this stack really serious.

Yes, of course I had understood your intention then.
Thank you for your concern again.

Regards,
KeiHachi.






-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
