Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] pand + socket filtering on zaurus
From: Marcel Holtmann <marcel@holtmann.org>
To: Kutschenreuter Matthias <Matthias.Kutschenreuter@siemens.com>
Cc: Stephen Crane <steve.crane@rococosoft.com>,
   "'Bluez-devel@lists.sourceforge.net'" <Bluez-devel@lists.sourceforge.net>
In-Reply-To: <AFE91B59A185A5439840B43AB791904709398A@mchp997a.mch.sbs.de>
References: <AFE91B59A185A5439840B43AB791904709398A@mchp997a.mch.sbs.de>
Content-Type: text/plain
Message-Id: <1086279402.7542.189.camel@pegasus>
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
Date: Thu, 03 Jun 2004 18:16:42 +0200

Hi Matthias,

> I tried this. The error message isnt shown anymore, of course, and using
> lsmod 
> I can see that hci_uart is used once now, but I am still not attached:
> hciconfig shows nothing.

what does dmesg when you load hci_uart? It should show its version
number. Or try "modinfo hci_uart"

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
