Return-Path: <cyrus@holtmann.org>
Date: Wed, 17 Dec 2014 11:19:32 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Biman Paul <biman.paul@samsung.com>
Cc: linux-bluetooth@vger.kernel.org,
	'JAGANATH KANAKKASSERY' <jaganath.k@samsung.com>,
	'CHETHAN T N' <chethan.tn@samsung.com>,
	'Seungyoun Ju' <sy39.ju@samsung.com>,
	=?utf-8?B?J++/vcO+77+9Jw==?= <s.syam@samsung.com>
Subject: Re: MGMT_OP_SET_DISCOVERABLE is queued for a long time if Pairing is
 in progress
Message-ID: <20141217091932.GA30012@t440s.lan>
References: <00a401d019d7$413a57b0$c3af0710$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <00a401d019d7$413a57b0$c3af0710$@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Dec 17, 2014, Biman Paul wrote:
> If the device has initiated pairing and after that it tries to change
> discovery mode, discovery mode change request is queued until the pairing
> operation is completed(be it successful, failed, timeout).
> 
> Steps to Reproduce:
> 1. Initiate Pairing from Instrument Under Test
> 2. Accept in Instrument under Test but do not accept in remote device
> 3. Try to change the Visibility from off to on or on to off.
> Visibility change does not happen until pairing operation is
> completed(Pairing is accepted, rejected or timeout in remote).
> 
> Please suggest the best way we can handle this.

Can't you just enable discoverable mode *before* initiating pairing? :)

On a more serious note, we do have the appropriate API for such
situations: mgmt_reply (instead of mgmt_send) which skips the queue of
mgmt commands. This is how canceling pairing works as well as responding
to PIN or passkey requests (as otherwise these commands would only get
sent when the pair command completes).

So far we haven't extended the use of mgmt_reply anywhere else, but we
could consider using it more extensively when pairing is active if we
have good use cases for it.

Johan
