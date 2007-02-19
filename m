Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <45D9E0ED.8090700@yahoo.com.au>
References: <45D9E0ED.8090700@yahoo.com.au>
Date: Mon, 19 Feb 2007 18:54:19 +0100
Message-Id: <1171907659.26567.29.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] hid2hci fails: broken pipe
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

Hi Mat,

> My Digitus DN-3008 arrived in the post today, so I tried it out.  I
> managed to get it to the same level of workingness as my DBT-120, i.e.,
> I can use my bluetooth mighty mouse with the thing, if I first run
> "hidd" manually.  The next step is to switch it into HID mode with
> hid2hci.  But this is failing with the error message:
> 
> aeon:~# hid2hci -1
> Switching device 0a12:0001 to HID mode failed (Broken pipe)
> 
> Can anyone suggest why this isn't working?  What pipe?  What's it
> talking to a pipe for in the first place?

it doesn't mean that it actually failed to switch the adapter. It might
have simply worked. The error messages from the USB subsystem are kinda
strange, but somehow expected since the device will disconnect from the
bus.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
