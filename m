Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Vendor Specific Commands
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <A35A8D03A748B34A9DA2AB0335A3F93D408823@rfsdmail.internal.rfmd.com>
References: 
	 <A35A8D03A748B34A9DA2AB0335A3F93D408823@rfsdmail.internal.rfmd.com>
Content-Type: text/plain
Message-Id: <1133903810.27209.23.camel@blade>
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
Date: Tue, 06 Dec 2005 22:16:50 +0100

Hi Jatin,

> I am using UART connection to the host. Currently I donot have the
> chipset manual, but it should not matter because not all vendor specific
> commands are related to hardware configuration.
> 
> I searched the source code little bit and I feel that hciattach might be
> the place to put it since it already has some RFMD (swave) specific
> code. am I correct? (In that case my original question might have been
> worded incorrectly).

as I said, this depends on. The only support for ROM chips that BlueZ
has (officially) is for CSR chips. We do the complete programming with
the bccmd tool. As you might see, the hciattach tool only contains UART
specific settings. It does not sets the BD_ADDR or other things that are
needed for ROM chips. And as long as you don't tell me how the ROM chip
initialization of RFMD or Silicon Wave chips are supposed to work, I
can't give you any information on the best way to handle it.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
