Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-Id: <200406231206.i5NC6NrA007514@news01.csr.com>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Slaves in Sniff mode 
In-reply-to: "tOpSy TuRvY"'s message of "Wed, 23 Jun 2004 13:23:59 +0200."
             <Pine.BSO.4.58.0406231319140.20827@nemo.student.utwente.nl>
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
Date: Wed, 23 Jun 2004 13:06:22 +0100

tOpSy TuRvY wrote:
> Does anyone know if the master delays ACL transmittions to slaves in sniff 
> mode (i.e. till they become active again), or will it just keep on 
> transmitting the baseband frame till the slave eventually wakes up and can 
> send an ACK.

It should transmit any data during the sniff window.  The rules there
are identical to those in active mode, although obviously you will
get very much reduced throughput.

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
