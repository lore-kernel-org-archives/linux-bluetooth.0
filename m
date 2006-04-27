Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <20060427101407.30115.qmail@web31009.mail.mud.yahoo.com>
From: Sergey Krivov <krivov@yahoo.com>
Subject: Re: [Bluez-devel] a2dp alsa plugin "better"
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <44501FC3.3020507@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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
Date: Thu, 27 Apr 2006 03:14:07 -0700 (PDT)

Hi,


> fwiw, I switched to using a2dp_transfer2 instead of
> a2dp_transfer. I
> don't know who wrote either one of them, but things
> are a little bit
> better.

i wrote both of them. a2dp_transfer2 sleeps required
amount of time before transmitting the data,
essentially "locking up" the code. And i thought was
the reason why mplayer goes out of sync.
while a2dp_transfer just waits for the time to
transmit
the data returning the control to the invoking call.
turns out it does not help with mplayer.

however, watching movies with xine is possible.



__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
