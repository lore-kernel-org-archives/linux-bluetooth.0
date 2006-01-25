Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] vendor/manufacture id
From: Marcel Holtmann <marcel@holtmann.org>
To: Michiel van Hulst <michiel@yall.nl>
Cc: Jim Wyllie <jwyllie@masaka.cs.ohiou.edu>,
        bluez-devel@lists.sourceforge.net
In-Reply-To: <200601251012.38001.michiel@yall.nl>
References: <43D69967.3060704@yall.nl> <1138143376.2616.5.camel@localhost>
	 <200601251012.38001.michiel@yall.nl>
Content-Type: text/plain
Message-Id: <1138181580.5782.16.camel@localhost>
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
Date: Wed, 25 Jan 2006 10:33:00 +0100

Hi Michiel,

> > the company id 10 stands for CSR. Take a look at the Bluetooth assigned
> > numbers documents from their website.
> The tool hcitool using the option "info <btaddr>" prints out Manufacture: 
> Cambridge Silicon Radio (10) or Nokia Mobile Phones (1) and so on. So in the 
> tool code should be a mapping for these numbers? Trough JBluez I only receive 
> the manufacture number (1) and (10) in this example.
> 
> Is there a list availible or array in c code which has these mappings? 

the library function is called bt_compidtostr().

> My program should respond deferent on every bluetooth manafacture device it 
> detects, so I'm looking for the manufacture id's from the Bluetooth device 
> market leaders

You read my answer with the Bluetooth assigned numbers document? Go to
the Bluetooth website and get this document/webpage.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
