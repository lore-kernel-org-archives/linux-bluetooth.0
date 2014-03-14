Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140312114450.GE7489@localhost.P-661HNU-F1>
References: <1394406363-6751-1-git-send-email-lukasz.rymanowski@tieto.com>
	<1394406363-6751-6-git-send-email-lukasz.rymanowski@tieto.com>
	<20140312114450.GE7489@localhost.P-661HNU-F1>
Date: Fri, 14 Mar 2014 16:57:35 +0100
Message-ID: <CAMudyAu+je7VY3xqViiWEsoQOnJUdcdQKNr+RBAFfdPHaydYEg@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] emulator: Add handling inquiry_lenght from
 inquiry command
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 12 March 2014 12:44, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Lukasz,
>
> On Mon, Mar 10, 2014, Lukasz Rymanowski wrote:
>> --- a/emulator/btdev.c
>> +++ b/emulator/btdev.c
>> @@ -70,6 +70,7 @@ struct btdev {
>>       void *send_data;
>>
>>       int inquiry_id;
>> +     int inquiry_timeout_id;
>>       bool inquiry_cancel;
>>
>>       struct hook *hook_list[MAX_HOOK_ENTRIES];
>> @@ -133,6 +134,8 @@ struct inquiry_data {
>>
>>       int sent_count;
>>       int iter;
>> +
>> +     bool timeout;
>>  };
>>
>>  #define DEFAULT_INQUIRY_INTERVAL 100 /* 100 miliseconds */
>> @@ -711,6 +714,14 @@ static bool inquiry_callback(void *user_data)
>>       int sent = data->sent_count;
>>       int i;
>>
>> +     /* Check if inquiry timeout fired. */
>> +     if (data->timeout)
>> +             goto finish;
>> +
>> +     /*Report devices only once and wait for inquiry timeout*/
>> +     if (data->iter == MAX_BTDEV_ENTRIES)
>> +             return true;
>> +
>>       for (i = data->iter; i < MAX_BTDEV_ENTRIES; i++, data->iter++) {
>>               /*Lets sent 10 inquiry results at once */
>>               if (sent + 10 == data->sent_count)
>> @@ -771,14 +782,10 @@ static bool inquiry_callback(void *user_data)
>>                       data->sent_count++;
>>               }
>>       }
>> -
>>       /* Check if we sent already required amount of responses*/
>>       if (data->num_resp && data->sent_count == data->num_resp)
>>               goto finish;
>>
>> -     if (i == MAX_BTDEV_ENTRIES)
>> -             goto finish;
>> -
>>       return true;
>>
>>  finish:
>> @@ -806,16 +813,33 @@ static void inquiry_destroy(void *user_data)
>>       btdev->inquiry_cancel = false;
>>       btdev->inquiry_id = 0;
>>
>> +     if (btdev->inquiry_timeout_id)
>> +             timeout_remove(btdev->inquiry_timeout_id);
>> +
>> +     btdev->inquiry_timeout_id = 0;
>> +
>>  finish:
>>       free(data);
>>  }
>>
>> +static bool inquiry_timeout(void *user_data)
>> +{
>> +     struct inquiry_data *data = user_data;
>> +     struct btdev *btdev = data->btdev;
>> +
>> +     data->timeout = true;
>> +     btdev->inquiry_timeout_id = 0;
>> +
>> +     return false;
>> +}
>
> Instead of adding the new data->timeout variable why don't you simply
> send the inquiry_complete from within the inquiry_timeout callback?
>

True, will fix.
> Johan

\Lukasz
