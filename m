Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Wed, 6 Dec 2006 13:17:54 -0200
From: Cris <ml133@netpole.com.br>
To: bluez-devel@lists.sourceforge.net
Message-Id: <20061206131754.39cddee0.ml133@netpole.com.br>
In-Reply-To: <1165412385.2756.52.camel@localhost>
References: <20061206111617.d8f16a0c.ml133@netpole.com.br>
	<1165412385.2756.52.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] suggestion for device control
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

On Wed, 06 Dec 2006 14:39:45 +0100
Marcel Holtmann <marcel@holtmann.org> wrote:

> you can tell the kernel to switch a HCI device into raw mode and after
> that point you have full control over that device.

I am opening the devices in raw mode, but nevertheless I capture
reconfiguration commands from the kernel at connection time. I didn't
yet reach the point to be able to tell how much the kernel actually
interfers, but it does act at connection configuration time and
l2cap/rfcomm do kick in on raw sockets. I even tried to unload the
l2cap/rfcomm kernel modules, but they get reloaded at some point. Is
there something else I have to switch off? (I did stop the bluetooth
daemons like hcid, sdpd, rfcommd).

Hm. With raw, you do mean:

  socket (AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);

right? or is there something else I need to set to raw?

Thanks,

-- 
Cris

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
