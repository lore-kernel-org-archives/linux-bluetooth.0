Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] MS keyboard and mouse problem
From: Marcel Holtmann <marcel@holtmann.org>
To: cijoml@volny.cz
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200310272120.08176.cijoml@volny.cz>
References: <200310271958.55594.cijoml@volny.cz>
	<1067284808.24042.6.camel@pegasus>  <200310272120.08176.cijoml@volny.cz>
Content-Type: text/plain
Message-Id: <1067287076.24041.26.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: 27 Oct 2003 21:37:50 +0100

Hi Michal,

> YES! That helped! And now please tell me where and how could I download
> your HID implementation.
> 
> I don't want use bthid when official HID exists for BlueZ..is somewhere any 
> howto too for this implementation?

start using the code from Peter, because my code is far from ready for
mainstream use. The userspace part is mostly finished, but it depends on
a kernel HID parser. My basic intention was to reuse the USB HID parser
for Bluetooth, but at the moment the hid.o kernel module is hardly bound
to the USB subsystem. I thought it was easier to seperate it from the
USB transport layer, but now I know that it takes longer as expected.

My modification of the USB HID parser will result in a general access to
the HID parser from userspace. I will post a design document when I get
some more time to write my stuff down. Keep a look a my page for new
information.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
