Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] pand + socket filtering on zaurus
From: Marcel Holtmann <marcel@holtmann.org>
To: Kutschenreuter Matthias <Matthias.Kutschenreuter@siemens.com>
Cc: Stephen Crane <steve.crane@rococosoft.com>,
   "'Bluez-devel@lists.sourceforge.net'" <Bluez-devel@lists.sourceforge.net>
In-Reply-To: <AFE91B59A185A5439840B43AB7919047093989@mchp997a.mch.sbs.de>
References: <AFE91B59A185A5439840B43AB7919047093989@mchp997a.mch.sbs.de>
Content-Type: text/plain
Message-Id: <1086276720.7542.180.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 03 Jun 2004 17:32:00 +0200

Hi Matthias,

> OK, I got the ROM 3.10 and installed the latest bluez-2.4.18...ipk
> sucessfully. Then, I do NOT enter a BT CF Card, which I assume would wrok
> perfectly, but I connect a BT Chip using a serial cable instead. 
> # modprobe l2cap
> # modprobe hci_uart
> # hciattach /dev/ttyS0 any 115200 flow
> fails ---->  "Can't set device: Protocol not support"
> no matter whether I am using the hciattach kindly sended 
> by Steve or the one that I cross compiled myself, the answer is always the
> same. 

this problem occurs when hciattach will set the device mode (H4 or BCSP)
and I suspect your hci_uart is very old. In the beginning there was no
switch needed, but it also only supported H4. Maybe it is enough to
erase the ioctl(HCIUARTSETPROTO), but using a too old BlueZ stack is not
a good idea.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
