Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] sdptool - File descriptor in bad state
From: Marcel Holtmann <marcel@holtmann.org>
To: Chris <usenet@chrissearle.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <lgpt7a931l.fsf@montgomery.empolis.no>
References: <lgpt7a931l.fsf@montgomery.empolis.no>
Content-Type: text/plain
Message-Id: <1089110981.4504.145.camel@pegasus>
Mime-Version: 1.0
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
Date: Tue, 06 Jul 2004 12:49:41 +0200

Hi Chris,

> Getting the following error when trying to use sdptool:
> 
> sdptool browse
> Inquiring ...
> Failed to connect to SDP server on <mybdaddr>: File descriptor in bad state

it is "sdptool browse <mybdaddr>".

If this doesn't fix it, run "hcidump -x" as root and show us the output.

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
