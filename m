Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <8c7950360709061306w39a081f1od1c372dafabc5072@mail.gmail.com>
References: <8c7950360709061306w39a081f1od1c372dafabc5072@mail.gmail.com>
Date: Mon, 10 Sep 2007 21:10:33 +0200
Message-Id: <1189451433.687.59.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] devices always connect with out asking for
	PIN	even with pairing enabled!
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

Hi Shane,

> I have two embedded Linux devices that I'm running a network between
> using PAN.  I have decided that I would like to enable pairing and
> eventually encryption for security reasons.  
> Here is what I have done I'm starting pand master with the following: 
> pand --listen --master --role  NAP
> and the slave with
> pand --connect 00:A0:96:18:69:D8 --persist
> were 00:A0:96:18:69:D8 is the masters address.
> 
> Below are the hci.conf files for both my master and slave device.. 

don't touch hcid.conf unless you know exactly what you are doing. Wild
guessing doesn't help here and if you mess it up then it is your fault.
I mentioned that multiple times, but people keep doing it anyway.

If you wanna have authentication and encryption, then read the manual
page of pand. It allows you to specify this for the server.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
