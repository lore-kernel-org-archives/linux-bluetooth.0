Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZKZGX54FnUPEZWM_4A+5otRHk+wyA-xhppfD8FeZckMjg@mail.gmail.com>
References: <1391709250-8047-1-git-send-email-andrzej.kaczmarek@tieto.com>
	<1391709250-8047-5-git-send-email-andrzej.kaczmarek@tieto.com>
	<CABBYNZKZGX54FnUPEZWM_4A+5otRHk+wyA-xhppfD8FeZckMjg@mail.gmail.com>
Date: Fri, 7 Feb 2014 11:58:28 +0200
Message-ID: <CABBYNZJQ0+8LJfi5h11KMjJg6XCNF-uJERfLF-N4tDzYm+cGLg@mail.gmail.com>
Subject: Re: [PATCH 5/6] android/a2dp: Disconnect headset on IPC failure
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Fri, Feb 7, 2014 at 11:45 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Andrzej,
>
> On Thu, Feb 6, 2014 at 7:54 PM, Andrzej Kaczmarek
> <andrzej.kaczmarek@tieto.com> wrote:
>> In case audio IPC is suddenly disconnected (most likely due to crash of
>> mediaserver process) we should disconnect headset since it is no longer
>> associated with valid setup and cannot be used properly.
>> ---
>>  android/a2dp.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/android/a2dp.c b/android/a2dp.c
>> index 8eabfeb..f67a593 100644
>> --- a/android/a2dp.c
>> +++ b/android/a2dp.c
>> @@ -1515,6 +1515,7 @@ static gboolean audio_retry_register(void *data)
>>
>>  static void audio_disconnected(void *data)
>>  {
>> +       GSList *l;
>>         bool restart;
>>
>>         DBG("");
>> @@ -1526,6 +1527,12 @@ static void audio_disconnected(void *data)
>>
>>         bt_audio_unregister();
>>
>> +       for (l = devices; l; l = g_slist_next(l)) {
>> +               struct a2dp_device *dev = l->data;
>> +
>> +               avdtp_shutdown(dev->session);
>> +       }
>> +
>>         if (!restart)
>>                 return;
>
> If we are unregistering the endpoints properly this should not happen,
> perhaps what is wrong is avdtp_unregister_sep is not aborting existing
> streams properly. Btw we should probably add a unit test if this is
> happening in practice because otherwise the remote won't notice.

I checked the code and actually this should not be a problem since we
drop the stream transport connection it should indicate a unclean
abort as it should be, in the past we had many times this happening
with PA crashing and it seems the headsets react properly to the
stream transport dropping unexpectedly, we can still do abort though.


-- 
Luiz Augusto von Dentz
