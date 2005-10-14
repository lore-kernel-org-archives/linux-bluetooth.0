Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <434FC9D3.30302@csr.com>
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] indication of Class 1 or Class 2 devices
References: <8664s05ro4.fsf@coulee.tdb.com> <EXCHANGE03LjtVhvob600005bd1@exchange03.csr.com>
In-Reply-To: <EXCHANGE03LjtVhvob600005bd1@exchange03.csr.com>
Content-Type: text/plain; charset=us-ascii
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 14 Oct 2005 16:08:03 +0100

Peter Stephenson wrote:
> Russell Senior wrote:
>> Is there a way, via /proc or /sys or something to discover whether a
>> bluetooth device is Class 1 (100m) or Class 2 (10m)?
> 
> It's actually pretty difficult even if you have low level access to
> the device, never mind via the OS.  There's no standardised way of
> providing the information, and in the simplest case the module
> manufacturer may simply have stuck a power amplifier onto the
> transmitter.  If they do that they are supposed to provide
> enough information for the device to support power control, however,
> so if you can get access to that information you should be able to tell.

In theory, there's the HCI command Read_Transmit_Power_Level. Once a
link is up it should tell you the current power level and the maximum
power level.

If the remote device doesn't support power control then the local
device will be limited to class 2 power even if it supports class 1.

Of course, this assumes that the module manufacturer has entered the
correct numbers in the configuration data in the module. If they've
stuch a power amplifier on and not updated the data then the chip may
be reporting the power before the power amplifier.

> If it's a CSR device, you can find an interface to persistent store and
> look at PSKEY_LC_POWER_TABLE (0x001e) or PSKEY_LC_ENHANCED_POWER_TABLE (for
> devices with EDR, 0x0031).

The BCCMD max_tx_power (0x6827) might do the right thing on some
versions of firmware.

	- Steven
-- 


This message has been scanned for viruses by BlackSpider MailControl - www.blackspider.com


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
