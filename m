Return-Path: <cyrus@holtmann.org>
Date: Mon, 9 Jun 2014 08:31:24 -0700
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: Linux Bluetooth mailing list <linux-bluetooth@vger.kernel.org>,
	marcel@hotlmann.org
Cc: johan.hedberg@gmail.com, gustavo@padovan.org
Subject: Question about HCI_QUIRK_RESET_ON_CLOSE
Message-ID: <20140609083124.1ea9e852@han1-desk-dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

I noticed that HCI_QUIRK_RESET_ON_CLOSE bit is used during stack initialization or device close exclusively.
If the bit is set, HCI_RESET is sent to the device during device close but not during stack initialization and vice versa when it is not set. I just wonder if there is any reason for doing it?

What do you recommend if HCI_RESET needs to be sent for both stack initialization case and device close?

Regards,

Tedd

