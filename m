Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <450AD1DF.2010401@flcd.net>
References: <4504301E.4060402@flcd.net> <1158313871.5233.11.camel@localhost>
	<450AD1DF.2010401@flcd.net>
Date: Fri, 15 Sep 2006 18:19:04 +0200
Message-Id: <1158337144.5233.34.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] enable auth and BNEP question?
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

Hi Denis,

> >> 2. I mostly use my Linux box to share create bluetooth network with 
> >> other PC and my PDA so previously I had "pan " directory inside 
> >> /etc/bluetooth/ with dev-up and dev-down files which automatically bring 
> >> up bnep0 device, but seems that BlueZ 3.5 is working differently and I 
> >> need to execute "ifconfig benp0 up" to enable my connection.
> >> Is there a way to automate this?
> >>     
> >
> > you might wanna try the -A, -E or -S switch for pand.
> >   
> Thanks for response, Marcel!
> 
> I've tried switches you've recommend and seems that "-S" is what I'm 
> looking for although it asked me authorization 3 times(even once devices 
> was paired) but now it seems to work like it should.
> 
> Maybe you can help me with brining up bnep0 interface automatically as well?

this depends on your distro. All distros have a way of bringing up
devices automatically. Or you might wanna check the pand.1 manual page.

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
