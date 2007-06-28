Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <BAY111-F16FFF3FC5BB2814CF14434C1090@phx.gbl>
References: <BAY111-F16FFF3FC5BB2814CF14434C1090@phx.gbl>
Date: Thu, 28 Jun 2007 16:59:21 +0200
Message-Id: <1183042761.9499.25.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Cc: bluez-devel@lists.sf.net
Subject: Re: [Bluez-devel] Trouble with bluetooth headset
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Clark,

> I have a colleague that is stuck trying to get a bluetooth headset working. 
> The system is montavista linux 2.6.10 on x86 for development and PPC for 
> deployment. Below is his request to me. Any help/guidance you can provide is 
> greatly appreciated. Also, if you can recommend a known good combination of 
> headset and usb dongle that has working drivers for PPC405 (Xilinx SOC) it 
> would save us the trouble of fixing this one.

the 2.6.10 kernel is highly outdated. Switch to the upcoming 2.6.22
kernel. We are not supporting these old kernels and I am not doing any
backports for it.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
