Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Apple bluetooth mouse
From: Marcel Holtmann <marcel@holtmann.org>
To: Elimar Riesebieter <riesebie@lxtec.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>,
   debian-powerpc <debian-powerpc@lists.debian.org>
In-Reply-To: <20031230205918.GA946@samweis.home.lxtec.de>
References: <20031228012502.GA16798@samweis.home.lxtec.de>
	 <20031228170349.GA1460@samweis.home.lxtec.de> <m3fzf47oa3.fsf@neo.loria>
	 <20031230182456.GA3035@samweis.home.lxtec.de>
	 <1072813766.2542.28.camel@pegasus>
	 <20031230205918.GA946@samweis.home.lxtec.de>
Content-Type: text/plain
Message-Id: <1072818406.2542.33.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 30 Dec 2003 22:06:46 +0100

Hi Elimar,

> Neither OHCI nor EHCI was enabled in my kernel. Changed that and the
> mouse works like a charm at console and X ;-)
> 
> Thank you for that hint!
> 
> But anyway: hcitool inq like shown at
> http://www.holtmann.org/linux/bluetooth/hid.html tells:
> Inquiring ...
> Inquiry failed.: No such device

	T:  Bus=02 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
	D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
	P:  Vendor=05ac ProdID=1000 Rev= 9.01
	C:* #Ifs= 2 Cfg#= 1 Atr=c0 MxPwr=100mA
	I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=01 Driver=hid
	E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
	I:  If#= 1 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=02 Driver=hid
	E:  Ad=82(I) Atr=03(Int.) MxPS=  16 Ivl=1ms

this looks like a Bluetooth HID proxy device from CSR. You can use the
hid2hci program to switch it into HCI mode. However it seems that Apple
is using its own vendor id, so you must change this in the source code.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
