Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <44A4F25C.5000408@infitsrl.com>
References: <44A4E5A4.5070904@infitsrl.com>
	<1151657604.20305.9.camel@localhost> <44A4E987.1000104@infitsrl.com>
	<1151658731.20305.11.camel@localhost> <44A4F25C.5000408@infitsrl.com>
Date: Fri, 30 Jun 2006 12:06:43 +0200
Message-Id: <1151662003.20305.22.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] sdp_connect thread safe?
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

Hi Fabrizio,

> Ok....I think my question was not so clear (I'm not english so escuse me).
> I'm porting a simple application that I have made for Windows using 
> Microsoft stack, in this application there is an inquiry and for every 
> devices found I'm looking if it's opush capable.
> 
> In Microsoft stack I suppose sdp discovery of push service is masked in 
> sense I don't have to specify the RFCOMM channel when  I made  the 
> connection with device. In the SOCKADDR_BTH struct used by connect I 
> simply specify -1 in port field (channel) and all works with 100% of 
> opush enabled devices tested.
> 
> In conclusion I think in my windows version of this software there are 
> multiple simultaneous sdp connections and I have not had problems with 
> several types of adapters.

they might use a baseband connection queue and stall additional requests
to create the ACL, but we don't do it this way in BlueZ.

Regards

Marcel



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
