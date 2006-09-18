Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <000001c6d9c5$53bbd040$6713a8c0@alai.alpsautomotive.com>
References: <000001c6d9c5$53bbd040$6713a8c0@alai.alpsautomotive.com>
Date: Mon, 18 Sep 2006 08:25:53 +0200
Message-Id: <1158560753.30486.25.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] IrMC Sync Profile - OBEX GET is UNAUTHORIZED
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

Hi Scott,

> I am currently developing Level4 IrMC Sync for use with Sony Ericsson
> phones.  Using rfcomm socket, I can start the sync using "IRMC-SYNC"
> OBEX TARGET header in the CONNECT request.  The server replies with
> SUCCESS response code, plus the WHO header ("IRMC-SYNC") and a 4 byte
> connection ID.  Problem I am having is after connect success when I go
> to retrieve a Level4 object, in this instance the changelog
> telecom/pb/luid/0.log, the server always reply with 0xC1
> (UNAUTHORIZED) immediately followed by ENDOFBODY header with 21 bytes
> of non-ascii data.  I am sending the following GET request for this :

the BlueZ CVS contains the program btobex in the obex repository. This
might help you testing it. I tried it with a T630 and it gives me the
following output:

# ./btobex pull 00:0F:DE:xx:xx:xx 10 telecom/pb/luid/0.log
SN:354750000279937
DID:7F90
Total-Records:2
Maximum-Records:510
M:4::00001E000000
M:5::00001F000000
H:7::000020000000

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
