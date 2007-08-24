Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Fri, 24 Aug 2007 11:06:36 -0400
Message-ID: <2EB6297382462046A9427D7324788A480217D7B4@MCLNEXVS06.resource.ds.bah.com>
In-Reply-To: <1187965538.15402.177.camel@violet>
References: <2EB6297382462046A9427D7324788A480217D35A@MCLNEXVS06.resource.ds.bah.com><1187957692.15402.149.camel@violet><2EB6297382462046A9427D7324788A480217D756@MCLNEXVS06.resource.ds.bah.com>
	<1187965538.15402.177.camel@violet>
From: "Williams, Richard" <williams_richard_b@bah.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Multiple Bluetooth Dongles
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

Hello Marcel,

Thank you for the quick response and the suggestion.

With my existing 2.6.22.2-42.fc6 kernel, reloading the hci_usb with
isoc=0 does help somewhat. I can plug in more than 16 dongles and the
system remains stable. The mouse and keyboard remain usable. However,
the 17th USB device is not recognized.

I am reluctant to try the 2.6.23-rc3 kernel you suggest, since my
development shop is all standardized on the current FC release. I don't
want my machine to get out of sync with the rest of my team.

I think that I'll just tell my customer that he'll have to wait on more
than 16. After all, if the application can't accomplish what it wants
with 16 blueteeth, why do they need more ?

So, thanks for your help. I'm not going to waste any more time on this.

Regards,

Rich

e

-----Original Message-----
From: bluez-devel-bounces@lists.sourceforge.net
[mailto:bluez-devel-bounces@lists.sourceforge.net] On Behalf Of Marcel
Holtmann
Sent: Friday, August 24, 2007 10:26 AM
To: BlueZ development
Subject: Re: [Bluez-devel] Multiple Bluetooth Dongles

Hi Richard,

> In my case, I am not using the SCO feature. I haven't gotten that far 
> in my development.
> The steps I followed were:
> - boot my PC
> - modified the HCI_MAX_DEV to 30
> - ran make & make install
> - reboot ( probably not necessary, but what the heck ??)
> - plug in 16 Bluetooth USB dongles. All appear to work OK. For each of

> these, my Fedora Core 6 system pops up a small dialog box with "BlueZ
> (X) Switched device into connected mode"
> - plug in USB flash device. Works OK. 
> - plug in USB mouse. Works OK.
> - plug in Bluetooth dongle 17. No obvious response from the system.
> After a few seconds, the USB mouse no longer works. The keyboard no 
> longer works. A power down restart is required.
> 
> I realize that the test setup is tedious, but maybe you can point me 
> towards what to look for ??

load the hci_usb with isoc=0 and see how that works out. If not, then
that is an USB subsystem issue. Make sure you use 2.6.23-rc3.

Regards

Marcel



------------------------------------------------------------------------
-
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
