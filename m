Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Pierre-Yves Paulus <py@idlum.be>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1156792534.5613.42.camel@aeonflux.holtmann.net>
References: <1156757049.8576.62.camel@localhost>
	<1156772367.5613.33.camel@aeonflux.holtmann.net>
	<1156770065.8576.71.camel@localhost>
	<1156792534.5613.42.camel@aeonflux.holtmann.net>
Date: Tue, 29 Aug 2006 09:53:51 +0200
Message-Id: <1156838032.8576.93.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] rfcomm in TTY raw mode from DBus
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

On Mon, 2006-08-28 at 21:15 +0200, Marcel Holtmann wrote:

> the rfcomm utility has this capability, because I needed it for some
> early kernel RFCOMM demonstrations. I wrote that tool back in 2002 and
> in general the application should set the TTY in the needed mode. Only
> cat is too stupid for this.

Ok.

> If Java or any other language is too stupid to handle a TTY correctly
> then it also will have problems with serial ports and other TTY based
> services. This is a problem of the language you choose. So in this case
> you have to fix the language and not make our D-Bus API workaround these
> problems.

The reason why I asked for the DBus to do so was also driven by a
mistake in my understanding of the action to be performed. Your answers
and further investigation made the point clearer for me.

The JAVA language does not completely lack the ability to manage it, as
it allows a native call to perform the task. I think the reason it does
not offer high level methods to perform this kind of task is its aim to
platform independance. But anyway, I did write a small C function and
call it using JNI, and it is working smoothly.

Thanks for your support,
Best Regards.

Pierre-Yves



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
