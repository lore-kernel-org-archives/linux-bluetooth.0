Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] BlueZ w/ XP SP2-RC2
From: Marcel Holtmann <marcel@holtmann.org>
To: "Pering, Trevor" <trevor.pering@intel.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <EFCD68F7BFDB06468769D4D9EAAA938703C14132@scsmsx401.amr.corp.intel.com>
References: 
	 <EFCD68F7BFDB06468769D4D9EAAA938703C14132@scsmsx401.amr.corp.intel.com>
Content-Type: text/plain
Message-Id: <1089662401.4644.73.camel@pegasus>
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
Date: Mon, 12 Jul 2004 22:00:02 +0200

Hi Trevor,

> we are trying to get a Linux Bluez device to work with Windows XP
> Service Pack 2 Release Candidate 2, which includes Bluetooth support.
> Windows can't "see" the device when I try to "Join a Personal Area
> Network".  My device presents as Major Class 1 (Computer) and Minor
> Class 1 (Desktop workstation), and I have tried with and without
> advertising the Networking Service class (bit 17).  It advertises PAND
> as GN in SDP and works fine with other software.  With other CoD values
> the device has been seen as a Bluetooth device, but not as a valid PAN
> partner.

run "hcidump -x" as root on the Linux box and see if Windows XP tries to
connect to the BlueZ SDP service and for what service it is searching.
If you don't see anything then the only problem is the CoD and I can't
really tell you what it expects.

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
