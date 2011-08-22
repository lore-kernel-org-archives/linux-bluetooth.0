Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110822103632.GC9949@dell>
References: <201108201753.32608.dstockwell@frequency-one.com> <20110822103632.GC9949@dell>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Mon, 22 Aug 2011 11:38:01 -0300
Message-ID: <CAMOw1v5hBLFmntF6o8w0pzr3=H6nrxtSfE-48rzUabwNc_Tu-g@mail.gmail.com>
Subject: Re: [PATCH 3/3] AVRCP: Corrected metadata: Playing Time
To: David Stockwell <dstockwell@frequency-one.com>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan

On Mon, Aug 22, 2011 at 7:36 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:

>> @@ -196,7 +196,7 @@ enum media_info_id {
>>       MEDIA_INFO_TRACK =              4,
>>       MEDIA_INFO_N_TRACKS =           5,
>>       MEDIA_INFO_GENRE =              6,
>> -     MEDIA_INFO_CURRENT_POSITION =   7,
>> +     MEDIA_INFO_PLAYING_TIME =       7,
>>  };
>
> Would it make sense to add a MEDIA_INFO_LAST to the end of the above
> list and then instead of the following:

It makes sense since the spec reserve these values for future use.


>
>> -             for (i = 1; i <= MEDIA_INFO_CURRENT_POSITION; i++) {
>> +             for (i = 1; i <= MEDIA_INFO_PLAYING_TIME; i++) {
>>                       size = mp_get_media_attribute(control->mp, i,
>>                                                       &pdu->params[pos]);
>
> You'd have:
>
>        for (i = 1; i < MEDIA_INFO_LAST; i++) {
>
> Seems more readable to me at least and it'd make it easier to add new
> MEDIA_INFO types in the future (you only need to change the enum
> definition and protect yourself against forgetting to update both
> places).

right.

> Btw, it looked like this avrcp_handle_get_element_attributes function
> might not be properly checking the amount of actually received data in
> all necessary places before accessing the buffer (i.e. having the risk
> of remotely triggered buffer overflows). Could you please verify this
> and fix it if the issue really exists.

Yes, this is true. We can just fix this the easy way, but the right
approach would be to add the PDU continuation. The
avrcp_handle_get_element_attributes() is the only one as of now that
might trigger the buffer overflow. I'm adding this support and will
send it soon.


Thanks
Lucas De Marchi
