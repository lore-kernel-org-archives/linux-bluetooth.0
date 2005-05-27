Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <429682D6.2020800@gmail.com>
From: David Britton <davidpbritton@gmail.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Early failures with Treo 650
References: <428EDFCA.5070702@gmail.com> <1116842776.30044.33.camel@pegasus>	 <4292938B.2090000@gmail.com> <1116924491.30044.131.camel@pegasus>	 <429553F1.7020604@gmail.com> <1117095364.12036.14.camel@pegasus>
In-Reply-To: <1117095364.12036.14.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-1
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
Date: Thu, 26 May 2005 21:15:50 -0500

Marcel Holtmann wrote:
> Hi David,
> 
> 
>>>what kind of USB dongle is this?
>>
>>The USB dongle is a "Kensington Bluetooth USB Adapter".
> 
> 
> be a little bit more specific.

I would have been more specific, the only other distinguishing thing on
it is the model number:

Kensington Bluetooth USB Adapter
Model #33085

Here is the product info page:
http://www.kensington.com/html/6397.html

> 
> So here we go. You can first try to load the hci_usb module with the
> reset=1 parameter, but I doubt that it helps for this dongle. What you
> need will be the attached patch to switch it from HID into HCI mode.

Excellent!  The patch did it (after also loading with the reset=1).  I'm
now on my way trying to set up a PPP connection.   Thanks a lot for the
curteous help Marcel.


-- 
David Britton <davidpbritton@gmail.com>


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
