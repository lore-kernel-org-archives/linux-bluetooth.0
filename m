Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLPYQKtiSTfD-H1svLrSgOTmMuHyFhb0t673FgFEkYnmQ@mail.gmail.com>
References: <1312981596-7291-1-git-send-email-lucas.demarchi@profusion.mobi>
 <1312981596-7291-19-git-send-email-lucas.demarchi@profusion.mobi> <CABBYNZLPYQKtiSTfD-H1svLrSgOTmMuHyFhb0t673FgFEkYnmQ@mail.gmail.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Thu, 11 Aug 2011 08:23:36 -0300
Message-ID: <CAMOw1v4K-B-Aay4-iUYdhuv3VHqaMuaPOC70puR+mzn6QxCjiA@mail.gmail.com>
Subject: Re: [PATCH v3 18/22] avrcp: send response for registered events
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Aug 11, 2011 at 5:15 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Lucas,
>
> On Wed, Aug 10, 2011 at 4:06 PM, Lucas De Marchi
> <lucas.demarchi@profusion.mobi> wrote:
>>  static void mp_get_playback_status(struct media_player *mp, uint8_t *status,
>>                                        uint32_t *elapsed, uint32_t *track_len)
>>  {
>> @@ -754,6 +823,13 @@ static void mp_set_playback_status(struct control *control, uint8_t status,
>>                return;
>>
>>        mp->status = status;
>> +
>> +       if (control->state == AVCTP_STATE_CONNECTED &&  !control->target &&
>> +                       (control->registered_events &
>> +                               (1 << AVRCP_EVENT_PLAYBACK_STATUS_CHANGED))) {
>> +               avctp_send_event(control, AVRCP_EVENT_PLAYBACK_STATUS_CHANGED,
>> +                                                               &status);
>> +       }
>
> Are you sure it would be valid to call mp_set_playback_status when
> acting as a controller? Im afraid we should not cache anything, or

No it's not valid. But in all cases it's implemented in this patch
we're actually acting as target, not controller. The control->target
fields refers to the remote device.

> perhaps not even register MediaPlayer interface in case the device is
> a target.

We can't since MediaPlayer accepts commands before it's connected.

Lucas De Marchi
