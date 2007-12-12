Return-Path: <cyrus@holtmann.org>
Message-ID: <8c7950360712120508j3da5da11sf79e1c321cc37865@mail.gmail.com>
Date: Wed, 12 Dec 2007 08:08:16 -0500
From: "Shane Volpe" <shanevolpe@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-users] PAN security questions
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

PAND MAN file lists the following options regarding security:
--encrypt -E
    Enable encryption
--secure -S
    Secure connection

The PAND howto (http://bluez.sourceforge.net/contrib/HOWTO-PAN)
explains --encrypt as follows:
     "activates BT security (authentication and encryption)"

so then what does the option --secure do?

If you use --encrypt I'm assuming
During initialization the paraphrase is sent (via the passkey-agent)
unencrypted (authentication) and after a PAND connection is finally
made only then is the data encrypted is this correct?
Regards,
Shane

-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
