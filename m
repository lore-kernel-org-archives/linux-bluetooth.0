Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] HCI Stops responding
Reply-To: axs203dd@excite.com
From: "mr" <axs203dd@excite.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <20041011125233.B209D3DD1@xprdmailfe11.nwk.excite.com>
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
Date: Mon, 11 Oct 2004 08:52:33 -0400 (EDT)


> What kernel do you use? Is the hci_usb driver compiled with SCO support?



I'm using 2.4.27 with bluetooth support compiled as modules. The hci_usb is compiled with SCO support.



The lsmod gives:



bnep                    8500   1

l2cap                  15952   2  [bnep]

hci_usb                 8504   1

bluez                  29092   3  [sco bnep l2cap hci_usb]

usbcore                61452   1  [usb-ohci hci_usb]

fealnx                 10288   2

mii                     2368   0  [fealnx]

crc32                   2848   0  [bnep fealnx]



I have tried bluez-libs & utils 2.7 and 2.10 (currently) as well.



Regards

Elias



_______________________________________________
Join Excite! - http://www.excite.com
The most personalized portal on the Web!


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
