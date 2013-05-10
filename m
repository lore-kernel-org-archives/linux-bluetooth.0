Return-Path: <cyrus@holtmann.org>
Date: Fri, 10 May 2013 10:39:59 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Alex Deymo <deymo@chromium.org>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	keybuk@chromium.org
Subject: Re: [PATCH v5 0/8] Autopair
Message-ID: <20130510073959.GA32047@x220.ger.corp.intel.com>
References: <1368059882-9986-1-git-send-email-deymo@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1368059882-9986-1-git-send-email-deymo@chromium.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

On Wed, May 08, 2013, Alex Deymo wrote:
> Changes from the v4 are:
> * uint32_t --> unsigned int for the "attempt" argument. I think that
> restrict that value to unsigned given that -1 is never used for
> attempt is a good practice.
> * "pincb_iter" --> "btd_adapter_pin_cb_iter". The "pin_cb" instead
> of "pincb" is to match the btd_adapter_pin_cb_t callback type
> already used in the code.
> * Added a bool pincode_requested member to btd_adapter (see patch 4/8)
> to signal if the device requested a pincode during the bonding attempt.
> This is basically to fix the case were we keep retrying the bonding
> and the device keeps sending an authentication error without consuming
> a pin code from the pincode callback list. This ensures that either a
> pincode was consumed from the list before retrying. Together with the
> fact that the pin codes provided by the callback list is a finite list,
> this ensures the retry mechanism will finish.
> 
> Please consider this version for bluez. We are actively testing this
> patchset in our last chromiumos release and I don't have any bug reported
> regarding this feature. Thanks!
> Alex.
> 
> Alex Deymo (8):
>   core: Convert the pincode callback to an interable list.
>   plugins: Extend the pin code callback with the call number
>   core: Add support for retrying a bonding
>   core: retry bonding attempt until the iterator reaches the end.
>   core: Add device_get_class to the public interface.
>   autopair: Add the autopair plugin.
>   core: Expose the last bonding attempt timeout on retry
>   autopair: Try a fixed pincode for keyboards rejecting random codes
> 
>  Makefile.plugins   |   3 +
>  plugins/autopair.c | 165 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  plugins/wiimote.c  |   7 ++-
>  src/adapter.c      | 175 ++++++++++++++++++++++++++++++++++++++++++++++-------
>  src/adapter.h      |  11 +++-
>  src/device.c       | 135 +++++++++++++++++++++++++++++++++++++++++
>  src/device.h       |   7 +++
>  7 files changed, 478 insertions(+), 25 deletions(-)
>  create mode 100644 plugins/autopair.c

All patches in this set have been applied. Thanks!

I did fix one thing in patch 4: for type bool the expected assignments
are true/false and not TRUE/FALSE (which are GLib defines). I also
pushed one small coding style/readability patch on top of this set.

Johan
