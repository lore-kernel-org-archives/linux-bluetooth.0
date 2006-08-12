Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Scott Gilliland <scott.gilliland@gatech.edu>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20060713004239.GA17607@srcf.ucam.org>
References: <20060713004239.GA17607@srcf.ucam.org>
Date: Sat, 12 Aug 2006 13:35:42 -0400
Message-Id: <1155404142.5059.18.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] A2DP plugin success with HP bluetooth headphones
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

Matt,

By audio droupouts, do you mean like 1-2 seconds of silence, every 45
secs or so? I'm experiencing just that on my Anycom headset, also with
no clue where to start looking for answers, other than mulling in the c
code.


On Thu, 2006-07-13 at 01:42 +0100, Matthew Garrett wrote:
> Hi,
> 
> I've finally got around to retesting my HP bluetooth headphones with the 
> latest alsa-plugin code. They work almost perfectly, though with 
> occasional brief audio dropouts. There doesn't seem to be any good 
> pattern to these. Is there a good way of diagnosing what the problem 
> might be?



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
