Return-Path: <cyrus@holtmann.org>
Message-ID: <479F707B.2010001@wurmsdobler.org>
Date: Tue, 29 Jan 2008 18:29:15 +0000
From: Peter Wurmsdobler <peter@wurmsdobler.org>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <OF57915B80.8FBC7A49-ON802573DF.003F8EDF-802573DF.003FEE1C@camcon.co.uk>
	<200801291235.37973.chick@computergeek.freeserve.co.uk>
In-Reply-To: <200801291235.37973.chick@computergeek.freeserve.co.uk>
Subject: Re: [Bluez-users] mx27, csr and bluez: initialisation timed out
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hello,

> hciattach /dev/ttyS0 bcsp
> bccmd -t HCI psload -r my.psr
> killall hciattach
> hciattach /dev/ttyS0 bcsp

When the BC4-ROM is powered up, it does not know the values for certain 
keys, such as:

	PSKEY_LC_COMBO_DOT11_CHANNEL_PIO_BASE
	PSKEY_UART_BAUDRATE
	PSKEY_ANA_FREQ

So I connected the apm module (with the BC4-ROM in it) to the WindowsXP 
host, powered it up, then used the PStool to convince myself that this 
is true. Indeed it is.

Then I downloaded a socalled psr file containing these keys, and indeed, 
the values for these keys were differend. So the download must have worked.

Having power cycled the module, I tried once more on Linux:

peter@linuxpc:~$ hciattach /dev/ttyS0 bcsp
peter@linuxpc:~$ hciconfig
hci0:   Type: UART
         BD Address: 00:02:5B:00:A5:A5 ACL MTU: 310:10 SCO MTU: 64:8
         UP RUNNING PSCAN ISCAN
         RX bytes:1058 acl:0 sco:0 events:22 errors:0
         TX bytes:684 acl:0 sco:0 commands:21 errors:0

peter@linuxpc:~$ bccmd -t HCI psload -r apm6628BT-UART.psr
Loading PSKEY_LC_COMBO_DISABLE_PIO_MASK ... failed
Loading PSKEY_LC_COMBO_DOT11_CHANNEL_PIO_BASE ... failed
Loading PSKEY_LC_ENHANCED_POWER_TABLE ... failed
Loading PSKEY_UART_BAUDRATE ... failed
Loading PSKEY_HOST_INTERFACE ... failed
Loading PSKEY_ANA_FREQ ... failed
Loading PSKEY_USE_EXTERNAL_CLOCK ... failed
Loading PSKEY_CLOCK_REQUEST_ENABLE ... failed
Loading PSKEY_CLOCK_REQUEST_FEATURES ... failed
peter@linuxpc:~$ bccmd -t bcsp psload -r apm6628BT-UART.psr
Initialization timed out

Apparently, on linux I cannot establish a reliable connection and 
download the settings.

Any ideas?
peter

--
apm6628BT-UNIF.psr:

// PSKEY_LC_COMBO_DISABLE_PIO_MASK
&0028 = 0200
// PSKEY_LC_COMBO_DOT11_CHANNEL_PIO_BASE
&002a = 0011
// PSKEY_LC_ENHANCED_POWER_TABLE
&0031 = 0400 0000 3f00 4500 e800 0900 0000 3f00 4700 ec00 0f00 0000 3f00 
4a00 f000 1600 0000 3f00 4d00 f400 1e00 0000 3f00 5000 f800 2600 0000 
3f00 5500 fc00 2e00 0000 3f00 5b00 0000 5000 0000 3f00 6900 0400
// PSKEY_UART_BAUDRATE
&01be = 01d8// 115.2 kbaud
// PSKEY_HOST_INTERFACE
&01f9 = 0001// BCSP link
// PSKEY_ANA_FREQ
&01fe = 4e20
//PSKEY_USE_EXTERNAL_CLOCK
&023b = 0001//true
//PSKEY_CLOCK_REQUEST_ENABLE
&0246 = 0003
// PSKEY_CLOCK_REQUEST_FEATURES
&03b6 = 0000


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
