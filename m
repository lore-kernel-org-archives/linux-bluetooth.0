Return-Path: <cyrus@holtmann.org>
Subject: Re: Manufacturer ID
From: Marcel Holtmann <marcel@holtmann.org>
To: Krishnan R <r_krish@email.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <20081230011931.D0F1ABE4078@ws1-9.us4.outblaze.com>
References: <20081230011931.D0F1ABE4078@ws1-9.us4.outblaze.com>
Content-Type: text/plain
Date: Tue, 30 Dec 2008 02:45:11 +0100
Message-Id: <1230601511.15666.36.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Krishnan,

> hci_read_local_version gives the manufacturer of the BT chip. The same id is used in get_inquiry_mode to get the inquiry mode. But I am not seeing any details elsewhere regarding this. Mainly, I am concerned whether manufacturer can be used to find the BT chip make?

check the Bluetooth Assigned Number specification. It defines the
manufacturer id as a unique implementation of LMP. Normally this is done
by the chip manufacturers.

Regards

Marcel


