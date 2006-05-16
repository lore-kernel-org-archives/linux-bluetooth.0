Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] concurrent service searches
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <100466c40605121019k42718981jc962b7d1bcee376c@mail.gmail.com>
References: <100466c40605121019k42718981jc962b7d1bcee376c@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1147789399.24761.77.camel@localhost>
Mime-Version: 1.0
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
Date: Tue, 16 May 2006 16:23:19 +0200

Hi Antonio,

> why if I start multiple services search on different devices (always
> less than 7) 
> 
> in that way:
> sdptool browse "DEVICE_ADDR"
> [gnome-obex-send --dest "DEVICE_ADDR" file2send.txt] (optional)
> 
> I get always errors (on 4-5 devices is fine, on 3-2 devices is "Failed
> to connect to SDP server on "DEVICE_ADDR": File descriptor in bad
> state")
> 
> The situation is better if I wait 1 or even 2 sec before starting a
> new search and send.
> 
> The problem was triggered developing a multithreaded bluetooth server
> in java, with avetana bluetooth. 
> I dont have these problem using the same code on windows.... 

you can't have multiple inquiry or page attempts at the same time. This
is a limitation of the baseband and not the host.

Regards

Marcel




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
