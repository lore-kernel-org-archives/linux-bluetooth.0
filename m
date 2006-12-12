Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <457EE1A3.5030700@siemens.com>
References: <457EE1A3.5030700@siemens.com>
Date: Tue, 12 Dec 2006 18:58:09 +0100
Message-Id: <1165946289.21138.3.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] L2CAP: ECONNRESET
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

Hi Lukas,

> I have a problem with BlueZ when used with openOBEX. I've implemented 
> application for vCard receiving and every time the vCard is received, 
> the error on L2CAP level is signalled. This error takes place after the 
> vCard is sucessfully received (and no error on OBEX level is signaled to 
> me).
> 
> The error is ECONNRESET and is a result of
> l2cap_chan_del(sk, ECONNRESET) call
> in
> l2cap_disconnect_req
> This is called from l2cap_sig_channel after device sent 
> L2CAP_DISCONN_REQ on 0x001 CID channel.
> 
> My question is why is the l2cap_chan_del(sk, ECONNRESET) is hard-wired 
> in L2CAP_DISCONN_REQ request handling? Where is the problem and how can 
> I get rid of it (on the OBEX level)? Should I never get 
> L2CAP_DISCONN_REQ in normal operation mode?
> I've tried several devices with the same result. My openOBEX is of 1.3, 
> kernel 2.4.31 official one. I run the application on MIPS.

you should start using a 2.6 kernel. The 2.4 series is not really
supported anymore.

And run "hcidump -X -V" to see what actually happens.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
