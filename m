Return-Path: <cyrus@holtmann.org>
Date: Tue, 23 Apr 2013 10:42:42 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Alex Deymo <deymo@chromium.org>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	keybuk <keybuk@chromium.org>
Subject: Re: [PATCH v7 0/5] input: Connectability
Message-ID: <20130423074242.GA5111@x220>
References: <1366149521-26908-1-git-send-email-deymo@chromium.org>
 <553F95A2-59E2-4D2E-BDB6-4AEF5E45B3FD@holtmann.org>
 <CAGd9gwiE4=fNX7Mb1911Za-aMm2Wa3WuTnapDWKuGXY45a8xbw@mail.gmail.com>
 <51409ECB-5F03-473F-A257-72EE1540B571@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <51409ECB-5F03-473F-A257-72EE1540B571@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Apr 22, 2013, Marcel Holtmann wrote:
> >> However I do have a general question, do we need the new D-Bus API
> >> if we do an auto-reconnect handling? If so, do we need to indicate
> >> that the we are currently in auto-reconnect mode and/or cancel it
> >> when connecting attempts via other means happen.
> > 
> > We still need the new D-Bus API to let the UI know that it can't
> > reconnect to the device because the device is not supposed to normally
> > accept connections (ReconnectMode is "device" (or "none" if such a
> > device exists)). This allows the UI to instruct the user to go and
> > move the mouse to reconnect or press that hidden "connect" button in
> > his device to reconnect it if the device had lost the pairing. If the
> > ReconnectMode is "device", the meaning of Device1.Connected property
> > changes a bit, since the fact that my mouse is disconnected right now
> > doesn't mean that it is not working as intended or that it should be
> > connected.
> 
> I might have should answered this email with an acknowledged and
> understood comment. Sorry about that.
> 
> My original comment still stands. I am fine with this patch set, but
> leave it up to Johan to make the final to apply it.

No major issues from my side either. All patches in the set have now
been applied.

Johan
