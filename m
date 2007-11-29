Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-Id: <81AD8A6B-9825-4641-951F-FEE9A0DE20C4@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <d89ddf300711291206g56544e3cud237a2f71355fc93@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v915)
Date: Thu, 29 Nov 2007 21:15:23 +0100
References: <20070522161255.GA9813@robsims.com>
	<20071129155526.GA17661@robsims.com>
	<d89ddf300711290845l5162bca2l16dfdf6c902cfa92@mail.gmail.com>
	<d89ddf300711291206g56544e3cud237a2f71355fc93@mail.gmail.com>
Subject: Re: [Bluez-users] Sharing devices with dual-booted Windows
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

Hi Brad,

> fwiw, the only thing I could find would work only for csr chips using
> bccmd from bluez-utils/tools (configure --enable-bccmd). Get the
> bdaddr to see how the bytes are swapped around:
>
> bccmd psget bdaddr
>
> then set and reset the adapter (sometimes these commands take two  
> goes to take)
>
> bccmd psset -r bdaddr 0x2000 0xaf9b 0xf400 0x0800
>
> I could give this a whack tonight.

using the bdaddr command is much simpler. It does the magic of  
bringing the address into the right format.

> fyi, bccmd can brick the adapter (eg if you use "-s" to make bad
> settings permanent). It would be nice if someone who fiddles with csr
> stuff can verify this approach.

Take this warning serious. You can really brick your dongle.

Regards

Marcel


-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
