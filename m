Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <loom.20070212T114641-211@post.gmane.org>
References: <loom.20070212T114641-211@post.gmane.org>
Date: Mon, 12 Feb 2007 20:34:39 +0100
Message-Id: <1171308879.11774.8.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] concurrent inquiring and sending data
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

Hi Yuriy,

> I'm developing an application using bluez. 
> It must search devices and send them data(files).
> 
> i'm using one bluetooth dongle for searching 
> and some dongles for sending.
> 
> i've found code which do search anisochronous.
> it works fine.
> 
> but when application tries to connect 
> to device for sending it often says 
> error "File descriptor in bad state"
> 
> i've searched in this mailing 
> list about it and found that connecting 
> simultaneously is not possible
> that's why this error comes
> 
> I have questions, please, if somebody knows, tell me 
> 
> 1. can inquiring at one dongle 
>    disturb connecting at another dongle?
> 
> 2. if connecting is being maden at different dongles
>    can they conflict with each other?
> 
> 3. How can i avoid this situation without patching 
>    kernel( or may be it has been already done at 
>    some versions of kernel)?

what kernel version are you using and you have to show the output of
"hcidump -X -V" for further analysis.

Regards

Marcel



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
