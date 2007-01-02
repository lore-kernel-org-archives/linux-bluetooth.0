Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <57c68ddc0701020446y3a7e70edh74f6ea5e0b05d07f@mail.gmail.com>
References: <57c68ddc0701012354u4137d1d3s93b28cafaa53f849@mail.gmail.com>
	<1167725398.30886.32.camel@violet>
	<57c68ddc0701020016y29fafa8duf77494bb50ac6d75@mail.gmail.com>
	<20070102081813.6a264b0e.ml133@netpole.com.br>
	<57c68ddc0701020229w6ddfaab3yf989a8e3999cbd1@mail.gmail.com>
	<20070102094414.f7b9cef1.ml133@netpole.com.br>
	<57c68ddc0701020446y3a7e70edh74f6ea5e0b05d07f@mail.gmail.com>
Date: Tue, 02 Jan 2007 14:04:29 +0100
Message-Id: <1167743069.30886.54.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] problem in making multiple connections
	using	single bluetooth adapter using bluez
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi,

>     With linux being one of the major players in embedded domain and
> bluez being an official protocol of linux there is definitely a great
> need for multi connection support. You have suggested that somebody
> with a thorough understanding of bluetooth and its protocol should
> start to fork the full development of bluetooth support in linux , but
> that somebody cannot be at least me at this instance as i am just a
> starter and it took some effort from my side to even get the idea of
> what u wrote ... i think it should be someone like you who has such a
> clear picture of the problem or to be more precise really understands
> the problem well , who can initiate such development... all i can say
> is that i am ready to work if somebody  can guide me .... 

please don't blindly believe everything that is posted on the mailing
list. You don't even have to believe me. BlueZ is fully multi adapter
and multi connection capable. However you need also a chip that supports
it and in some cases even a host stack on the other side that works
correctly. And once again "hcidump -X -V" is your friend in showing what
actually happens on the Bluetooth chip level.

> Please tell me what are the other options parallel to bluez and is it
> really advisable to  use them .

There is no real alternative, but please be my guest and write something
new. At some point you will realize that developing a Bluetooth host
stack is not much fun anymore.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
