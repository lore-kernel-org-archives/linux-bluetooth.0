Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200612181412.12059.fernando@bluexare.org>
References: <200612181412.12059.fernando@bluexare.org>
Date: Tue, 19 Dec 2006 10:48:47 +0100
Message-Id: <1166521727.29972.15.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] About the process that listen...
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Fernando,

> I'm a developper from other project that works with Bluetooth.
> We are making a software that can send datas to other devices, like mobiles.
> 
> But sometimes, our device does not detect the mobile, what it means, the sent
> is not realized.
> 
> And we want to do the possibility taht each mobile, by requesting the device
> the information, it sends.
> 
> We don't know which process works listening the transmissions from other
> devices...
> 
> If the mobile try to associate the device, what does daemon treat that?
> And if the mobile try t send an mage (for example), is another daemon who
> treat this?
> 
> I hope you understand me.
> 
> What we want is when our device detect an incoming transmission (a try to
> associate, or to send an image...) from one mobile, it sends what we have
> prepared to be send.

I think that I have a small idea on what you are trying to achieve.
However you might have no idea on how Bluetooth actually works. This is
not WiFi and things are different. You should get yourself a book about
Bluetooth and understand how it works and then play with tools like
l2test and rctest from the bluez-utils package. And of course have
"hcidump -X -V" running all the time so you see what actually happens.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
