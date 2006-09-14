Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Thu, 14 Sep 2006 11:04:57 +0200 (CEST)
From: Peter Wippich <pewi@gw-instruments.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <3f5a9ba20609132122ue951876kcdfaacae30110f66@mail.gmail.com>
Message-ID: <Pine.LNX.4.63.0609141101160.22339@redbean.intranet.gw-instruments.de>
References: <3f5a9ba20609132122ue951876kcdfaacae30110f66@mail.gmail.com>
MIME-Version: 1.0
Subject: Re: [Bluez-devel] About concurrency sdp_connect
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


Hello Mingfan, 

On Thu, 14 Sep 2006, Mingfan.Lu wrote:

> In my program, I have several concurrent threads to do sdp_connect. Here,
> each thead tries to connect to one device while, only one dongle is used.
> I find that if the amount of concurrency threads is large, all threads will
> time out.
> As we all know, sdp use L2cap connection. can't we create concurrent sdp
> connections?
> Wait for your nice help ;)

Concurrent connection setup is not possible on the HCI level due to 
hardware restrictions. This issue has been discussed several times here.  
Check the archives. 

Ciao, 

Peter 



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
