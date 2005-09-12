Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "Stefan Michaelis" <stefan.michaelis@gmx.de>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Message-ID: <20744.1126516069@www29.gmx.net>
Content-Type: text/plain; charset="us-ascii"
Subject: [Bluez-devel] Re: hid2hci segementation fault at boot time
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
Date: Mon, 12 Sep 2005 11:07:49 +0200 (MEST)

Hi,

finally got the time to look into it over the weekend. Used gdb as Marcel
proposed and there we go, it was a problem in the resmgr. Updated it and no
longer a segmentation fault occurs. Too stupid I did not think of this
myself; sorry for thinking hid2hci does not work.
Regarding pskey: Nice idea, tried it and pskey tells me it can not find the
persistent storage for bootmode. I will stick to hid2hci, believing it is
the safer way to switch modes.

Regards

Stefan

>Hi Stefan,
>  
>  > I own a Logitech Bluetooth Desktop keyboard and mouse. I wanted to use
> the
>  > Logitech dongle to additionally connect my Bluetooth headset to the PC 
for
>  > Skype voice calls. 
>  > So far no problems, modules and demons load fine, switched the Logitech
> > dongle to bluetooth mode via hid2hci.
 > To automate this process during boot time I enabled the bluetooth.init
 > script. The demons and modules still load fine, but hid2hci crashes with
a
> > segmentation fault. When I run the init script after bootup as superuser
> > everything goes fine.
> > Any idea where is the difference or what I am doing wrong?
> > Running Suse 9.1 with a vanilla kernel 2.6.12.4. Tried the last three
> > releases of Bluez.
> 
> check with dmesg if you see a kernel oops. Otherwise use gdb to debug
> the problem.
> 
> Regards
> 
> Marcel

-- 
GMX DSL = Maximale Leistung zum minimalen Preis!
2000 MB nur 2,99, Flatrate ab 4,99 Euro/Monat: http://www.gmx.net/de/go/dsl


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
