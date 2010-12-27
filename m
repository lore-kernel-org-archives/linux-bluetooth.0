Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTikcZRjC2KwOpHSqS_6wMcT8skKBMbhMzs=ugK+F@mail.gmail.com>
References: <1293456068-11615-1-git-send-email-anderson.lizardo@openbossa.org>
	<1293456068-11615-2-git-send-email-anderson.lizardo@openbossa.org>
	<AANLkTikcZRjC2KwOpHSqS_6wMcT8skKBMbhMzs=ugK+F@mail.gmail.com>
Date: Mon, 27 Dec 2010 10:35:03 -0400
Message-ID: <AANLkTi=06P4ZpGO-sp7czZtn9FGLkBwPnrxNqDdGspfy@mail.gmail.com>
Subject: Re: [PATCH 2/4] Use stored device name (if any) instead of EIR data
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Dec 27, 2010 at 10:14 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> It seems your path changes more than just ignore the shortened names,
> which I believed was the purpose here

Note that it does not completely ignore shortened names. If no
complete EIR name has been received yet, it will use the shortened
name (but not store it, as it is temporary). Once a complete name has
been received, it will be stored and used from now on. Actually this
has been the original behavior regarding storage, my patch simply
makes sure any further complete names are ignored, assuming the first
"complete" one is definitive and that the device is not supposed to
rename the "complete" name.

> if the variable name is set
> than your could would skip eir name completely while the code did
> actually use the eir name, probably the eir name is updated more
> frequently so it is probably the most updated one and we should in
> fact update the storage if they don't match.

I could not find on spec any mention that the "complete" EIR name may
change. Note that the original code only store complete EIR name and
the name coming from name resolving.

> Now about the shortened, Im not completely sure if we should ignore it
> or just append something to it, like e.g. ... or ~1, in case the spec
> say it is always the prefix we can at least use it as an hint if the
> name we have resolved does have changed.

As I mentioned above, the shortened names are only ignored after a
"complete" EIR name has been received. I think this is a sane
behavior, assuming the shortened names are temporary (e.g. while name
resolution is not possible or while the device could not send the
complete name using EIR).

I've not found any references to the spec saying the shortened name
has to be a prefix. I believe it is left to the implementer how to
display such shortened names. bluez so far has made no distinction on
the display of shortened names vs. complete names.

Regards,
-- 
Anderson Lizardo
OpenBossa Labs - INdT
Manaus - Brazil
