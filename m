Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-Id: <200406231606.i5NG6gLM017727@news01.csr.com>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Slaves in Sniff mode 
In-reply-to: "tOpSy TuRvY"'s message of "Wed, 23 Jun 2004 14:58:32 +0200."
             <Pine.BSO.4.58.0406231451130.835@nemo.student.utwente.nl>
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
Date: Wed, 23 Jun 2004 17:06:41 +0100

tOpSy TuRvY wrote:
> Hi Marcel,
> 
> I'm wondering how the master can request an unsniff if the slave is not 
> listening to the channel.
> 
> I suppose the master should delay transmission till the next sniff window 
> starts (i.e. as Peter suggested). Of course I'm guessing that at this 
> point it could request an unsniff if the packet to be transmitted will 
> not fit the sniff window.

It's designed so that data in sniff is pretty much transparent --- this
is what HID devices use to achieve low power consumption with low
latency.  (If I made that sound easy, you can take my word for it it
isn't, particularly with multiple devices :-/)

You can queue data for sending on the host just like normal.  You will
simply find it arrives on the other side in globs.  The baseband
fragments packets as necessary, so you don't have to worry about this at
the L2CAP level or above.

If you need data to come across faster, you must issue
HCI_exit_sniff_mode to the link.  You don't need to stop data while you
do that, the link manager traffic will fit in automatically.

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
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
