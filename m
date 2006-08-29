Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1156857801.8576.117.camel@localhost>
References: <1156839814.8576.104.camel@localhost>
	<1156848370.5613.66.camel@aeonflux.holtmann.net>
	<1156854435.8576.113.camel@localhost>
	<1156862083.6183.3.camel@aeonflux.holtmann.net>
	<1156857801.8576.117.camel@localhost>
Date: Tue, 29 Aug 2006 19:44:55 +0200
Message-Id: <1156873495.4026.6.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] hcid crash
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

Hi Pierre-Yves,

> > you need to install the libs from CVS, too. We are in the process of
> > adding an async API to SDP.
> 
> Indeed, after compiling and installing (using the autoconf scripts from
> the 3.4 release) the libs from CVS, the utils from CVS do compile fine,
> and the crash is gone! Not a bug anymore :-) Thanks for the good work!

the thanks go to Johan. He fixed our buggy mainloop, but it was not in
time for the 3.4 release. And 3.5 has to wait until we stabilized the
async SDP functions.

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
