Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Thomas Green <TGreen2@Sorenson.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: porting to bluez5
Date: Tue, 14 Nov 2017 17:38:40 +0000
Message-ID: <C2BC44D770753C45AAAC42695FB5BE020125718A8C@SLC-EXMB01.CORP.SRELAY.COM>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As a follow up to my question before, one of the devices that I'm testing w=
ith is a Jawbone by Jambox.  In bluez 4.101 when the device would come back=
 into range it would re-connect and be available for use.  Currently it con=
nects and in about 700 milliseconds btmon says the remote user terminated t=
he connection.  Not sure why this would be.   Again, this device worked fin=
e in bluez4.101.   btmon log for this connection is found at https://pasteb=
in.com/bkYbNURy

Any clues?  And again, what should I use to send a ring indication to a hea=
dset device as the Alert1 interface has been deprecated?

Tom
