Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <444CF957.6080203@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Fwd: Help with l2cap broadcast programming
References: <55cd79280604231728s788eb97bi76e9998816181dd3@mail.gmail.com> <55cd79280604240416m634b1aa7j27e2cabedbb81239@mail.gmail.com> <444CF59F.5020003@xmission.com>
In-Reply-To: <444CF59F.5020003@xmission.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 24 Apr 2006 10:14:15 -0600

Hey

> The core spec talks about broadcast... lt_addr is all 0, llid = 10, ptt
> = 0. I looked around for examples using bluez but couldn't find any.

I did some more digging and about a year ago Marcel was discussing this.
It sounds like an API for broadcast has not been hammered out and there
may not be an implementation at the lowest (hci) layer.

Brad


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
