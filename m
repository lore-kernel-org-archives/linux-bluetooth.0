Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: sean <seandarcy2@gmail.com>
Date: Tue, 22 Aug 2006 18:03:39 -0400
Message-ID: <ecfuvs$tjj$1@sea.gmane.org>
References: <ecfo8s$790$1@sea.gmane.org>
	<20060822211038.GA24883@localhost.localdomain>
Mime-Version: 1.0
In-Reply-To: <20060822211038.GA24883@localhost.localdomain>
Subject: Re: [Bluez-devel] recursive locking on pairing: 2.6.18-rc4
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

Johan Hedberg wrote:
> Hi sean,
> 
> On Tue, Aug 22, 2006, sean wrote:
> 
>>I'm trying to pair my nokia 770 with my desktop which is 
>>running fc6t2, kernel-2.6.18-rc4. bluez-libs-3.0. Using a 
>>zonet usb dongle.
>>
>>The 770 returns a "no services" message. On the desktop, 
>>/var/log/messages:
> 
> 
> I can't say anything about the desktop side problems, but the reason you 
> get "no services" is that the 770 will only pair with devices that have 
> either a Dial-up Networking (DUN) or OBEX File Transfer profile service 
> records (or both) in its SDP server. So if you e.g. do a "sdptool add 
> DUN" and "sdptool add FTP" on the desktop side you shouldn't get that 
> error message.
> 
> Johan
> 

That was it. Once I sdptool add FTP , pairing succeeded, 
without any kernel error messages.

sean


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
