Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH 1/4] audio/avdtp: Remove start timer on stream_free()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZ+6RONqeZM_7EcbJRPT7pOaCn_FeKdJREi=-L4-yu7FuQ@mail.gmail.com>
Date: Fri, 27 Feb 2015 09:23:32 -0800
Cc: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <D659D827-1818-4C9A-803C-739AEB41D629@holtmann.org>
References: <1424964022-8887-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <CABBYNZL0WT4izdNB7Wx0Ys32cyq4_G9g+TSS9HDvmjUd8dh41g@mail.gmail.com> <20150227144213.GB32203@aemeltch-MOBL1> <CABBYNZ+6RONqeZM_7EcbJRPT7pOaCn_FeKdJREi=-L4-yu7FuQ@mail.gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

>>> On Thu, Feb 26, 2015 at 5:20 PM, Andrei Emeltchenko
>>> <Andrei.Emeltchenko.news@gmail.com> wrote:
>>>> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>>>> 
>>>> Makes code identical to android/avdtp
>>>> ---
>>>> profiles/audio/avdtp.c | 3 +++
>>>> 1 file changed, 3 insertions(+)
>>>> 
>>>> diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
>>>> index 896f101..15b611f 100644
>>>> --- a/profiles/audio/avdtp.c
>>>> +++ b/profiles/audio/avdtp.c
>>>> @@ -717,6 +717,9 @@ static void stream_free(void *data)
>>>>        if (stream->timer)
>>>>                g_source_remove(stream->timer);
>>>> 
>>>> +       if (stream->start_timer > 0)
>>>> +               g_source_remove(stream->start_timer);
>>>> +
>>>>        if (stream->io)
>>>>                close_stream(stream);
>>>> 
>>>> --
>>>> 2.1.0
>>> 
>>> I will take a at this over the weekend, I hope I can make the move
>>> without having to redo the patches otherwise the git history will be
>>> lost e.g:
>> 
>> You are talking about loosing "git blame" stuff since history does not get
>> lost. In this situation we have to loose either profiles/ or android/ "git
>> blame" history and I am not sure which one is more important.
> 
> git mv should preserve the history, and that what Im going for.

you do realize that there is no such thing as git mv in the end. That is just a more convenient helper for mv itself and git add. In the end that magic all happens with git's rename detection. The history will never be lost. It is just a bit harder to find it :)

Regards

Marcel

