Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: [PATCH v7 0/5] input: Connectability
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1366149521-26908-1-git-send-email-deymo@chromium.org>
Date: Wed, 17 Apr 2013 13:20:54 -0700
Cc: linux-bluetooth@vger.kernel.org, keybuk@chromium.org
Message-Id: <553F95A2-59E2-4D2E-BDB6-4AEF5E45B3FD@holtmann.org>
References: <1366149521-26908-1-git-send-email-deymo@chromium.org>
To: Alex Deymo <deymo@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

> It's me again. Let me insist with these input patches again for a good
> reason. There is a qualification test (TP/HCE/BV-04-I [Host Initiated
> Re-connection]) that requires a Bluetooth host to automatically
> re-connect to a HID device when the device goes out of range (and comes
> back in range, obviously). The HID 1.1 spec also states when a device
> is supossed to accept re-connections from a host and now we export that
> via the ReconnectMode property. I extended this patch with a retry timer
> that attempts to reconnect to the HID device for a certain amount of
> time.
> 
> This patch set includes: Patch 1 and 2 are the new ReconnectMode property
> and its documentation. Patch 3 is just some details about bool and gboolean.
> Bonus: patch 4 includes a memory leak fix; and patch 5 uses all this
> thing to automatically reconnect to HID device when its ReconnectMode is
> "host" or "any", as required by the test plan.

I am fine with these patches, but I leave the final say to Johan.

However I do have a general question, do we need the new D-Bus API if we do an auto-reconnect handling? If so, do we need to indicate that the we are currently in auto-reconnect mode and/or cancel it when connecting attempts via other means happen.

Regards

Marcel

