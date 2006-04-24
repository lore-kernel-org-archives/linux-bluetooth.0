Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <444CAE4F.70404@kernelconcepts.de>
From: Nils Faerber <nils.faerber@kernelconcepts.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: New HCI-USB device, no MAC?
References: <4410090A.3070706@kernelconcepts.de>  <1141912311.4605.9.camel@aeonflux.holtmann.net>  <44104DD5.80109@kernelconcepts.de> <1141923373.4605.39.camel@aeonflux.holtmann.net> <loom.20060412T215427-611@post.gmane.org>
In-Reply-To: <loom.20060412T215427-611@post.gmane.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 24 Apr 2006 12:54:07 +0200

Evan Paul Fletcher schrieb:
> Marcel Holtmann <marcel <at> holtmann.org> writes:
>> Hi Nils,
>>> Windows did not change it :(
>>> Also the tools that com eon the CDROM seem not to be able to change it.
>>> Have you contacted ISSC about that issue already?
>>> It should be forbidden to release hardware without valid BDADDR into the
>>> market... That is kind of stupid and dangerous.
>> I think it isn't really the fault of ISSC. It is a stupid module
>> manufacturer that has not clue that an BD_ADDR suppose to be unique.
>>
>> Regards
>> Marcel
> Hi Marcel,
> 
> Did anyone ever find a solution/workaround for these ISSC-based dongles?  I seem
> to have acquired two dongles with a BD_ADDR of 11:11:11:11:11:11 and from
> searching Google, it seems that a lot of other people are in the same boat.

I have contacted ISSC about that issue.

Hopefully the will reply and send the HCI or whatever commands
necessary... I have two of those dongles which renders at least one
useless (I guess two times the same BDADDR will not work in a piconet ;)

> Cheers,
> Evan Paul Fletcher
Cheers
  nils faerber

-- 
kernel concepts          Tel: +49-271-771091-12
Dreisbachstr. 24         Fax: +49-271-771091-19
D-57250 Netphen          Mob: +49-176-21024535
--


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
