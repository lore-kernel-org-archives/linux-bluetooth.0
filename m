Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1408961443.27910.149.camel@pohly-mobl1.fritz.box>
References: <1408961443.27910.149.camel@pohly-mobl1.fritz.box>
Date: Mon, 25 Aug 2014 13:57:27 +0300
Message-ID: <CABBYNZLTF9s1v=wTSSLN0A2zPEgyAAyKhpJ+KaLDSLfZxCG-Tg@mail.gmail.com>
Subject: Re: org.bluez.obex.Transfer1 Suspend/Resume in queued state
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Patrick Ohly <patrick.ohly@intel.com>
Cc: Luiz Von Dentz <luiz.von.dentz@intel.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Mateusz Potrola <mateusz.polrola@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Patrick,

On Mon, Aug 25, 2014 at 1:10 PM, Patrick Ohly <patrick.ohly@intel.com> wrote:
> Hello!
>
> When testing support for Suspend/Resume in SyncEvolution's PBAP backend
> I ran into a situation that is not handled well at the moment:
>
>      1. PullAll creates a new transfer and queues it.
>      2. Suspend is called while the transfer is not running yet ->
>         "GDBus.Error:org.bluez.obex.Error.NotInProgress: Not in
>         progress"
>      3. When ready, the transfer runs (untested; at the moment,
>         SyncEvolution cancels the transfer when receiving the error).

Well this behavior is documented:
https://git.kernel.org/cgit/bluetooth/bluez.git/tree/doc/obex-api.txt

> The only way how SyncEvolution can suspend in this case is to catch the
> error, wait for the "active" Status and retry to suspend. This is
> sub-optimal (besides being more complex) because the whole point of the
> suspend is to not interfere with other activities until the transfer
> gets resumed again.

But why you want to suspend a transfer that is currently not active? I
expected that the active would be suspended thus suspending the whole
queue since OBEX can only support one at time.

> Would it be possible to get rid of the NotInProgress error during Status
> = "queued", for example by keeping the transfer in the queued state
> until it gets resumed?

Perhaps if we come up with a use case that benefit from it, maybe it
is valid if we want to be able to suspend transfer after the active,
or deeper in queue, has completed? I would turn it suspended and then
a call to Resume should turn the transfer back to queued so it is
easier to monitor what is going on.

-- 
Luiz Augusto von Dentz
