Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Thu, 29 Jun 2006 21:54:40 -0300
From: Nelson Murilo <nelson@pangeia.com.br>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20060630005440.GD22212@pangeia.com.br>
References: <28c817710606290332o2e84020dl91d4a0bff11db73f@mail.gmail.com>
	<6297d67c0606290445h455ea56bjfdf3bc2b44f26ad1@mail.gmail.com>
	<1151582944.14964.17.camel@localhost>
	<28c817710606290543i3f331478ta461242dcc94d612@mail.gmail.com>
	<1151596973.14964.30.camel@localhost>
	<28c817710606291744l354a24d0h4113ec90e176c24a@mail.gmail.com>
Mime-Version: 1.0
In-Reply-To: <28c817710606291744l354a24d0h4113ec90e176c24a@mail.gmail.com>
Subject: Re: [Bluez-devel] how to create a ACL connection with an
	authentication?
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




On Fri, Jun 30, 2006 at 08:44:38AM +0800, ifq wrote:
> 
> I have seen file l2test.c,and I found how to let a socket to request
> authentication,but another question is I did'n found the source about set
> link key in server or client. is there something I missed?
> 

Check hcid/storage.c and hcid/dbus-adapter.c 

Regards,

./nelson -murilo

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
