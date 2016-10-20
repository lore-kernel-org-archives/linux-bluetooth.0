Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
From: Naresh <kbn456@gmail.com>
Subject: Write queue is not processed after last write was not proper
Message-ID: <580891D0.5000705@gmail.com>
Date: Thu, 20 Oct 2016 15:13:44 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I've been writing ble client application using latest bluez version 
(5.42) and based on gatttool. We have some different requirement, so we 
didn't used D-Bus based API's as its not implement with D-BUS API's, 
Like we wanted to disable filter duplicate to receive all the 
advertisement(Even all the parameters are same) for proximity check and 
than connect and pair.

We have used HCI layer api for getting advertisement with filter 
duplicate disabled and based on the BD address we connect using the Btio 
layer API than used gattrib API to perform read/write/Notification 
confirmation operations.

We are performing some write/write_without operation continuously based 
on request by the our app(it kind of stress test) but after some write, 
its gets stuck I mean write queue is not being processed, there is no 
ATT logs once write is failed (returning some negative id) but write are 
being queued.

We have debugged this issue in bluez and found that once wakeup_writer 
sets the io_set_write_handler for queued operation than set 
writer_active to true, after that write is performed and destroyer 
callback will set writer_active back to false.

But in failed case before wakeup_writer being set writer_active to true, 
the write and destroy operation are being processed i.e writer_active 
never set to false and io_set_write_handler are never set for upcoming 
operations.

I don't know what causing this scenario.

Thanks in advance for any suggestion/any comments.

Regards,
Naresh K
