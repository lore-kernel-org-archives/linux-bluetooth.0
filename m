Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.63.0606301142130.18028@redbean.intranet.gw-instruments.de>
References: <44A4E5A4.5070904@infitsrl.com>
	<1151657604.20305.9.camel@localhost> <44A4E987.1000104@infitsrl.com>
	<1151658731.20305.11.camel@localhost>
	<Pine.LNX.4.63.0606301142130.18028@redbean.intranet.gw-instruments.de>
Date: Fri, 30 Jun 2006 12:23:51 +0200
Message-Id: <1151663031.20305.36.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] sdp_connect thread safe?
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

Hi Peter,

> > > Is there a list of bluetooth adapters supporting this feature?
> > > Doing hciconfig -a [adapter] is not possible to known if the device 
> > > support multiple simultaneus sdp_connect ?
> > 
> > I think my phrase was not clear. I haven't seen any adapter that is
> > capable of multiple baseband pages at the same time.
> 
> So do I. There's a simple proof: just send a HCI_Create_Connection command 
> and than try to send a second Create_Connection before you get the 
> connection complete event for the first Create_Connection. 
> If the second create connection passes, please tell me what chip it was 
> !!!
> The normal behaviour is that the chip will reply with an error event (like 
> command dissallowed) for the second connection attempt. I think there was 
> some discussion about this some time ago. The only way to come around this 
> is a complicated buffering for HCI commands inside BlueZ. It will require 
> the stack to hold a create connection command in the queue when it gets an 
> error response for a create connection command and re-issue it once it 
> gets an connection complete or connection fail event.

if you wanna really support this, then you have to implement it in the
L2CAP layer. Doing it inside HCI would mess up a lot of things and I
would always reject this. However feel free to send in patches to
implement this inside L2CAP.

Regards

Marcel



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
