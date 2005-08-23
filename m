Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <430B477E.4050503@gmx.de>
From: Christian Reiser <r.christian@gmx.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Suspend locks up usb
References: <Pine.LNX.4.63.0508230921130.9834@Magrathea>
In-Reply-To: <Pine.LNX.4.63.0508230921130.9834@Magrathea>
Content-Type: text/plain; charset=us-ascii
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
Date: Tue, 23 Aug 2005 17:57:50 +0200

Hi Marcel,

Marcel Holtmann wrote:
> I can't tell you anything about the APM. Did you tried to use ACPI?

Sorry, this is a Thinkpad 600e (400 Mhz, PII). APM is working well -
ACPI won't.

> What kernel version is this?

Linux version 2.6.12-mh2

> However to unload you module you need to do a "hciconfig hci0 down"
> first. This will deactivate the interface.

Okay - did not know this. But it does not entirely solve my problem. The
bluetooth modules can be unloaded after executing hciconfig - USB is
still dead. Syslog:
Aug 23 10:20:35 alpha uhci_hcd 0000:00:07.2: Unlink after no-IRQ?
Controller is probably using the wrong IRQ.
Aug 23 10:20:41 alpha usbcore: deregistering driver hci_usb

Anyway. I borrowed an USB-Memorydevice and suspended... same problem.


So: This is not a bluez-bug.
============================


Sorry Guys - i will look for the USB-developers list ;-)


Thanks for your help && Ciao
	Christian


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
