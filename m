Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: Creating a separate event node for each device composite
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAKafyqrZNx9RPznO3Skon3hzV=AnXSuP4v0nucuS2mESpxdoEw@mail.gmail.com>
Date: Thu, 21 Jan 2016 12:05:40 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <08F5A725-03E6-4A4B-BE5D-0820AA520C03@holtmann.org>
References: <CAKafyqrZNx9RPznO3Skon3hzV=AnXSuP4v0nucuS2mESpxdoEw@mail.gmail.com>
To: Prabhu Chawandi <foss.chaws@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Prabhu,

>  Is it possible to make Linux to create a separate /dev/input/eventX
> node for all the device composited ?
> 
> Example: if my device is supporting Mouse, KBD and Consumer
> 
> if I want to create three event nodes for each, like /dev/input/event1
> /dev/input/event2 /dev/input/event3.
> 
> is it allowed in BT HIDP ? Please help me to understand..

that is more a question for linux-input since it is HID related. Bluetooth is just transporting the HID reports. It is not interpreting them or creating the actually input devices.

Regards

Marcel


