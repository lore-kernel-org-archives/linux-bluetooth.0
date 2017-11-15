Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Wed, 15 Nov 2017 19:44:19 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: John Klug <ski.brimson@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: When can I trust with bluetoothctl and 5.47?
Message-ID: <20171115174419.GA1019@x1c.home>
References: <CADU0VqzNOZraF0Gptccz+Hu=1mZEc4ki9Nm96Spexf4h6M2wfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CADU0VqzNOZraF0Gptccz+Hu=1mZEc4ki9Nm96Spexf4h6M2wfg@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi John,

On Wed, Nov 15, 2017, John Klug wrote:
> Over and over again it says device is not available.  When does it
> become available?  Is there a way to do this deterministically?  I
> quickly entered trust (it was saved from previous executions
> unsuccessfully) after pairing.  Then after connecting, all to no
> avail.
> 
> Is there documentation on this?
> 
> The remote in this case is Broadcom 6.5.1.6000 stack.
> 
> [agent] Confirm passkey 702629 (yes/no): yes
> [CHG] Device 5C:F3:70:74:04:AF UUIDs: 00001000-0000-1000-8000-00805f9b34fb
> [CHG] Device 5C:F3:70:74:04:AF UUIDs: 00001115-0000-1000-8000-00805f9b34fb
> [CHG] Device 5C:F3:70:74:04:AF ServicesResolved: yes
> [CHG] Device 5C:F3:70:74:04:AF Paired: yes
> [John Conduit Klug (SGH-M919)]# trust  5C:F3:70:74:04:AF
> Device  5C:F3:70:74:04:AF not available

I think bluetoothctl has a bug where it doesn't strip whitespace from
the beginning of arguments. In your case you have two spaces between
trust and the address. Try removing one.

Johan
