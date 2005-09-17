Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: "Heike C. Zimmerer" <nospam05q2@gmx.net>
Message-ID: <dgh60h$qaq$1@sea.gmane.org>
References: <dgfhr3$nrc$2@sea.gmane.org>
	<20050917120141.GA5231@uni-duesseldorf.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] Re: Conceptronic 200M (CBT200U V2.0)
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
Date: Sat, 17 Sep 2005 15:28:10 +0200

Andreas Beck <becka-bzus@bedatec.de> writes:

> "Heike C. Zimmerer" <nospam05q2@gmx.net> wrote:
>> Recently, I've bought a Conceptronic 200M BT dongle, which, as far as
>> I have learned, is also known as CBT100U V.2 USB.

JFTR: This should read "CBT100U V1.2 USB".  And to complete confusion,
a small printing on the dongle reads "CBT100U V2.0".  Anyway,

> This is probably related to the chipset: If "hciconfig hci0 revision"
> doesn't say "SCO mapping:  HCI", you are probably out of luck with this
> Chipset.

it doesn't report any SCO mapping and lsusb reports "Broadcom Corp"
and "BCM2034", so I'm probably really out of luck.

Maybe this is worth a note on the compatibility list since this model
is mentioned there as working which isn't true any more.


Greetings,

Heike



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
