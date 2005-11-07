Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <436F5B5C.7070506@csr.com>
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Periodic noise on microphone with bt_sco (BTA-6030
 Dongle, Motorola H500 Headset)
References: <436F1C3B.5020002@web.de> <436F4D85.4030404@csr.com> <436F5602.1040105@web.de>
In-Reply-To: <436F5602.1040105@web.de>
Content-Type: text/plain; charset=us-ascii
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
Date: Mon, 07 Nov 2005 13:49:16 +0000

Dirk Stockmann wrote:
> But when the headset is connected to my Mobile Phone there is no noise,
> so it is unlikely that it is related to the headset itself. 

I agree with this diagnostic. If the headset doesn't generate noise
when attached to another device then the noise is probably not being
inserted at the headset end.

>                                                             And I always
> thought (maybe wrong?) that the processing inside of the PC is pure
> digital. So there should be no noise on a recorded file. Besides from
> that my PC has a very good audio system with no noise at all.

Hmmm, the signal from the dongle to the PC should be digital, as should
the signal from the PC to the audio card. All the processing inside the
dongle should be digital too. The only analogue stage should be from the
audio card to the speakers.

One way to confirm whether it's electrical is to record digital signal
received from the dongle into a file, shut down the SCO link and then
play the file to the PC's loudspeakers.

Are you sending a signal to the headset and, if so, are you hearing a
buzz in the headset's speaker? I'm wondering if a buzz in that
direction (coming from the sensitive microphone input on the PC) is
being looped through the air (or through the plastic) from the
headset's speaker to its microphone.

	- Steven
-- 


This message has been scanned for viruses by BlackSpider MailControl - www.blackspider.com


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
