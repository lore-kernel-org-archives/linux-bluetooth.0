Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-Id: <200406241009.i5OA9wFo030305@news01.csr.com>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Slaves in Sniff mode 
In-reply-to: "tOpSy TuRvY"'s message of "Thu, 24 Jun 2004 11:43:26 +0200."
             <Pine.BSO.4.58.0406241134240.10334@nemo.student.utwente.nl>
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
Date: Thu, 24 Jun 2004 11:09:57 +0100

tOpSy TuRvY wrote:
> Isn't it technically possible for the  master to send small amount of 
> BNEP data to PANUs in parked mode using the PSB logical channel? The 
> PANU would of course have to shift into connected mode before replying.
> 
> The above would allow the system to support a BNEP layer broadcast (e.g. 
> ARP) to all PANUs attached to the GN (i.e those in connected and parked mode)
> .

Broadcasts are allowed to parked slaves, so it's possible to do that
without unparking.  However, this is only possible master to slave and
(while I don't know much about the intervening layers) the notion of an
aysmmetric link isn't very natural at the networking layer, so you would
have to define the occasions when this would occur quite carefully.

For anything else, you would have to unpark the slave.
The spec allows the link manager to do this autonomously if data
arrives, but you can't rely on that (I don't know of anyone who does it,
offhand, but I haven't particularly looked), so the host has to be
prepared to do the unparking.

> > > One last question on this issue. Can the GN in Bluez ask the PANU to go 
> > > into sniff mode *automatically* based on some criteria (e.g. low 
> > > activity), or ask it to come out of sniff mode (e.g. based on a large 
> > > queue).
> > 
> > It would be up to the host code to do this.  There's nothing stopping
> > (say) the bnep layer from monitoring data and sending sniff and unsniff
> > requests.  There's no facility for doing this below HCI.
> > 
> 
> Isn't it better for e.g. the link manager to do this since the BNEP layer 
> can only see BNEP traffic, but the link manager can also see SCO and ACL 
> traffic.

This is why Marcel mentioned the HCI layer --- it sees all the data and
can tell the device to enter or leave sniff.  This is probably the best
bet.  There's no real gain that I can see in forcing it below HCI.
(At the last count our chip had roughly four orders of magnitude less RAM
than the average new PC.  That's why you can get dongles for $15.)

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
