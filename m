Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Chris Searle <usenet@chrissearle.org>
Message-ID: <87acxo48c4.fsf@alice.chrissearle.org>
References: <lgk6wvgqax.fsf@montgomery.empolis.no>
	<1090572097.21828.53.camel@pegasus>
	<lg8ydbgliv.fsf@montgomery.empolis.no>
	<1090572685.21828.58.camel@pegasus>
	<lg4qnzgkuz.fsf@montgomery.empolis.no>
	<1090573758.4791.1.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] Re: hcid config
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
Date: Sun, 25 Jul 2004 13:47:23 +0200

>>>>> "Marcel" == Marcel Holtmann <marcel@holtmann.org> writes:

    Marcel> these devices are not brought up by hcid. Activate
    Marcel> "autoinit" in hcid.conf and restart the hcid.

Still not getting any further. autoinit is already yes in the config
file (see other post).

Some more info: on hcitool inq that both devices are reporting class
0x000000.

Manually restarting hcid makes no difference (same result as using the
/etc/init.d script). Stopping all other bluez things (sdp, dund etc)
then just starting hcid - no change.

Not sure how to follow this further.

-- 
Chris Searle



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
