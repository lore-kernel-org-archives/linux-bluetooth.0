Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Fri, 24 Aug 2007 10:08:02 -0400
Message-ID: <2EB6297382462046A9427D7324788A480217D756@MCLNEXVS06.resource.ds.bah.com>
In-Reply-To: <1187957692.15402.149.camel@violet>
References: <2EB6297382462046A9427D7324788A480217D35A@MCLNEXVS06.resource.ds.bah.com>
	<1187957692.15402.149.camel@violet>
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

In my case, I am not using the SCO feature. I haven't gotten that far in
my development. 
The steps I followed were:
- boot my PC
- modified the HCI_MAX_DEV to 30
- ran make & make install
- reboot ( probably not necessary, but what the heck ??)
- plug in 16 Bluetooth USB dongles. All appear to work OK. For each of
these, my Fedora Core 6 system pops up a small dialog box with "BlueZ
(X) Switched device into connected mode"
- plug in USB flash device. Works OK. 
- plug in USB mouse. Works OK.
- plug in Bluetooth dongle 17. No obvious response from the system.
After a few seconds, the USB mouse no longer works. The keyboard no
longer works. A power down restart is required.

I realize that the test setup is tedious, but maybe you can point me
towards what to look for ??

Thanks for all your help. Best Regards,

Rich


-----Original Message-----
From: bluez-devel-bounces@lists.sourceforge.net
[mailto:bluez-devel-bounces@lists.sourceforge.net] On Behalf Of Marcel
Holtmann
Sent: Friday, August 24, 2007 8:15 AM
To: BlueZ development
Subject: Re: [Bluez-devel] Multiple Bluetooth Dongles

Hi Richard,

> I have a system that uses multiple Bluetooth dongles and works just 
> fine. I've had my system running with several USB hubs and up to the
> 16 maximum devices that Bluez supports. Now I have a changing 
> requirement from my customer to handle more than 16 Bluetooth devices.
> They want support for up to 30 Bluetooth devices.
>  
> I changed the HCI_MAX_DEV in bluez_libs/include/hci.h from 16 to 30, 
> recompiled and installed bluez_libs and bluez_utils. No problem.
>  
> My program works fine with up to 16 Bluetooth devices, but the 17th 
> device is not recognized and sometimes the entire USB will no longer 
> work.

we might broke something here since I haven't tested this in quite a
while. Mainly because I don't care so much anymore. Having these kind of
test setups are nasty.

The USB part can be an issue if you use the SCO support of the hci_usb
driver. Load the driver with isoc=0 to disable it. The ISOC frames for
the SCO support consume to much USB bandwidth.

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
