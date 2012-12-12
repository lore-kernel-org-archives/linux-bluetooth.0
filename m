Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_NryAHYHPXBTFfy7Z-p7r4peH5Lr6qQgKdV8-9zeMx-=w@mail.gmail.com>
References: <1355308088-9080-1-git-send-email-szymon.janc@tieto.com>
	<1355308088-9080-12-git-send-email-szymon.janc@tieto.com>
	<CAJdJm_NryAHYHPXBTFfy7Z-p7r4peH5Lr6qQgKdV8-9zeMx-=w@mail.gmail.com>
Date: Wed, 12 Dec 2012 08:55:46 -0400
Message-ID: <CAJdJm_M6cors5nxsbx7RCAiSTQsMscYGhPFXWZmDstrEab5hQw@mail.gmail.com>
Subject: Re: [PATCH 11/16] avctp: Convert register/unregister to accept btd_adapter
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Dec 12, 2012 at 8:52 AM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> Hi Szymon,
>
> On Wed, Dec 12, 2012 at 6:28 AM, Szymon Janc <szymon.janc@tieto.com> wrote:
>> @@ -1129,13 +1129,18 @@ static void avctp_confirm_cb(GIOChannel *chan, gpointer data)
>>
>>         DBG("AVCTP: incoming connect from %s", address);
>>
>> -       session = avctp_get_internal(&src, &dst);
>> +       device = adapter_find_device(manager_find_adapter(&src), address);
>> +       if (!device)
>> +               return;
>> +
>> +       session = avctp_get_internal(device);
>>         if (session == NULL)
>>                 return;
>>
>> -       dev = manager_get_device(&src, &dst, FALSE);
>> +       dev = manager_get_device(&src, device_get_address(device), FALSE);
>>         if (!dev) {
>> -               dev = manager_get_device(&src, &dst, TRUE);
>> +               dev = manager_get_device(&src, device_get_address(device),
>> +                                                                       TRUE);
>>                 if (!dev) {
>>                         error("Unable to get audio device object for %s",
>>                                         address);
>
> The snippet above looks strange. You already have the device, why call
> manager_get_device() again? Looks like to me a bunch of this code can
> be removed and the error message above could be moved to the if()
> after adapter_find_device().

Ignore that, now I see "manager_get_device()" returns a audio device,
not btd_device :)

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
