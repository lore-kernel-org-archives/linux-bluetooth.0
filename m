Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Fri, 23 Jun 2006 18:21:16 +0200 (CEST)
From: Peter Wippich <pewi@gw-instruments.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <70DCB28C5BB04A4BBB1C8512589BAC65ED87BC@MAIL006.mail.lan>
Message-ID: <Pine.LNX.4.63.0606231818400.25515@redbean.intranet.gw-instruments.de>
References: <70DCB28C5BB04A4BBB1C8512589BAC65ED87BC@MAIL006.mail.lan>
MIME-Version: 1.0
Subject: Re: [Bluez-devel] CSR hci continuous transmit mode?
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

On Fri, 23 Jun 2006, Brand, Chris wrote:

Hi Chris, 

> I was looking at how to send the CSR "Enter Device Under Test Mode"
> command, which sounds like it may be related. I found the ogf, ocf and
> parameters in the CSR documentation (0x6, 0x3 and none, in this case).
> Then I used
> hcitool cmd 0x6 0x3
> To send that command to the chip.
This is something different. The device under test mode is intended to be 
used with a Bluetooth Tester. When the device is in DUT mode it can be 
controlled by a remote (Test) device. More specifics information about DUT 
mode can be found in the BT spec. 

Ciao, 
Peter 



> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
> 


|       Peter Wippich                   Voice: +49 30 46776411          |
|       G&W Instruments GmbH            fax:   +49 30 46776419          |
|       Gustav-Meyer-Allee 25, Geb. 12  Email: pewi@gw-instruments.de   |
|       D-13355 Berlin  / Germany                                       |


Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
