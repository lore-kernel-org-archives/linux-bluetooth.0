Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <541230EF1AD0482CBD0D62ABB835388C@iMe>
References: <541230EF1AD0482CBD0D62ABB835388C@iMe>
Date: Thu, 03 Jan 2008 21:02:51 +0100
Message-Id: <1199390571.26099.50.camel@aeonflux>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Rssi always 0x00
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

Hi,

> I know this is a BlueZ list.. but 
> a friend of mine asked me about a Bluetooth problem in a different
> stack he is developing.. his question was:

this means it doesn't belong here. It is for BlueZ only.

> Why RSSI returns 0x00 all the time? 
> - Setting inquiry mode to include rssi
> - the Bluetooth adapter returns INQUIRY_RESULT_WITH_RSSI but rssi
> value is always 0x00..
>  
>  he used 3 different Bluetooth adapter from different manufacturers
> and they all return the same thing.. 0x00 ..!

Don't think so since BlueZ works perfectly fine. I think his HCI
decoding is totally off.

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
