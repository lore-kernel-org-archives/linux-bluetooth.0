Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAMOw1v5C5w0yORoiwRoDrDop=6bncHU0CNSp95q3M5mr3zjbmA@mail.gmail.com>
References: <1317316050-12855-1-git-send-email-lucas.demarchi@profusion.mobi>
	<1317316050-12855-2-git-send-email-lucas.demarchi@profusion.mobi>
	<CAMOw1v5C5w0yORoiwRoDrDop=6bncHU0CNSp95q3M5mr3zjbmA@mail.gmail.com>
Date: Thu, 29 Sep 2011 22:14:21 +0300
Message-ID: <CABBYNZLZ1skFismkBGxLksR6Dg0AbLSCrO+uW22QZXzOWGBeeg@mail.gmail.com>
Subject: Re: [PATCH 1/3] AVRCP: fix changed notification
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Thu, Sep 29, 2011 at 9:01 PM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> Hi Luiz,
>
> On Thu, Sep 29, 2011 at 2:07 PM, Lucas De Marchi
> <lucas.demarchi@profusion.mobi> wrote:
>> We sure want to send notifications only when section is not NULL.
>> Otherwise we either crash or do not send the expected notification.
>> ---
>>  audio/avrcp.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/audio/avrcp.c b/audio/avrcp.c
>> index ac9a107..e5b51db 100644
>> --- a/audio/avrcp.c
>> +++ b/audio/avrcp.c
>> @@ -549,7 +549,7 @@ static int avrcp_send_event(struct media_player *mp, uint8_t id, void *data)
>>        uint16_t size;
>>        int err;
>>
>> -       if (mp->session)
>> +       if (mp->session == NULL)
>>                return -ENOTCONN;

That is a bug, ack.

> This fixes the issue with recent code move, but thinking about it see
> the following scenario:
>
> 1) CT connects to TG and registers itself for events
> 2) CT disconnects
> 3) CT connects again, but does not register for receiving track-change
> notification
> 4) Track changes and we send the track-change notification
>
>
> It seems like (4) is wrong and what we really need to do is to
> unregister the events when we are disconnected. What do you think?

Yep, we need to unregister when disconnected, but I think it would be
better to have something else to register the events like
avrcp_session which represents the connection so when we disconnect it
would be freed and events automatically unregistered.

Im also working on moving the MediaPlayer to adapter object, as an
agent, so we can support multiple players, properly track them and
have the 1.3 record only when there are players registered.

-- 
Luiz Augusto von Dentz
