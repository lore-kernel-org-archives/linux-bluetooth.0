Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] CF cards capable of 1Mbps?
From: Nils Faerber <nils@kernelconcepts.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: bluez-devel@lists.sourceforge.net
In-Reply-To: <1063101266.32473.368.camel@hades.cambridge.redhat.com>
References: <1063101266.32473.368.camel@hades.cambridge.redhat.com>
Message-Id: <1063110035.21136.1291.camel@idoru.kc.de>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 09 Sep 2003 14:20:35 +0200
Content-Type: text/plain

Am Di, 2003-09-09 um 11.54 schrieb David Woodhouse:
> Slightly off-topic question... can anyone recommend a CF Bluetooth card
> which can actually do 1Mbps? Preferably available in the UK.
> 
> Many of them are advertised that way, but turn out to have a UART which
> is only capable of 115200 baud. The hardware compatibility list probably
> ought to give the maximum speeds.

The fact that the UART of the CF card sais it would run at 115kbps does
not at all mean that the actual data throughput is only 115kbps.
For example we have a Brainboxes CF card which you set to 115kbps but
actually uses 1Mbps between the UART and the CSR chipset then. The UART
clock is simply higher so that a devider for 115kbps results in 1Mbps.
Only if your OS tries to setup something based on the baudrate you would
be in trouble here. Linux has no problems with the extra bitrate.

CU
  nils faerber

-- 
kernel concepts          Tel: +49-271-771091-12
Dreisbachstr. 24         Fax: +49-271-771091-19
D-57250 Netphen          D1 : +49-170-2729106
--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
