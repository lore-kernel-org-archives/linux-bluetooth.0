Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1383042118-21205-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1382957047-31775-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1383042118-21205-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Tue, 29 Oct 2013 12:43:32 +0100
Message-ID: <CAHCYCoz4tSeimwrwVNENWsGf-ZDq9Huq9jB9dOgwccrPiF8Fow@mail.gmail.com>
Subject: Re: [PATCHv2 0/9] Improve logging for Android
From: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On 29 October 2013 11:21, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> Changes:
>         *v2: Added thread-safe helpers for printing properties, bdaddr, etc
>         after comments that simple printing is not thread-safe. The idea is to
>         use TLS (thread local storage) like bionic is doing for strerror for

Implementation of strerror in bionic and what is proposed here is
thread safe but not
useful if one wants to use one print to for two addresses or two
properties (one buffer
in one thread for two strings).

In my opinion there should be safe functions that explicitly get
string buffer as
argument. For address and uuid they already exist, property printing
was used in haltest
only in one place and moving buffer form btproperty2str to function
that calls it
makes sense to me.

If there is need for shortcut as for code lines that could be removed
in compilation,
wrapper function with pthread stuff can still be used (provided that
there is no same
type conversion call used in one print)

BTW strerror() works fine when called with value in range 0..131.
But when you call it with higher number there will be a problem
printf("%s\n%s\n\%s\n%s\n", strerror(1), strerror(2), strerror(132),
strerror(133));
prints:
Operation not permitted
No such file or directory
Unknown error 133
Unknown error 133

>         example. More info can be found on manpage for pthread_key_create.
>
> This patch series uses debug functions defined already for haltest and
> allows to print very helpful logs on Android target like shown below:
>
> ...
> hal-bluetooth.c:set_adapter_property() prop: type=BT_PROPERTY_ADAPTER_SCAN_MODE len=4 val=BT_SCAN_MODE_NONE
> ...
>
> Andrei Emeltchenko (9):
...

-- 
Jerzy
