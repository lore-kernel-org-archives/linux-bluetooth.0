Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: soraberri <421246@posta.unizar.es>
Message-ID: <cqunik$ule$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] rctest[3790]: Can't set L2CAP link mode
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 29 Dec 2004 17:55:13 +0100

This is part of my lsmod output:

[soraberri@castejon temp]$ lsmod
Module                  Size  Used by
hci_usb                15041  3
rfcomm                 36701  2
l2cap                  25285  7 rfcomm
bluetooth              46917  11 hci_usb,rfcomm,l2cap

sdpd and hcid are running

I think all the important stuff is there, and then why am I getting the 
following error?

[soraberri@castejon temp]$rctest -r
rctest[3790]: Can't set L2CAP link mode. Protocol not available(92)

Well it seems that the error is born within the call to
setsockopt(s, SOL_RFCOMM, RFCOMM_LM, &opt, sizeof(opt))
in rctest.c

If you could give me a clue, pleease..

thanks for your time.



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
