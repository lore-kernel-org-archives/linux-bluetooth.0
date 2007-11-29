Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <d89ddf300711291206g56544e3cud237a2f71355fc93@mail.gmail.com>
Date: Thu, 29 Nov 2007 13:06:42 -0700
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <d89ddf300711290845l5162bca2l16dfdf6c902cfa92@mail.gmail.com>
MIME-Version: 1.0
References: <20070522161255.GA9813@robsims.com>
	<20071129155526.GA17661@robsims.com>
	<d89ddf300711290845l5162bca2l16dfdf6c902cfa92@mail.gmail.com>
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

Rob,

fwiw, the only thing I could find would work only for csr chips using
bccmd from bluez-utils/tools (configure --enable-bccmd). Get the
bdaddr to see how the bytes are swapped around:

bccmd psget bdaddr

then set and reset the adapter (sometimes these commands take two goes to take)

bccmd psset -r bdaddr 0x2000 0xaf9b 0xf400 0x0800

I could give this a whack tonight.

fyi, bccmd can brick the adapter (eg if you use "-s" to make bad
settings permanent). It would be nice if someone who fiddles with csr
stuff can verify this approach.

Brad

-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
