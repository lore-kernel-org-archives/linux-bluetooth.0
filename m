Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: tOpSy TuRvY <topsyturvy@nemo.student.utwente.nl>
To: Peter Stephenson <pws@csr.com>
cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Slaves in Sniff mode
In-Reply-To: <200406231606.i5NG6gLM017727@news01.csr.com>
Message-ID: <Pine.BSO.4.58.0406231904480.29930@nemo.student.utwente.nl>
References: <200406231606.i5NG6gLM017727@news01.csr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Wed, 23 Jun 2004 19:15:28 +0200 (CEST)

Hi Peter,

Assume that the communication is taking place between two PANUs (i.e. 
slaves) in a PAN, where the destination PANU is in sniff mode. From your 
answer, am I correct in concluding that:

a) The fact that the receiving PANU is in sniff mode is transparent to the 
sender (except that the transfer rate will be lower and there may be some 
delays)

b) The queueing you mentioned will take place at the GN

One last question on this issue. Can the GN in Bluez ask the PANU to go 
into sniff mode *automatically* based on some criteria (e.g. low 
activity), or ask it to come out of sniff mode (e.g. based on a large 
queue).


Regards,
Assed

On Wed, 23 Jun 2004, Peter Stephenson wrote:

> tOpSy TuRvY wrote:
> > Hi Marcel,
> > 
> > I'm wondering how the master can request an unsniff if the slave is not 
> > listening to the channel.
> > 
> > I suppose the master should delay transmission till the next sniff window 
> > starts (i.e. as Peter suggested). Of course I'm guessing that at this 
> > point it could request an unsniff if the packet to be transmitted will 
> > not fit the sniff window.
> 
> It's designed so that data in sniff is pretty much transparent --- this
> is what HID devices use to achieve low power consumption with low
> latency.  (If I made that sound easy, you can take my word for it it
> isn't, particularly with multiple devices :-/)
> 
> You can queue data for sending on the host just like normal.  You will
> simply find it arrives on the other side in globs.  The baseband
> fragments packets as necessary, so you don't have to worry about this at
> the L2CAP level or above.
> 
> If you need data to come across faster, you must issue
> HCI_exit_sniff_mode to the link.  You don't need to stop data while you
> do that, the link manager traffic will fit in automatically.
> 
> pws
> 
> 
> **********************************************************************
> This email and any files transmitted with it are confidential and
> intended solely for the use of the individual or entity to whom they
> are addressed. If you have received this email in error please notify
> the system manager.
> 
> This footnote also confirms that this email message has been swept by
> MIMEsweeper for the presence of computer viruses.
> 
> www.mimesweeper.com
> **********************************************************************
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email sponsored by Black Hat Briefings & Training.
> Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
> digital self defense, top technical experts, no vendor pitches, 
> unmatched networking opportunities. Visit www.blackhat.com
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
> 


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
