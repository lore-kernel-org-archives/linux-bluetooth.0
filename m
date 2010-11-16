Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <201011150954.23553.szymon.janc@tieto.com>
References: <1288865461-3760-1-git-send-email-szymon.janc@tieto.com>
 <1288865461-3760-4-git-send-email-szymon.janc@tieto.com> <AANLkTikZrbVTCDB2HRtqRJjUjYP3Z5PBieOovZZgP9id@mail.gmail.com>
 <201011150954.23553.szymon.janc@tieto.com>
From: jaikumar Ganesh <jaikumarg@gmail.com>
Date: Mon, 15 Nov 2010 20:16:39 -0800
Message-ID: <AANLkTik+LOzvJMG=of7cwrQ3j2a0mDvN4Rnq_d4rtwKB@mail.gmail.com>
Subject: Re: [PATCH 3/4] Add DBus OOB API documentation.
To: Szymon Janc <szymon.janc@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Nov 15, 2010 at 12:54 AM, Szymon Janc <szymon.janc@tieto.com> wrote:
> Hi Jaikumar,
>
>> > +               void Deactivate()
>>
>> Would it better to make this a signal ? Deactivate by itself as the
>> only method doesn't seem to be right.
>
> I'll change it to Release() to be consistent with other (Agent) API as
> suggested by Johan.
>
>> > +               void RegisterProvider(object provider)
>> > +
>> > +                       This method registers provider for DBus OOB plug-in.
>> > +                       When provider is successfully registered plug-in becomes
>> > +                       active. Only one provider can be registered at time.
>>
>> Why are we enforcing this limitation ?
>
> Spec requires that each hash&randomizer values should be used only for one OOB
> transfer. Implementation enforces that by allowing only one active OOB plugin
> at time and DBUS OOB plugin only 'expose' plugin API over DBUS. So this
> limitation is a consequence of that.

I don't think the spec says that. It just says every single time the
call to read the local adapters hash
and randomizer is done you get new values. You can use the value that
you have obtained for as many OOB pairings
as you wish.

>
> This limitation also allows for (IMHO) simpler plugins implementation as they
> don't have to care about other plugins hanging around to fulfill that
> requirement.
>
>> > +               array{bye}, array{byte} UpdateLocalOobData(string address)
>>
>> You are not updating anything here. You are just reading the local
>> adapter OOB data
>
> It is updating hash and randomizer. Underlying functions are called Read* as
> this is how corresponding HCI command is called (see Vol2. Part E. 7.3.60).
> I'll change it to Read to keep all calls name consistent with HCI command name
> and add appropriate note in API documentation as this name may be somewhat
> misleading (yet OOB plugin implementer should be aware of that already).
>
> --
> Szymon Janc
>
