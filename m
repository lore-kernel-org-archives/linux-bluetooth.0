Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1157464964.18992.83.camel@localhost>
References: <1157355863.18992.42.camel@localhost>
	<1157366293.32195.41.camel@aeonflux.holtmann.net>
	<1157361100.18992.49.camel@localhost>
	<1157449810.4206.0.camel@localhost>
	<1157464964.18992.83.camel@localhost>
Date: Fri, 15 Sep 2006 14:02:03 +0200
Message-Id: <1158321723.5233.24.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] What's going on here? RFCOMM
	on	OPP	always	gets	disconnected
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

Hi Pierre-Yves,

> > > > in case please to "hcidump -X -V --obex=9". I am not going to decide
> > > > OBEX by hand if I don't have to.
> > 
> > please check that their OPP service is still on channel 9. The channel
> > numbers might have changed and you connect to the wrong channel.
> 
> I just checked, but it is not the case: OPP is still on the channel 9. I
> get the prompt to accept the incoming object, but past that point it
> always does behave like in the log I posted earlier. If I was on the
> wrong channel, how could I get this as I do?
> 
> 
> > ACL data: handle 12 flags 0x02 dlen 16
>     L2CAP(d): cid 0x0040 len 12 [psm 3]
>       RFCOMM(d): UIH: cr 0 dlci 18 pf 1 ilen 7 fcs 0x8 credits 1
>         OBEX: Connect rsp(f): status 200 len 7 version 1.0 flags 0 mtu
> 2044
>         Status 200 = Success
> 
> 
> I did the same test on another phone (SE k750i), and the log looks alike
> (with the endless list of 0's at the end too). Here it is:

I have no clue. Maybe you wanna make sure to recompile every library. It
looks like a nasty bug or error in your code.

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
