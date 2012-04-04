Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1333553048.2125.31.camel@novo.hadess.net>
References: <CAKZqhqfupD+b9FjKRhOjFzZ1kH_17SGPK7n+9hkb8JyiP9Qr=g@mail.gmail.com>
	<CAKZqhqcWhpfnhY-8aDd88LprfS9KankxCjoFoUmL=xJHOVqEmQ@mail.gmail.com>
	<1333553048.2125.31.camel@novo.hadess.net>
Date: Wed, 4 Apr 2012 19:16:45 +0200
Message-ID: <CAKZqhqdx7XGCgQAdaEsiig8g6XBNn1fV3DOuJ2kL3Z=k1vq6_Q@mail.gmail.com>
Subject: Re: GSoC: Obexd Ideas
From: dmp <dmp0x7c5@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Thanks for response.

Previous version of my proposal presented dbus implementation. As
vcgomes suggested yesterday during IRC conversation at #bluez-gsoc
I've already fixed my proposal and now it's prepared for gobex
library.

I plan to implement fuse based solution, but your experience with gvfs
might be helpful.

Thanks,
Michal


On 4 April 2012 17:24, Bastien Nocera <hadess@hadess.net> wrote:
> On Wed, 2012-04-04 at 16:38 +0200, dmp wrote:
>> Hello,
>>
>> I've submitted proposal [1] for "OBEX Filesystem In Userspace". I'll
>> be grateful if someone could give me some comments. There are still
>> few days to improve.
>>
>> [1] http://www.google-melange.com/gsoc/proposal/review/google/gsoc2012/dmp/44002
>
> FWIW, having written the ObexFTP gvfs backend twice already, that using
> a D-Bus API is a bad idea. Instead, the code should use gobex directly.
> It would make the code more robust, and easier to debug.
>
> I'm happy doing code reviews, or answer gvfs specific questions if those
> crop up during the SoC project.
>
> Cheers
>
