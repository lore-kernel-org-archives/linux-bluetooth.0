Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: BlueZ mailing list <bluez-devel@lists.sourceforge.net>
Message-ID: <20040622171857.GA8829@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Subject: [Bluez-devel] Re: inquiry scan mode and page scan mode questions
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
Date: Tue, 22 Jun 2004 10:18:57 -0700

Albert Huang wrote :
> 
> My immediate goal is to understand why 10.24 s is the recommended
> duration for an inquiry, and to see if it's possible to decrease the
> average time to discover a bluetooth device.

	Ha, ha ! Inquiry is one of the greatest pain of
BlueTooth. Everybody wants to decrease this time, but unfortunately
there is not much wiggle room.
	One of the idea is that if you do periodic inquiry, it would
be nice to do shorter Inquiry more often so as not to degrade your
latency. Not possible.

	I don't want to go into details, but just to give you general
pointers.
	The killer is the backoff, in 10.7.4 it specifies that the
node doing Inquiry scan has to wait between 0 and 1023 slots before
sending an Inquiry response.
	Then, you have interference, collision, time shift and all
kind of nastiness over the channel. If the Inquiry and Inquiry scan
happen to be on the same frequency at the same time, it's not
guaranteed to go through.

	In practical term, a one-shot Inquiry need to be 6.4 s to have
a good probability of detection at close range. If you do periodic
Inquiry, you can go down to 3.84 s, but expect a few periods before
the node is discovered. Those are from one of my unpublished paper.

	Have fun...

	Jean



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
