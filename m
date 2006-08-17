Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Mayank BATRA <mayank.batra@st.com>
To: "'BlueZ development'" <bluez-devel@lists.sourceforge.net>
Date: Thu, 17 Aug 2006 10:13:14 +0530
Message-ID: <000301c6c1b7$a75d3fc0$9d0cc70a@dlh.st.com>
MIME-Version: 1.0
In-Reply-To: <1155587165.4075.10.camel@aeonflux.holtmann.net>
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

Hi Marcel,

> > (iii) The host buffer size command and set controller to host flow
> > controller command can be sent from configure_device() of 
> hcid/main.c
> 
> No. This must be done in the kernel. It is not the job of hcid.

I still feel that these two commands should be sent from hcid at the time of
initialization amd the user should have option to enable/disable this flow
control from hcid.conf

> > But, I could not figure out from where should we send the 
> Host Number of
> > completed packets command. Do you have any suggestions. I 
> mean, can you give
> > me an idea where can we get to know the receipt of ACL Data 
> at user level?
> 
> This must be done in the kernel. It is like sniff mode 
> support. Only the
> kernel knows all facts.

I agree with this.

Regards,
Mayank


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
