Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: jaikumar Ganesh <jaikumarg@gmail.com>
Subject: Re: [PATCH 3/4] Add DBus OOB API documentation.
Date: Mon, 15 Nov 2010 09:54:23 +0100
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <1288865461-3760-1-git-send-email-szymon.janc@tieto.com> <1288865461-3760-4-git-send-email-szymon.janc@tieto.com> <AANLkTikZrbVTCDB2HRtqRJjUjYP3Z5PBieOovZZgP9id@mail.gmail.com>
In-Reply-To: <AANLkTikZrbVTCDB2HRtqRJjUjYP3Z5PBieOovZZgP9id@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201011150954.23553.szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaikumar,

> > +               void Deactivate()
> 
> Would it better to make this a signal ? Deactivate by itself as the
> only method doesn't seem to be right.

I'll change it to Release() to be consistent with other (Agent) API as
suggested by Johan.

> > +               void RegisterProvider(object provider)
> > +
> > +                       This method registers provider for DBus OOB plug-in.
> > +                       When provider is successfully registered plug-in becomes
> > +                       active. Only one provider can be registered at time.
> 
> Why are we enforcing this limitation ?

Spec requires that each hash&randomizer values should be used only for one OOB
transfer. Implementation enforces that by allowing only one active OOB plugin
at time and DBUS OOB plugin only 'expose' plugin API over DBUS. So this
limitation is a consequence of that.

This limitation also allows for (IMHO) simpler plugins implementation as they
don't have to care about other plugins hanging around to fulfill that
requirement.

> > +               array{bye}, array{byte} UpdateLocalOobData(string address)
> 
> You are not updating anything here. You are just reading the local
> adapter OOB data

It is updating hash and randomizer. Underlying functions are called Read* as
this is how corresponding HCI command is called (see Vol2. Part E. 7.3.60).
I'll change it to Read to keep all calls name consistent with HCI command name
and add appropriate note in API documentation as this name may be somewhat
misleading (yet OOB plugin implementer should be aware of that already).

-- 
Szymon Janc
