Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Subject: Re: [BUG] HCI_RESET and Num_HCI_Command_Packets limit
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAGd9gwhd4DuEw_jHJAZF99YwNT==-s9yW6KEkZ_A2w+eeFy88w@mail.gmail.com>
Date: Wed, 19 Jun 2013 21:04:16 -0400
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	keybuk <keybuk@chromium.org>
Message-Id: <6D8CE567-F4C5-42BE-8E0E-5D558E9C439D@holtmann.org>
References: <CAGd9gwhd4DuEw_jHJAZF99YwNT==-s9yW6KEkZ_A2w+eeFy88w@mail.gmail.com>
To: Alex Deymo <deymo@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

> I'm experiencing a problem that wedges the bluetooth adapter from time
> to time. The repro case can be hit with this scenario:
> 
> run bluetoothd
> while hciconfig hci0 up && hciconfig hci0 down; do echo -n .; done
> 
> In few iterations you will have a timeout while trying to bring up the
> interface. This is just a repro case, the real scenario just happens
> from time to time if you for instance restart bluetoothd at the right
> (or wrong!) moment.

can you give us at least a few details on the kernel you are running and what hardware this is?

If you do not use hciconfig and instead use btmgmt or bluetoothctl, do you see the same issue?

Regards

Marcel

