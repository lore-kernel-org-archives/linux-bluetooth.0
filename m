Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-Id: <200412011241.iB1CfPcE031100@news01.csr.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Test Mode 
In-reply-to: <2de4657604120104274918f56@mail.gmail.com> 
References: <2de4657604113010234e4e3a3f@mail.gmail.com> <1101882666.18840.23.camel@pegasus> <200412011028.iB1ASZIk030820@news01.csr.com> <2de4657604120104274918f56@mail.gmail.com>
From: Peter Stephenson <pws@csr.com>
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
Date: Wed, 01 Dec 2004 12:41:25 +0000

Manjunath Prabhu wrote:
> Thanks for the reply. What scenario should i be looking for inorder to
> set up these tests. Can I conduct the tests using my dongle as a slave
> and a  CATC or Frontline or a Mobiwave BT trainer/protocol analyser as
> the Master.  Will I be able to modify the baseband to suite my needs? 
> Do they have a provision for fusing new codes (something like a
> flash)??

If you mean implementation-specific tests, typically they will do simple
transmissions and bit error rate measurements and possibly not a lot
more.  You will either need two devices of the appropriate manufacturer,
or something like a signal generator; a Bluetooth sniffer isn't likely
to be good enough.  (You might have some luck with the trainer-capable
sniffers, but I don't have any experience of them.)  It's unlikely
you'll be able to modify the test modes in any substantial way.  You
won't be able to control them from Bluez without some hacking.

> I think i better write to the sales person from respective organisations....

Yes, indeed.  If you're determined to do this under Linux, you'd better
mention it; I don't think it's widely supported for test modes at the
moment.

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
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
