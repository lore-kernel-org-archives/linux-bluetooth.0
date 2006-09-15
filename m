Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <44FE86EC.000014.12930@bj163app52.163.com>
References: <44FE86EC.000014.12930@bj163app52.163.com>
Date: Fri, 15 Sep 2006 13:59:03 +0200
Message-Id: <1158321543.5233.19.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] hciemu lost its interface after I run att est
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi,

> hi guy, I experienced one issue, can anybody help? thanks!
> 
> 1. setup 2 virtual hci interface hci0 and hci1
> hciemu localhost:1000
> hciemu localhost:2000
> linux-l20w:~ # hciconfig
> hci0: Type: VHCI
> BD Address: 7F:00:00:01:03:E8 ACL MTU: 192:8 SCO MTU: 64:0
> UP RUNNING PSCAN ISCAN
> RX bytes:0 acl:0 sco:0 events:15 errors:0
> TX bytes:569 acl:0 sco:0 commands:15 errors:0
> 
> hci1: Type: VHCI
> BD Address: 7F:00:00:01:07:D0 ACL MTU: 192:8 SCO MTU: 64:0
> UP RUNNING PSCAN ISCAN
> RX bytes:0 acl:0 sco:0 events:15 errors:0
> TX bytes:569 acl:0 sco:0 commands:15 errors:0
> 
> 2. run attest
> attest 7F:00:00:01:03:E8 10
> the $? is equal 0
> linux-l20w:~ # attest 7F:00:00:01:03:E8 10
> Connecting to 7F:00:00:01:03:E8 on channel 10
> linux-l20w:~ # echo $?
> 0
> Everything is OK until now.
> 
> 3. But hci1 is lost
> But take a look at this:
> linux-l20w:~ # hciconfig
> hci0: Type: VHCI
> BD Address: 7F:00:00:01:03:E8 ACL MTU: 192:8 SCO MTU: 64:0
> UP RUNNING PSCAN ISCAN
> RX bytes:0 acl:15 sco:0 events:22 errors:0
> TX bytes:797 acl:12 sco:0 commands:18 errors:0
> hci1 is lost.
> 
> Otherinfo:
> linux-l20w:~ # uname -r
> 2.6.16.21-38-smp

I have no idea, but you might wanna check hciemu for a segmentation
fault or run it within a debugger.

Regards

Marcel



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
