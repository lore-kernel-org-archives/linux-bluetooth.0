Return-Path: <cyrus@holtmann.org>
Message-ID: <04bd01c8cd07$ab7f7020$0132a8c0@Raymondpc>
From: "skyflame" <skyflame@21cn.com>
To: "hong zhang" <henryzhang62@yahoo.com>,
	"BlueZ development" <bluez-devel@lists.sourceforge.net>,
	<attaboyu@163.com>
References: <230309.30571.qm@web57914.mail.re3.yahoo.com>
Date: Fri, 13 Jun 2008 11:43:39 +0800
MIME-Version: 1.0
Subject: Re: [Bluez-devel] How to run up CSR chip without eeprom with BLUEZ ?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi


> Raymond,
>
> One year ago, I have a project using CSR wifi and
> bluetooth. If demo does not use bluez, that means it
> uses CSR bluetooth stack not bluez stack from kernel.
> Why do you think you are using bluez stack?
> I feel you are using CSR bluetooth stack.

Both the demo and bluez is compiled by myself, I use different software to 
test it
So I know exactly what stack I am using.

> Can you tell me what you do to invoke kernel
> bluetooth?
>

When I using CSR's BCHS stack, it's build with the demo in a single app and 
the only relation with kernel is the uart driver.

While when using bluez, I insert bluetooth.ko and hci_uart.ko

and I use hciattach which will use bluez-libs. So I am for sure it's using 
Bluez stack instead of csr's



> You need to make it clear how do you bring up bluex
> stack.
>
> ---henry


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
