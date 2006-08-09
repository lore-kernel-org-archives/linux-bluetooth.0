Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <44D9B6A6.4030706@palmsource.com>
References: <44D9B6A6.4030706@palmsource.com>
Date: Wed, 09 Aug 2006 23:50:47 +0200
Message-Id: <1155160247.4492.3.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] rfcomm utility patch to loop and
	startup	executable when connection received
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

Hi Frederic,

> I came accross the need to startup an executable when rfcomm receives a 
> connection. I also added an option called watch that allows rfcomm not 
> to exit when the rfcomm connection is closed. It simply loops and calls 
> listen.
> 
> listen   <dev> [channel [cmd]]          Listen
> watch    <dev> [channel [cmd]]          Watch
> 
> rfcomm --raw watch 0 1 "cat {}"
> rfcomm --raw listen 0 1 "cat {}"
> 
> Not specifying the cmd parameter will simply wait for [control-c] as before.
> 
> the {} will be replaced by the address of the rfcomm device created. In 
> the example the command run will be 'cat /dev/rfcomm0'.

the feature looks useful, but the patch is not acceptable. You need to
fix the coding style. What is the difference between listen and watch?

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
