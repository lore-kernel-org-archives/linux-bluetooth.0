Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-Id: <200406231741.i5NHfnqF022172@news01.csr.com>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Slaves in Sniff mode 
In-reply-to: "tOpSy TuRvY"'s message of "Wed, 23 Jun 2004 19:15:28 +0200."
             <Pine.BSO.4.58.0406231904480.29930@nemo.student.utwente.nl>
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
Date: Wed, 23 Jun 2004 18:41:49 +0100

tOpSy TuRvY wrote:
> Assume that the communication is taking place between two PANUs (i.e. 
> slaves) in a PAN, where the destination PANU is in sniff mode. From your 
> answer, am I correct in concluding that:
> 
> a) The fact that the receiving PANU is in sniff mode is transparent to the 
> sender (except that the transfer rate will be lower and there may be some 
> delays)

Yes, there's no reason the sender would notice apart from the data in
small bursts.  (It's not like park mode where data isn't sent.)

> b) The queueing you mentioned will take place at the GN

So you're sending data PANU -> GN -> PANU?  If both links are in sniff,
the most likely place for data to queue up is at the sending PANU.  But
this is simply a question of available bandwidth, there's no specific
dependence on sniff.  You'd get the same thing if, say, the link quality
was very poor, or you were using one of our competitors' devices :-).

> One last question on this issue. Can the GN in Bluez ask the PANU to go 
> into sniff mode *automatically* based on some criteria (e.g. low 
> activity), or ask it to come out of sniff mode (e.g. based on a large 
> queue).

It would be up to the host code to do this.  There's nothing stopping
(say) the bnep layer from monitoring data and sending sniff and unsniff
requests.  There's no facility for doing this below HCI.

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
