Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Configure supervision timeout
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CA+ZaN38pJ-2FM9t8c+sOT+ViXvYA79YgUe=ispYKVQwZiQW0ZQ@mail.gmail.com>
Date: Tue, 28 Jun 2016 16:36:08 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <370D4E27-437D-4AFC-A463-B4AB8599CEB5@holtmann.org>
References: <CA+ZaN38pJ-2FM9t8c+sOT+ViXvYA79YgUe=ispYKVQwZiQW0ZQ@mail.gmail.com>
To: Seulki Shin <sskcorea@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Seulki,

> Recently, I have noticed supervision timeout is not enough to pair devices.
> 
> How can I configure supervision timeout? Is there any configuration file?
> 
> First, I have checked "main.conf" but I couldn't find any related properties.
> I also found /sys/kernel/debug/bluetooth/hci0 has a bunch of system settings.
> But I am not sure editing those files is a right approach.

the supervision timeout will trigger if the baseband will not even ack packets. A longer timeout is most likely not going to help you either to pair. Why do you think it would?

Can you provide btmon traces to see why a disconnect is happening?

Regards

Marcel

