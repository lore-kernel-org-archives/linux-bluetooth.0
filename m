Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140312113944.GC7489@localhost.P-661HNU-F1>
References: <1394406363-6751-1-git-send-email-lukasz.rymanowski@tieto.com>
	<1394406363-6751-4-git-send-email-lukasz.rymanowski@tieto.com>
	<20140312113944.GC7489@localhost.P-661HNU-F1>
Date: Fri, 14 Mar 2014 16:57:04 +0100
Message-ID: <CAMudyAvhAfn7tfF4Azz-+2f1Rd6p1zjRDWNkmn9BHOUY1jLC+g@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] emulator: Add inquiry cancel
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 12 March 2014 12:39, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Lukasz,
>
> On Mon, Mar 10, 2014, Lukasz Rymanowski wrote:
>> With this patch, scheduled inquiry session in btdev can be canceled
>>
>> Conflicts:
>>       emulator/btdev.c
>
> Seems like you forgot to clean up the commit message here.
Rather for sure :)
>
>> @@ -70,6 +70,7 @@ struct btdev {
>>       void *send_data;
>>
>>       int inquiry_id;
>> +     bool inquiry_cancel;
>>
>>       struct hook *hook_list[MAX_HOOK_ENTRIES];
>>
>> @@ -784,10 +785,20 @@ static bool inquiry_callback(void *user_data)
>>  static void inquiry_destroy(void *user_data)
>>  {
>>       struct inquiry_data *data = user_data;
>> +     struct btdev *btdev = data->btdev;
>> +     uint8_t status = BT_HCI_ERR_SUCCESS;
>> +
>> +     if (!btdev)
>> +             goto finish;
>>
>> -     if (data->btdev)
>> -             data->btdev->inquiry_id = 0;
>> +     if (btdev->inquiry_cancel)
>> +             cmd_complete(btdev, BT_HCI_CMD_INQUIRY_CANCEL, &status,
>> +                                                     sizeof(status));
>>
>> +     btdev->inquiry_cancel = false;
>> +     btdev->inquiry_id = 0;
>> +
>> +finish:
>>       free(data);
>>  }
>>
>> @@ -820,6 +831,20 @@ error:
>>       send_event(btdev, BT_HCI_EVT_INQUIRY_COMPLETE, &ic, sizeof(ic));
>>  }
>>
>> +static void inquiry_cancel(struct btdev *btdev)
>> +{
>> +     uint8_t status = BT_HCI_ERR_COMMAND_DISALLOWED;
>> +
>> +     if (!btdev->inquiry_id) {
>> +             cmd_complete(btdev, BT_HCI_CMD_INQUIRY_CANCEL, &status,
>> +                                                     sizeof(status));
>> +             return;
>> +     }
>> +
>> +     btdev->inquiry_cancel = true;
>> +     timeout_remove(btdev->inquiry_id);
>
> This whole btdev->inquiry_cancel variable seems pointless to me. Why
> don't you simply send the cmd_complete for it after calling
> timeout_remove here in the inquiry_cancel function?

Well you are actually right here. I will get destroy in the same
mainloop iteration anywa. Will fix it.

>
> Johan

Lukasz
