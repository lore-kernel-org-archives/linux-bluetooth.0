Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <20060530140840.52436.qmail@web50504.mail.yahoo.com>
References: <20060530140840.52436.qmail@web50504.mail.yahoo.com>
Date: Tue, 30 May 2006 16:18:55 +0200
Message-Id: <1148998735.11251.3.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Transmit Power Level (TPL)
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Mahtab,

> I have been trying to work on the various signal strength values
> (RSSI, LQ & TPL) for quite sometime now. Though I am successful in
> getting RSSI & link quality (LQ) for my dongles (from both hcitool
> command & my own program), I always get Transmit Power level (TPL) as
> 0 - I have tested in various distances.
> My dongles are either ISSC or Broadcom-based (no CSR dongles) - all of
> them support "power-control" feature.

maybe ISSC and Broadcom simply don't implement it correct. Get yourself
a CSR based dongle and retest.

> And Marcel, I had also digged your code and saw that, you take a
> parameter for transmit power level calculation (the "type" field) in
> "hci_read_transmit_power_level" function and you set the parameter as:
> type = (argc>1) ? atoi(argv[1]) : 0;

Why don't you read the specification. If you give it 0 it will request
the current power level and with 1 it request the maximum power level.

> Finally, I only see "Get_Link_Quality" and "Read_RSSI" in bluetooth
> specification 1.0.B - no mention of "Transmit Power Level" there. My
> dongles are bluetooth 1.2, so, is there a possibility that they didn't
> provide transmit_power_level status value similar to that previous
> specification.

You should double check with "hcidump -X -V" that they really not report
and error and hcitool is doing it wrong. But it can happen that they
didn't actually implement transmit power level at all and they always
return the value 0.

> I think bluetooth specification 1.0.B is the free one available till
> now. If later versions are available, could anyone please provide me
> the link.

The current Bluetooth specification is version 2.0 and you should always
use this one.

Regards

Marcel




_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
