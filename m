Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluettoth problems
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <001d01c56612$7884c9e0$2203a8c0@campos>
References: <001d01c56612$7884c9e0$2203a8c0@campos>
Content-Type: text/plain
Message-Id: <1117564813.7072.241.camel@pegasus>
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
Date: Tue, 31 May 2005 20:40:13 +0200

Hi Bruno,

> I have a IPAQ 5500, with familiar 0.7.2, + bluez, but i have a problem
> with bueltooth, when i try:
> pand -D --connect 00:09:DD:10:44:84 --role PANU --service GN --persist
> I can do ping on my PDA(169.254.10.119) to PC(169.254.10.117), and
> ping on my PC to PDA, and it works fine, but after a few minuts, the
> connection going down, and i can't ping again. So, i don't know what
> it is. If i try tunr off the bluetooth an turn on again, the
> connection going up again but after a few minuts going down. So anyone
> knows what problem is??
>  
> When i do : hcidump:
> .
> .
> .
> > HCI Event: Hardware Error(0x10) plen 1

search the mailing list archives for the HCI hardware error in
conjunction with the iPAQ 5500.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
