Return-Path: <cyrus@holtmann.org>
Date: Tue, 9 Dec 2014 11:01:20 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC v4 1/2] Bluetooth: Add le_scan_restart
Message-ID: <20141209090120.GA5965@t440s.lan>
References: <1417823005-10262-1-git-send-email-jpawlowski@google.com>
 <C08D7D21-92B7-468D-A630-A744738AA400@holtmann.org>
 <CAD0=r8yUn0Z6dQ7XgzpwFysB0Km+q4_cOFU2JfOOs7=3Kd+XOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAD0=r8yUn0Z6dQ7XgzpwFysB0Km+q4_cOFU2JfOOs7=3Kd+XOw@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Tue, Dec 09, 2014, Jakub Pawlowski wrote:
> > Same as we should check for HCI_QUIRK_STRICT_DUPLICATE_FILTER
> > setting and only do the restart scan stuff if the driver told us
> > that this controller is not providing multiple reports.
> 
> So I did some tests on 4 controllers I described in this email:
> http://marc.info/?l=linux-bluetooth&m=141764424929887&w=2
> I think that HCI_QUIRK_STRICT_DUPLICATE_FILTER wil be valid if we were
> doing HCI_OP_INQUIRY, when I was using HCI_OP_LE_SET_SCAN_ENABLE with
> LE_SCAN_FILTER_DUP_ENABLE none of the controllers I used reported
> device twice with different RSSI except for marevell, which seems to
> ignore
> LE_SCAN_FILTER_DUP_ENABLE, and reports all advertisements.
> 
> The way I conducted this tests was to start the scan "tools/mgmt find
> -l", and try to approach (15-20 meters) or move away from scanning
> device, walk back and forth, or just keep the advertiser in place. I
> was monitoring both btmgmt output and dmesg kernel logs (I added some
> additional BT_INFO to make sure I won't miss anything)
> 
> Do you have different experience for LE scan ? Or maybe I just picked
> wrong controllers for my tests ?

Please add CSR dongles to your mix. The most commonly available one is
probably the PTS dongle. They also report multiple advertisements as the
RSSI changes.

Johan
