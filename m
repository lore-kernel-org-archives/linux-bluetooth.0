Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: tOpSy TuRvY <topsyturvy@nemo.student.utwente.nl>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1087942444.4209.45.camel@pegasus>
Message-ID: <Pine.BSO.4.58.0406231319140.20827@nemo.student.utwente.nl>
References: <E1BcqIi-0002cT-53@sc8-sf-list2.sourceforge.net>
 <Pine.BSO.4.58.0406222046050.9882@nemo.student.utwente.nl>
 <1087939830.4209.12.camel@pegasus>  <Pine.BSO.4.58.0406222346200.5451@nemo.student.utwente.nl>
 <1087942444.4209.45.camel@pegasus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Bluez-users] Slaves in Sniff mode
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
Date: Wed, 23 Jun 2004 13:23:59 +0200 (CEST)

Hi,

Does anyone know if the master delays ACL transmittions to slaves in sniff 
mode (i.e. till they become active again), or will it just keep on 
transmitting the baseband frame till the slave eventually wakes up and can 
send an ACK.

Regards,
Assed



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
