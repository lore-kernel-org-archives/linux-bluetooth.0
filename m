Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20150227144213.GB32203@aemeltch-MOBL1>
References: <1424964022-8887-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<CABBYNZL0WT4izdNB7Wx0Ys32cyq4_G9g+TSS9HDvmjUd8dh41g@mail.gmail.com>
	<20150227144213.GB32203@aemeltch-MOBL1>
Date: Fri, 27 Feb 2015 17:05:52 +0200
Message-ID: <CABBYNZ+6RONqeZM_7EcbJRPT7pOaCn_FeKdJREi=-L4-yu7FuQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] audio/avdtp: Remove start timer on stream_free()
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Fri, Feb 27, 2015 at 4:42 PM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> Hi Luiz,
>
> On Fri, Feb 27, 2015 at 04:27:45PM +0200, Luiz Augusto von Dentz wrote:
>> Hi Andrei,
>>
>> On Thu, Feb 26, 2015 at 5:20 PM, Andrei Emeltchenko
>> <Andrei.Emeltchenko.news@gmail.com> wrote:
>> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>> >
>> > Makes code identical to android/avdtp
>> > ---
>> >  profiles/audio/avdtp.c | 3 +++
>> >  1 file changed, 3 insertions(+)
>> >
>> > diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
>> > index 896f101..15b611f 100644
>> > --- a/profiles/audio/avdtp.c
>> > +++ b/profiles/audio/avdtp.c
>> > @@ -717,6 +717,9 @@ static void stream_free(void *data)
>> >         if (stream->timer)
>> >                 g_source_remove(stream->timer);
>> >
>> > +       if (stream->start_timer > 0)
>> > +               g_source_remove(stream->start_timer);
>> > +
>> >         if (stream->io)
>> >                 close_stream(stream);
>> >
>> > --
>> > 2.1.0
>>
>> I will take a at this over the weekend, I hope I can make the move
>> without having to redo the patches otherwise the git history will be
>> lost e.g:
>
> You are talking about loosing "git blame" stuff since history does not get
> lost. In this situation we have to loose either profiles/ or android/ "git
> blame" history and I am not sure which one is more important.

git mv should preserve the history, and that what Im going for.

-- 
Luiz Augusto von Dentz
