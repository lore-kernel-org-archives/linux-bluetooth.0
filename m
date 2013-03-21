Return-Path: <cyrus@holtmann.org>
Date: Thu, 21 Mar 2013 11:00:59 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Alex Deymo <deymo@chromium.org>
Cc: linux-bluetooth@vger.kernel.org, keybuk@chromium.org,
	marcel@holtmann.org
Subject: Re: [PATCH] core: Fix wrong argument on agent *_cb functions.
Message-ID: <20130321090059.GA6925@x220.ger.corp.intel.com>
References: <1363849481-7862-1-git-send-email-deymo@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1363849481-7862-1-git-send-email-deymo@chromium.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

On Thu, Mar 21, 2013, Alex Deymo wrote:
> The last argument for the functions pincode_cb, passkey_cb and confirm_cb is
> a user data pointer with the "void *". Those functions expect a
> "struct authentication_req *", but insted a "struct btd_device*" without
> any complaint from the compiler due the void* cast. This fix passes the
> right argument to those functions.
> 
> Other uses of those functions as callbacks (agent_request_passkey,
> agent_request_pincode, agent_request_authorization and agent_request_confirmation)
> pass the right struct authentication_req *.
> ---
> 
> I was having some bluetoothd SEGFAULTs because of this. If you want more details
> and an easy repro case, check http://crbug.com/222665 .
> 
>  src/device.c |   10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)

Good catch. The patch has now been applied. Thanks.

Johan
