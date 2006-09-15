Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200609071118.54616.jcuesta@pindiatec.com>
References: <200609061228.41138.jcuesta@pindiatec.com>
	<5f30e2610609060501n10f77d8fj4ed489c4cc9f3ae6@mail.gmail.com>
	<200609071118.54616.jcuesta@pindiatec.com>
Date: Fri, 15 Sep 2006 13:57:57 +0200
Message-Id: <1158321477.5233.17.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Starting to work with bluez
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

Hi Javier,

> Albert Huang's Web is helping me a lot but i still have some problems, Im 
> trying to writte some simple code, just for starting to work with bluez, and 
> im findin some problems ussing the libraries, for example:
> 
> Im trying to writte the class of device using hci_write_class_of_dev(int dd, 
> uint32_t cls, int to) im having problems ussing the libraries becouse i have 
> found no documentation about what "dd" and "to" means(whats suposed to be 
> sent to those variables and maybe whats that for).
> 
> Im more interested in fidnding a documentation about the libraries themselfs 
> so i can solve the problems that ill find in the future by my own than in 
> knowing what those variables means.

take a look at the D-Bus API for BlueZ and start using this one. I has
easy methods for all daily tasks.

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
