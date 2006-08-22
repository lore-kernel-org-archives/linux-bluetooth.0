Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <d23110170608211410l1c4cae0aufa41d8f589bda68d@mail.gmail.com>
References: <1156167261.3956.20.camel@aeonflux.holtmann.net>
	<004b01c6c518$d298e400$9d0cc70a@dlh.st.com>
	<d23110170608211410l1c4cae0aufa41d8f589bda68d@mail.gmail.com>
Date: Tue, 22 Aug 2006 07:42:00 +0200
Message-Id: <1156225320.3956.50.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Host Controller to Host Flow Control
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

Hi Ulisses,

> And I really think we should have a hci_send_cmd_raw() or something
> like that instead of messing with hci_send_cmd(). Or maybe a new
> function that creates a skb from scratch just to send the host number
> of completed packets command? Marcel, what do you think?

no additional function for only one call. We either make hci_send_cmd()
aware of the special case or we need to queue this command by hand. I
have to check the internals of the command flow before I can actually
tell you what's the best way. Haven't looked at that for quite some time
and don't know it from memory.

Regards

Marcel



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
