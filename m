Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Tue, 3 Oct 2006 15:49:27 +0200 (CEST)
From: Peter Wippich <pewi@gw-instruments.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <9cc82a4d0610030619qbc160fdqe983cb529e5f8c02@mail.gmail.com>
Message-ID: <Pine.LNX.4.63.0610031538100.5319@redbean.intranet.gw-instruments.de>
References: <9cc82a4d0610020710q17efb8efk99079c5f943ddaf8@mail.gmail.com>
	<4521D073.1030105@xmission.com> <45221882.3020809@palmsource.com>
	<9cc82a4d0610030425g3c078f62o77fd4d29318c4bee@mail.gmail.com>
	<45226231.6080203@palmsource.com>
	<9cc82a4d0610030619qbc160fdqe983cb529e5f8c02@mail.gmail.com>
MIME-Version: 1.0
Subject: Re: [Bluez-devel] Bluez article on OReillyNet
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


Hi , 

On Tue, 3 Oct 2006, Guylhem Aznar wrote:

> Unfortunately, the ARM machines I have only have serial ports ....
> 
> I will try to have them chips on HWUART which should not have speed problems.

Depending on your system it is most likely that the HW Uart extension is 
not realy supported by the serial driver. I currently only know for sure 
for PXA type system. You need a special HWUART driver to take advantage of 
the HWUART. 

For a PXA system we may help you out if you insist. We've not supplied it 
yet for general inclusion because 
a) it is not generic enough (makes assumptions about the HW used) 
b) Marcel would reject it because of coding style (uses 4 characters space 
indenting.....)  

Further you may get problems with the RS232 driver chips usualy 
used. If you're able to connect the serial bluetooth module directly to 
the ARM UART lines (Rx / Tx / RTS /CTS) (3 Volt interface without RS232 
driver on both sides) this would be much better. 

Ciao,

Peter 

|       Peter Wippich                   Voice: +49 30 46776411          |
|       G&W Instruments GmbH            fax:   +49 30 46776419          |
|       Gustav-Meyer-Allee 25, Geb. 12  Email: pewi@gw-instruments.de   |
|       D-13355 Berlin  / Germany                                       |


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
