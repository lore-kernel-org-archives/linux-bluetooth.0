Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CANyK0SkeUPLsS-XTZpiSSN8c6dh6-V44sJXFv2ZDi9Kk0dZ-Hw@mail.gmail.com>
References: <1449557617-3413-1-git-send-email-hychao@chromium.org>
	<CABBYNZK-0g8Q4u8UCEuPic7sxXYnT0yP7S0vn+643Pa24Kze_w@mail.gmail.com>
	<CANyK0SnnkH5xyhCCCGuZBySHA88517nijyb=3Q8M_6E5mCe6Kw@mail.gmail.com>
	<CANyK0Sm+Ard+-xoKopoYG-OSuSUxDVmA+DrpkiggMFBF9g94Vw@mail.gmail.com>
	<CABBYNZK8CTh2LAQvg+CDtwRFzaUsfCj+U9ODWP6BGDsgpOk7UQ@mail.gmail.com>
	<CABBYNZLJ2WWeOLwn8XPkYaRBA9dZ9zhgF5xuehChXXxcZt4TdA@mail.gmail.com>
	<CANyK0SkeUPLsS-XTZpiSSN8c6dh6-V44sJXFv2ZDi9Kk0dZ-Hw@mail.gmail.com>
Date: Thu, 24 Mar 2016 14:43:32 +0200
Message-ID: <CABBYNZJ2RtG7gJzp0jNGBNHEo9pdr7eEeNx9Noa+WDs06rOc4A@mail.gmail.com>
Subject: Re: [PATCH] audio/a2dp - Fix unbalanced setup ref/unref
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Hsin-yu Chao <hychao@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hsin-yu,

On Thu, Mar 24, 2016 at 12:58 PM, Hsin-yu Chao <hychao@chromium.org> wrote:
> Hi Luiz,
> I suppose you mean the plugin/policy.c and yes we are using it. We got
> reports about this crash from end user, however the crash rate is low
> and not happening for me either. Since BT adapters are built-in for
> almost all Chromebooks, I don't think the 'adapter removal' should
> happen except cases that there's any problem in driver/FW.

That seems to be the reason in the first trace:

(bluetoothd -adapter.c:4171 ) adapter_remove
(bluetoothd -adapter.c:7453 ) index_removed

> I spent some time look at this backtrace and check code around the
> path of a2dp_cancel() -> avdtp_abort().
> The crash happens in a2dp_cancel() where the setup_unref() is called,
> seems because of the a2dp_setup pointer is already freed. My first
> guess is that code from avdtp_abort() somehow decreases the
> a2dp_setup's refcount to zero.
> Function avdtp_abort() could return cancel_request(session,
> ECANCELED); if session->req is non-null. And depending on the
> req->signal_id, corresponding callback function in a2dp.c(e.g
> reconf_cfm) got called, and eventually called setup_cb_free() and
> setup_unref() so that the associated a2dp_setup object got free'd.
>
> However these calls to setup_cb_free() shouldn't be blamed, because
> the refcount has always been increased earlier when each a2dp_setup_cb
> is allocated. And that makes me guess there's unbalanced manipulation
> of a2dp_setup's refcount elsewhere.

Yep, that is always protected by a reference so it should be causing a problem.

> I checked other places where an a2dp_setup is ref/unref'ed, and there
> are a few places I don't understand.
>  - a2dp.c: transport_cb() has a setup_unref() call which decreases the
> refcont of a2dp_setup. But it's not clear to me why this call is
> needed.
>  - a2dp.c: open_ind() has a2dp_setup_get() call which increases the
> refcount of a2dp_setup, while this a2dp_setup pointer is not assigned
> to new place.

They are related, open_ind will reference the setup while the
transport channel is being connected which is why there is a call to
setup_unref in the transport_cb.

> Could you share with me any idea or hint?

Did you check my patches?
