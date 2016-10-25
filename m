Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: Write queue is not processed after last write was not proper
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <580891D0.5000705@gmail.com>
 <CABBYNZ+ccawCjfQVrS5Zvu4M5=N-_Mz_ozLr-Kz8YcF75DuJ5g@mail.gmail.com>
 <580E24BF.6000206@gmail.com>
 <CABBYNZJNC5pRR-uu6x6kLYzTPCzwqG3B8AWUJB2PHc287mQK4Q@mail.gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: Naresh <kbn456@gmail.com>
Message-ID: <580F7371.6030605@gmail.com>
Date: Tue, 25 Oct 2016 20:30:01 +0530
MIME-Version: 1.0
In-Reply-To: <CABBYNZJNC5pRR-uu6x6kLYzTPCzwqG3B8AWUJB2PHc287mQK4Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi  Luiz,

On Monday 24 October 2016 09:33 PM, Luiz Augusto von Dentz wrote:
> Hi Naresh,
>
> On Mon, Oct 24, 2016 at 6:11 PM, Naresh <kbn456@gmail.com> wrote:
>> On Thursday 20 October 2016 03:28 PM, Luiz Augusto von Dentz wrote:
>> Hi Luiz,
>>> Hi Naresh,
>>>
>>> On Thu, Oct 20, 2016 at 12:43 PM, Naresh <kbn456@gmail.com> wrote:
>>>> Hi,
>>>>
>>>> I've been writing ble client application using latest bluez version
>>>> (5.42)
>>>> and based on gatttool. We have some different requirement, so we didn't
>>>> used
>>>> D-Bus based API's as its not implement with D-BUS API's, Like we wanted
>>>> to
>>>> disable filter duplicate to receive all the advertisement(Even all the
>>>> parameters are same) for proximity check and than connect and pair.
>>>>
>>>> We have used HCI layer api for getting advertisement with filter
>>>> duplicate
>>>> disabled and based on the BD address we connect using the Btio layer API
>>>> than used gattrib API to perform read/write/Notification confirmation
>>>> operations.
>>> gattrib API is deprecated, you should use what is under src/shared
>>> since that is what we unit test.
>> Yes, Now we have migrated and used API's under src/shared for read/Write.
>>>> We are performing some write/write_without operation continuously based
>>>> on
>>>> request by the our app(it kind of stress test) but after some write, its
>>>> gets stuck I mean write queue is not being processed, there is no ATT
>>>> logs
>>>> once write is failed (returning some negative id) but write are being
>>>> queued.
>>>>
>>>> We have debugged this issue in bluez and found that once wakeup_writer
>>>> sets
>>>> the io_set_write_handler for queued operation than set writer_active to
>>>> true, after that write is performed and destroyer callback will set
>>>> writer_active back to false.
>>>>
>>>> But in failed case before wakeup_writer being set writer_active to true,
>>>> the
>>>> write and destroy operation are being processed i.e writer_active never
>>>> set
>>>> to false and io_set_write_handler are never set for upcoming operations.
>>>>
>>>> I don't know what causing this scenario.
>>> I guess the first thing to do is to attempt to reproduce with
>>> bt_gatt_client API and have HCI traces so we can see where it fails,
>>> perhaps it is even disconnecting in the meantime, but it shouldn't
>>> queue them up.
>>>
>> But we are still facing the same problem with write, Please find an
>> attachment of hci trace logs and write logs.
> Yep, good luck scanning and transferring data at same time, about half
> of the logs are just reports you get from scanning. Btw APIs such as
> bt_gatt_client_write_without_response return unsigned int so it can
> never be a negative id, either you are printing as a signed or there
> is something else perhaps out of memory, bottom line is if it fails it
> should return 0.
>
Below are the scenario's observed while running the stress test,
1) In the success case: "write without response" will internally calls 
bt_att_send(bluez version:5.42 file:src/shared/att.c, line:1206) there 
it will create att_send_op instance(op) and pushes op into write queue 
then calls the wakeup_writer() and returns op->id. afterwards 
can_write_data pops data from queue(mainloop thread context) and calls 
io_send method. After the successful write op instance will be destroyed.

2)But in failure case: after wakeup_writer() is called and before 
returning the proper op->id, can_write_data gets scheduled from mainloop 
thread context and op instance is destroyed. So bt_att_send returns 
garbage op id, because of this att->writer_active flag is also 
corrupted(writer_active remains in true) which doesn't allow any further 
calling of io_set_write_handler to schedule write operation.

We ran the test after disabling scan(once client is connected) but still 
same problem is observed.

Thanks in advance for any suggestions/comments.


Regards,
Naresh K
