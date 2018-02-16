Return-Path: <amitkarwar@gmail.com>
MIME-Version: 1.0
In-Reply-To: <87r2po6gts.fsf@kamboji.qca.qualcomm.com>
References: <1513168977-2121-1-git-send-email-amitkarwar@gmail.com>
 <1513168977-2121-5-git-send-email-amitkarwar@gmail.com> <87r2q5mc4x.fsf@purkki.adurom.net>
 <CAEhWJF=iF4Gy65O3vUNtBrKcXBMpSnCuZgvpCDvuObkgf4zuaA@mail.gmail.com> <87r2po6gts.fsf@kamboji.qca.qualcomm.com>
From: Amitkumar Karwar <amitkarwar@gmail.com>
Date: Fri, 16 Feb 2018 20:16:02 +0530
Message-ID: <CAEhWJFmdr-PU5=8nO73km--fR+L8gTtP+qqpy4M47QqSGzabEQ@mail.gmail.com>
Subject: Re: [v5 4/8] rsi: add coex support
To: Kalle Valo <kvalo@codeaurora.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-wireless <linux-wireless@vger.kernel.org>,
	Amitkumar Karwar <amit.karwar@redpinesignals.com>,
	Prameela Rani Garnepudi <prameela.j04cs@gmail.com>,
	"open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
	Siva Rebbagondla <siva.rebbagondla@redpinesignals.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Feb 13, 2018 at 9:07 PM, Kalle Valo <kvalo@codeaurora.org> wrote:
> Amitkumar Karwar <amitkarwar@gmail.com> writes:
>
>> On Thu, Feb 1, 2018 at 12:26 PM, Kalle Valo <kvalo@codeaurora.org> wrote:
>>> Amitkumar Karwar <amitkarwar@gmail.com> writes:
>>>
>>>> From: Prameela Rani Garnepudi <prameela.j04cs@gmail.com>
>>>>
>>>> With BT support, driver has to handle two streams of data
>>>> (i.e. wlan and BT). Actual coex implementation is in firmware.
>>>> Coex module just schedule the packets to firmware by taking them
>>>> from the corresponding paths.
>>>>
>>>> Structures for module and protocol operations are introduced for
>>>> this purpose. Protocol operations structure is global structure
>>>> which can be shared among different modules. Initialization of
>>>> coex and operating mode values is moved to rsi_91x_init().
>>>>
>>>> Signed-off-by: Prameela Rani Garnepudi <prameela.j04cs@gmail.com>
>>>> Signed-off-by: Siva Rebbagondla <siva.rebbagondla@redpinesignals.com>
>>>> Signed-off-by: Amitkumar Karwar <amit.karwar@redpinesignals.com>
>>>
>>> [...]
>>>
>>>> @@ -270,6 +271,7 @@ struct rsi_common {
>>>>       u8 obm_ant_sel_val;
>>>>       int tx_power;
>>>>       u8 ant_in_use;
>>>> +     struct semaphore tx_bus_lock;
>>>
>>> Do you really need to use semaphore? I think nowadays the preference is
>>> to use something other than semaphores.
>>
>> We used semaphore here, as USB/SDIO bus write operations could be
>> blocking/waiting. I will check if spinlock suits here in follow up
>> patch. It will need some testing.
>
> I was more thinking about using a mutex.

Right. mutex would be better option. I will submit updated version
with this change

Regards,
Amitkumar Karwar
