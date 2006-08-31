Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Thu, 31 Aug 2006 14:18:28 +0200 (CEST)
From: Peter Wippich <pewi@gw-instruments.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <44F6EB3F.8030800@pracucci.com>
Message-ID: <Pine.LNX.4.63.0608311415010.8795@redbean.intranet.gw-instruments.de>
References: <44F6EB3F.8030800@pracucci.com>
MIME-Version: 1.0
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


Hi Marco, 

depending on which level you want to set the linkmode use setsockopt() 
for your connection. E.g. for rfcomm use something like : 

// set security options for this service
if(authenticate) {
	linkmode |= RFCOMM_LM_AUTH ;
	if(encrypted) linkmode |= RFCOMM_LM_ENCRYPT ;
}

if (linkmode && setsockopt(sfd, SOL_RFCOMM, RFCOMM_LM, &linkmode, sizeof(linkmode)) < 0) {
	close(sfd); sfd = 0 ; 
	return -1;
}

Ciao, 

Peter 


On Thu, 31 Aug 2006, Marco Pracucci wrote:

> Hi list,
> 
> I have some problem when I try to set link mode and link policy using
> ioctl() system call. In particular, when I set link policy or link mode,
> it seems that nothing happens.
> 
> -----------------
> int deviceDescriptor;
> struct hci_dev_req request;
> 
> // Open device
> deviceDescriptor = hci_open_dev(deviceID);
> [...]
> 
> // Set link mode
> memset(&request, 0, sizeof(request));
> request.dev_id = deviceID;
> request.dev_opt = HCI_LM_MASTER;
> ioctl(deviceDescriptor, HCISETLINKMODE, (unsigned long) &request);
> [...]
> 
> // Set link policy
> memset(&request, 0, sizeof(request));
> request.dev_id = deviceID;
> request.dev_opt = policy;
> ioctl(deviceDescriptor, HCISETLINKPOL, (unsigned long) &request);
> [...]
> -----------------
> 
> ioctl() system calls do not return any error, but when I check the link
> mode and link policy with "hciconfig -a" nothing has changed. Moreover,
> I have tried to debug it with "hcidump -V" but no related hci commands
> are reported.
> 
> Bluez-libs: 2.25
> Bluez-utils: 2.25
> 
> Have you any idea and/or suggestion?
> 
> Thanks,
> Marco Pracucci
> 
> 
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
> 


|       Peter Wippich                   Voice: +49 30 46776411          |
|       G&W Instruments GmbH            fax:   +49 30 46776419          |
|       Gustav-Meyer-Allee 25, Geb. 12  Email: pewi@gw-instruments.de   |
|       D-13355 Berlin  / Germany                                       |


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
