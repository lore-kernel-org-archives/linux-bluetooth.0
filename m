Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-Id: <200410190924.i9J9ObCI019724@news01.csr.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Various questions 
In-reply-to: <opsf3esskzeocfdv@debian> 
References: <opsf3esskzeocfdv@debian>
From: Peter Stephenson <pws@csr.com>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 19 Oct 2004 10:24:36 +0100

"Christoph Torens" wrote:
> At first, I believed ACL stands for 'Asynchronous Connection Less'
> But I just read the BT_Core_v1_2 Specification that sais ACL is
> Asynchronous Connection Oriented (page 118 of 1200 / Architecture page 42  
> of 82)
> So, what is it? I have read books and internet articles that said ACL is
> connection less. Are they all wrong or am I totally messing up something?

It's "connection-less", but I never heard anybody use the full form.
(It's a slightly odd meaning of "connection", since of course the
devices are connected.  It really means "without a reserved chunk of air
time".)

> PAN uses the bnep protocol layer. Is bnep based on rfcomm?

No, it's straight on top of L2CAP.

> What about the three error connection modes. Is it right that they are
> determined by packet type and so there is no way to turn it on / off ?
> (using pand for example / which paket types does pand use?)
> Because some papers speak about optionally error correction (ARQ)

I'm not quite sure what the question is, but I think you're asking if a
higher level profile such as PAN is affected by the details of what goes
over the air.  The answer is no, the baseband will use such packets as
it thinks are appropriate whatever ACL data it is transferring.  It
will, for example, pick packets with or without error correction (FEC,
not ARQ; the ARQ scheme is mandatory for acknowledgements) depending on
the quality of the radio link.

> Data rate:
> Whats the data rate of a pand connection?
> I measured a data rate of 60-65 kbyte/s one way
> 30-35 kbyte/s the other way.

It will vary depending on the devices, the connection to the host, and
the host stack.  There's nothing in principle to stop you getting up to
the full 721 kbps.  The device will adapt to the presence of data in
both directions, limiting you to 433 kbps if the channel is full both
ways.

pws


**********************************************************************
This email and any files transmitted with it are confidential and
intended solely for the use of the individual or entity to whom they
are addressed. If you have received this email in error please notify
the system manager.

This footnote also confirms that this email message has been swept by
MIMEsweeper for the presence of computer viruses.

www.mimesweeper.com
**********************************************************************



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
