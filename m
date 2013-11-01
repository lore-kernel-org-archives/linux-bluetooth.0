Return-Path: <cyrus@holtmann.org>
Date: Fri, 1 Nov 2013 14:06:23 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 1/6] android/daemon: Implement mgmt device connected event
Message-ID: <20131101120623.GA27892@x220.p-661hnu-f1>
References: <1383305418-13619-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1383305418-13619-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Fri, Nov 01, 2013, Andrei Emeltchenko wrote:
> Send HAL_EV_ACL_STATE_CHANGED event to HAL through IPC.
> ---
>  android/adapter.c |   26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)

This doesn't compile:

  CC       android/adapter.o
android/adapter.c: In function ‘mgmt_device_connected_event’:
android/adapter.c:641:17: error: ‘HAL_ACL_STATE_CONNECTED’ undeclared (first use in this function)
  hal_ev.state = HAL_ACL_STATE_CONNECTED;
                 ^
android/adapter.c:641:17: note: each undeclared identifier is reported only once for each function it appears in
make[1]: *** [android/adapter.o] Error 1

> +	if (length < sizeof(*ev)) {
> +		error("Too short %s (%u bytes)", __func__, length);
> +		return;
> +	}

This looks a bit weird. The function is not too short but the message
is, not to mention that having to use __func__ for error logs is a bit
counterintuitive. Just put "device connected event" into the string.
Same goes for your device disconnected event patch.

Johan
