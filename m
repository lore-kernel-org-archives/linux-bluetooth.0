Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <436F95A4.20902@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
References: <436F1C3B.5020002@web.de> <436F4D85.4030404@csr.com>	 <436F5602.1040105@web.de> <436F5B5C.7070506@csr.com>	 <436F608D.4020407@web.de>  <436F6FEA.4030207@csr.com> <1131376874.5824.127.camel@blade>
In-Reply-To: <1131376874.5824.127.camel@blade>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Bluez-users] Periodic noise on microphone with bt_sco	(BTA-6030
 Dongle, Motorola H500 Headset)
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
Date: Mon, 07 Nov 2005 10:57:56 -0700

Hi

>>In theory, if you use hcidump and extract all the SCO data, you should
>>just have raw samples which you can stitch together into a file.
>>
>>You should be able to see the two directions independently and see
>>where the noise is being introduced.
>>
>>I don't know if there's a speific tool, but use hcidump -w

what about capturing audio using scotest in the bluez cvs (utils/test)?
That would help us find out if we are doing something wrong in our driver.

Brad


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
