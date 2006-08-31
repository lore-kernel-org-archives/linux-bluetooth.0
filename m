Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44F7115D.6080700@pracucci.com>
Date: Thu, 31 Aug 2006 16:42:05 +0000
From: Marco Pracucci <development@pracucci.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <44F6EB3F.8030800@pracucci.com>	<Pine.LNX.4.63.0608311415010.8795@redbean.intranet.gw-instruments.de>	<44F6FD0A.1090900@pracucci.com>
	<1157041796.4026.133.camel@aeonflux.holtmann.net>
In-Reply-To: <1157041796.4026.133.camel@aeonflux.holtmann.net>
Subject: Re: [Bluez-devel] ioctl: setting link mode and link policy
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

Hi Marcel,

>> I would like to set a "global" link mode and link policy that will be
>> the default for every connection. Something similar to hcid.
>>     
> what do you expect from doing this? It is not a good idea to change it
> globally except you know exactly what you are doing. Changes these
> settings can have implications you might not be aware of. So what is
> your purpose on changing them?
>   
I would become master on incoming connections and I would deny role
switch on outgoing connections. If I'm not wrong, I should set MASTER as
link mode and disable role switch from link policy. However, I can't use
hcid, so I would do this from a custom application.
Is it possible?

Thanks,
Marco


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
