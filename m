Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Chris Searle <usenet@chrissearle.org>
Message-ID: <lg8ydbgliv.fsf@montgomery.empolis.no>
References: <lgk6wvgqax.fsf@montgomery.empolis.no>
	<1090572097.21828.53.camel@pegasus>
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
Date: Fri, 23 Jul 2004 10:44:56 +0200

>>>>> "Marcel" == Marcel Holtmann <marcel@holtmann.org> writes:

    Marcel> Hi Chris,

    Marcel> check if you have hcid running as root.

chris@chris:~$ ps aux | grep hci
root      3810  0.0  0.1  1896  796 ?        Ss   08:35   0:00 hcid: processing events

It's started up from /etc/init.d/bluez-utils script under boot.

Regards

-- 
Chris



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
