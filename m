Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH 0/3] Fix RFCOMM connect/disconn races
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1394728986-5096-1-git-send-email-peter@hurleysoftware.com>
Date: Wed, 2 Apr 2014 13:04:06 -0700
Cc: Scott James Remnant <keybuk@chromium.org>,
	linux-bluetooth@vger.kernel.org
Message-Id: <200AA5A0-51DA-44FA-9069-9F73A951FCB6@holtmann.org>
References: <15A2D205-97BC-4790-A998-52AD8941DB3F@holtmann.org> <1394728986-5096-1-git-send-email-peter@hurleysoftware.com>
To: Peter Hurley <peter@hurleysoftware.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

> This patch series fixes the observed errors when running
> rctest -r on one station and rctest -c on the other.
> 
> Please note that patch 2/3 is somewhat risky in that it allows
> multiple RFCOMM sessions between the same endpoints to co-exist,
> provided that all but one of the sessions is closing or is closed.
> I did test this, but there may be some subtlety I've overlooked.
> 
> [I note this because you may prefer the simpler and more bulletproof
> solution of returning -EBUSY from __rfcomm_dlc_open() in this
> situation; I can understand if you have lost patience for RFCOMM
> breakage.]

I do not know if we can allow tow sessions with the same endpoint and not causing any other error. Especially also not breaking existing Bluetooth qualification test cases.

Would it be safe to take 1/3 and 3/3 and still think about 2/3 a bit more.

> This series does not address the excessive latency from sending
> the DISC command to receiving the UA reply. I think a partial
> solution would be to skip the rfcomm thread and run
> rfcomm_process_sessions() directly from rfcomm_l2data_ready();
> this would require some rework where sk->sk_data_ready() is
> called directly from contexts that aren't suitable for running
> rfcomm_process_sessions(). And this wouldn't address the
> USB polling latency at all.

I have no idea what is causing this at all. However it could be well that this comes from the time when we moved HCI processing from tasklets into workqueues. And now we have things messing with each other.

The long term goal (which nobody seems to be working on) was to replace the L2CAP socket that RFCOMM uses and thus why the rfcommd thread is needed with a direct L2CAP ops handling.

Regards

Marcel

