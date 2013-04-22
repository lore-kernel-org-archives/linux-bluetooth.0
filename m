Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAGd9gwiE4=fNX7Mb1911Za-aMm2Wa3WuTnapDWKuGXY45a8xbw@mail.gmail.com>
References: <1366149521-26908-1-git-send-email-deymo@chromium.org>
 <553F95A2-59E2-4D2E-BDB6-4AEF5E45B3FD@holtmann.org> <CAGd9gwiE4=fNX7Mb1911Za-aMm2Wa3WuTnapDWKuGXY45a8xbw@mail.gmail.com>
From: Alex Deymo <deymo@chromium.org>
Date: Mon, 22 Apr 2013 10:48:18 -0700
Message-ID: <CAGd9gwjWrtRxOKKgrGvAmAQNrW+t=STSYcnDo9W2g=t3psxZ+Q@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] input: Connectability
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>, keybuk <keybuk@chromium.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Apr 17, 2013 at 1:37 PM, Alex Deymo <deymo@chromium.org> wrote:
> On Wed, Apr 17, 2013 at 1:20 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
>> However I do have a general question, do we need the new D-Bus API if we do an auto-reconnect handling? If so, do we need to indicate that the we are currently in auto-reconnect mode and/or cancel it when connecting attempts via other means happen.
>
> We still need the new D-Bus API to let the UI know that it can't
> reconnect to the device because the device is not supposed to normally
> accept connections (ReconnectMode is "device" (or "none" if such a
> device exists)). This allows the UI to instruct the user to go and
> move the mouse to reconnect or press that hidden "connect" button in
> his device to reconnect it if the device had lost the pairing. If the
> ReconnectMode is "device", the meaning of Device1.Connected property
> changes a bit, since the fact that my mouse is disconnected right now
> doesn't mean that it is not working as intended or that it should be
> connected.
>
> The auto-reconnect is implied and required by the Bluetooth HID spec
> for example in cases where ReconnectMode is "host". I don't think we
> should indicate that we are currently following the spec. The
> auto-reconnect attempts are canceled when the device is reconnected
> for some reason (because of this auto-reconnect or not) or when the
> device is marked for deletion, even if the removal is during the
> auto-reconnect process.

Ping ?
