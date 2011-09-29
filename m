Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLZ1skFismkBGxLksR6Dg0AbLSCrO+uW22QZXzOWGBeeg@mail.gmail.com>
References: <1317316050-12855-1-git-send-email-lucas.demarchi@profusion.mobi>
 <1317316050-12855-2-git-send-email-lucas.demarchi@profusion.mobi>
 <CAMOw1v5C5w0yORoiwRoDrDop=6bncHU0CNSp95q3M5mr3zjbmA@mail.gmail.com> <CABBYNZLZ1skFismkBGxLksR6Dg0AbLSCrO+uW22QZXzOWGBeeg@mail.gmail.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Thu, 29 Sep 2011 17:17:29 -0300
Message-ID: <CAMOw1v6U3dSUvQiR+BGfA0hL3N_eoc=yPNSL3JCb7uHjxm2_YA@mail.gmail.com>
Subject: Re: [PATCH 1/3] AVRCP: fix changed notification
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Sep 29, 2011 at 4:14 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Lucas,
>
> On Thu, Sep 29, 2011 at 9:01 PM, Lucas De Marchi
> <lucas.demarchi@profusion.mobi> wrote:
>> Hi Luiz,
>>
>> On Thu, Sep 29, 2011 at 2:07 PM, Lucas De Marchi
>> <lucas.demarchi@profusion.mobi> wrote:
>>> We sure want to send notifications only when section is not NULL.
>>> Otherwise we either crash or do not send the expected notification.
>>> ---
>>>  audio/avrcp.c |    2 +-
>>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/audio/avrcp.c b/audio/avrcp.c
>>> index ac9a107..e5b51db 100644
>>> --- a/audio/avrcp.c
>>> +++ b/audio/avrcp.c
>>> @@ -549,7 +549,7 @@ static int avrcp_send_event(struct media_player *mp, uint8_t id, void *data)
>>>        uint16_t size;
>>>        int err;
>>>
>>> -       if (mp->session)
>>> +       if (mp->session == NULL)
>>>                return -ENOTCONN;
>
> That is a bug, ack.
>
>> This fixes the issue with recent code move, but thinking about it see
>> the following scenario:
>>
>> 1) CT connects to TG and registers itself for events
>> 2) CT disconnects
>> 3) CT connects again, but does not register for receiving track-change
>> notification
>> 4) Track changes and we send the track-change notification
>>
>>
>> It seems like (4) is wrong and what we really need to do is to
>> unregister the events when we are disconnected. What do you think?
>
> Yep, we need to unregister when disconnected, but I think it would be
> better to have something else to register the events like
> avrcp_session which represents the connection so when we disconnect it
> would be freed and events automatically unregistered.
>
> Im also working on moving the MediaPlayer to adapter object, as an
> agent, so we can support multiple players, properly track them and

Yep, moving to adapter is a necessary thing. In the end it didn't make
much sense having it on per device.
Don't know how you are thinking about the agent - is it used only to
register/track the media players?

> have the 1.3 record only when there are players registered.

Since you are talking about multiple players, I assume you are talking
about AVRCP 1.4.

Don't know if this is a good idea. When we have 1.4, I think it would
be better to have 1.4 record published and 0 media players than
changing it after a connection is already established. How do you deal
with the case of previously connected devices?

>From section 6.9 of AVRCP 1.4 spec:

"If no players are available the TG shall return an error response
with the error
code No Available Players. Note that available means that a player can
be accessed via
AVRCP with no user interaction locally on the TG. It does not imply
that the media
player application must be currently running."

And from 5.9:

"A device that supports the media source role may contain zero or more
media players.
For the purposes of this document a media player is defined as an
entity which can fulfill
the requirements of this specification. Whether there is a one to one
mapping between
media player entities as presented over AVRCP and applications on the device is
implementation dependant."


Lucas De Marchi
