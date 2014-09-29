Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140929073226.GA4163@t440s.lan>
References: <1411746838-9879-1-git-send-email-fons@spotify.com> <20140929073226.GA4163@t440s.lan>
From: Alfonso Acosta <fons@spotify.com>
Date: Mon, 29 Sep 2014 17:58:03 +0200
Message-ID: <CAHF=Y4phAV85sdW9Y=E=2uJtfDsB+28R0xcSahm-p6OEKyT+-Q@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: Fix sending redundant "LE Set Scan Enable
 (disable)" commands
To: Alfonso Acosta <fons@spotify.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> I can see the need for having some sort of fix for this. However, we
> already have several use cases where we'd need to check for pending HCI
> commands and adding a new variable to hci_dev for each case is not
> really a good way to solve it. If we really would want to do it and
> we're out of available hdev->dev_flags I'd consider making the hdev
> variable "unsigned long dev_flags[2]" which both test_bit and set_bit
> should be able to handle fine (and existing code wouldn't need
> changing).

Yep, I agree with extending the size of dev_flags, it's much cleaner.
It simply didn't occur to me.

> You also have the issue that your code only covers the HCI
> commands sent through hci_req_add_le_scan_disable() but not any other
> code paths that might send the same command (either from the kernel or
> from user space using a raw HCI socket, e.g. hcitool).
>
> So far we've been able to cover other similar cases adequately by
> looking into the mgmt pending command queue and so the HCI command queue
> hasn't required any special look-ups. Now it might be the time to
> consider something like that. I.e. if we really do need to check for a
> not-yet sent HCI command a helper to look-up pending commands in
> hdev->cmd_q should be added. OTOH, we'd still have a race when the HCI
> command has already been sent but not yet completed, in which case the
> helper might need to look at hdev->sent_cmd as well. Either way, solving
> this in a generic manner doesn't seem to be a completely trivial task.

I agree, this is the right way to fix it, but I am not sure I will
have the time to do in the short term (specially given my current lack
of familiarity with the code).

Maybe you can give me some pointers and I can see if I can find some
time? We can discuss this on IRC if you want.


> If I've understood correctly the background for this (which it really
> wouldn't hurt to mention in the commit message) is a paired device that
> looses its pairing information because if a reset and we want to repair
> with it? I think to make this less complex for user space we should
> consider simply making mgmt_pair_device() calls valid for already paired
> devices, in which case it'd simply trigger a re-pairing. That way you
> wouldn't need the initial mgmt_unpair_device() call. Thoughts?

I will extend the commit description to add more context.

Good point. Calling mgmt_unpair_device() alone before
mgmt_pair_device() is not much of a hassle. However, since
mgmt_unpair_device() also removes the autoconnect action and the
connection parameters, these need to be added again too (and kept
around for this purpose).

So, yes, I think it would simplify things.



-- 
Alfonso Acosta

Embedded Systems Engineer at Spotify
Birger Jarlsgatan 61, Stockholm, Sweden
http://www.spotify.com
