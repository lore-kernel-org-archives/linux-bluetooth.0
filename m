Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1349703809.27233.65.camel@aeonflux>
References: <1349683884-22251-1-git-send-email-luiz.dentz@gmail.com>
	<1349703809.27233.65.camel@aeonflux>
Date: Mon, 8 Oct 2012 16:25:13 +0200
Message-ID: <CABBYNZL9LaALwQzL7Ca3E=K8OewpTNX4ySSc2OZ2CM3jv0O_cA@mail.gmail.com>
Subject: Re: [WORKAROUND BlueZ 1/3] gdbus: Add fallback to GetProperties
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Oct 8, 2012 at 3:43 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Luiz,
>
>> This adds a fallback for GetProperties method when it is not
>> implemented.
>> ---
>> This set of patches are workarounds to old properties interface to be able to
>> test new code until other components are ported.
>
> I am not sure I want this at all. This is a nasty hack.
>
> Especially since interfaces that previously had neither or only some of
> these methods get these methods. Bad idea. It might work inside BlueZ
> where we always added these methods, but in other projects some of these
> methods had been left out since the properties where send via signals
> with the object path being announced.

Yep, I fully agree this is not meant to be upstream (only perhaps
behind a compilation flag or something like that), also this does not
work with clients which do use the introspection data like dbus-python
because the fallback methods are not part of it the python scripts
will just fail.

The purpose of these patches is for testing the new code with
components such as PulseAudio, oFono, Connman and gnome-shell as we
move forward and finish the changes they should no longer be
necessary.

-- 
Luiz Augusto von Dentz
