Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: Re: [Bluez-users] hci problems
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <E1DYwg6-0007LC-NP@sc8-sf-mx2.sourceforge.net>
References: <E1DYwg6-0007LC-NP@sc8-sf-mx2.sourceforge.net>
Content-Type: text/plain
Message-Id: <1116581686.8970.5.camel@pegasus>
Mime-Version: 1.0
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
Date: Fri, 20 May 2005 11:34:46 +0200

Hi,

> >> Here , I want to do the following work : one bluetooth device send the inquiry command (using the hci_inquiry function) and the bluetooth devices who are inquiried of course will return corresponding packets , but how can I know the event that the device is inquiried upon the HCI layer ? Because I have to do some work only if the device is inquired .
> >
> >this is not possible.
> I have no idea to continue my work without such function ,could you please kindly provide me some alternative methods ?

there exists no alternate method. This stuff is all handled inside the
baseband and link manager. HCI interaction is not needed.

You need to page (connect) a remote device to make the host stack aware
of that something happens.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
