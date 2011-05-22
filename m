Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Sun, 22 May 2011 19:04:52 -0400
Message-ID: <BANLkTin-eQtJ0wQKqw0iowk6kQt875FHyA@mail.gmail.com>
Subject: Hack for getting Bluetooth to work on 2.6.39
From: Corey Boyle <corey.j.boyle@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi

I recently upgraded my kernel from 2.6.38 to 2.6.39 and my bluetooth
adapter stopped working. By not working I mean that running hciconfig
hci0 up i received the following error: "Can't init device hci0:
Invalid argument (22)".  I managed to figure out that the
HCI_OP_SET_EVENT_MASK command was returning EINVAL. I commented out
the recently added call to hci_setup_event_mask in hci_event.c and now
it is working fine on 2.6.39. I know this is a hack, but wanted to
know what can be done to have a proper solution put in place.  I'm not
an expert on Bluetooth by any means but I can make the changes with
guidance or test out patches.  (By the way my adapter is a Microsoft
Wireless Transceiver for Bluetooth, the original version not 2.0.)
Also, I havent checked but this may solve the issue from the following
thread: https://lkml.org/lkml/2011/4/18/481.

Thanks
Corey
