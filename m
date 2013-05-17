Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAGd9gwhOurO91q1EwJwZbTVthaxr2AjcVeZ47xuAY_S1Ft_u3w@mail.gmail.com>
References: <CAGd9gwgKMt21TnGLJ09+gAkP-=Jn9mfoAThiBuqup_vTyCshuw@mail.gmail.com>
	<CAGd9gwgkWe+A5rbEnhgNxc5Va9TQt_-Pp04c5rP18nO2FF9f2A@mail.gmail.com>
	<CABBYNZLz=nP5fouBQw0oUYe_L4SOX3jPoQtkATYGispvs8dh_w@mail.gmail.com>
	<CAGd9gwhOurO91q1EwJwZbTVthaxr2AjcVeZ47xuAY_S1Ft_u3w@mail.gmail.com>
Date: Fri, 17 May 2013 09:47:44 +0300
Message-ID: <CABBYNZKmuPbRywcZniFcGPmZBGn78ucKretDn12=9KukREy4jQ@mail.gmail.com>
Subject: Re: a2dp.c: finalize_config(setup) can destroy setup
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Alex Deymo <deymo@chromium.org>
Cc: keybuk <keybuk@chromium.org>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

On Thu, May 16, 2013 at 11:34 PM, Alex Deymo <deymo@chromium.org> wrote:
> Hi Luiz,
>
> On Thu, May 16, 2013 at 4:02 AM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> Looks like there are some new devices that should try to get a hold,
>> anyway this problem should be fixed ASAP so what about the following
>> patch:
>>
>> diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
>> index 215f4db..c6973ae 100644
>> --- a/profiles/audio/a2dp.c
>> +++ b/profiles/audio/a2dp.c
>> @@ -723,16 +723,12 @@ static void open_cfm(struct avdtp *session,
>> struct avdtp_local_sep *sep,
>>         if (err) {
>>                 setup->stream = NULL;
>>                 setup->err = err;
>> +               if (setup->start)
>> +                       finalize_resume(setup);
>>         }
>>
>>         finalize_config(setup);
>>
>> -       if (!setup->start || !err)
>> -               return;
>> -
>> -       setup->start = FALSE;
>> -       finalize_resume(setup);
>> -
>>         return;
>>  }
>
> This patch looks good to me. I tried it in the same scenario and
> valgrind does not complain.
> Could you please push it to the repo?

Pushed, thanks for testing it.


--
Luiz Augusto von Dentz
