Return-Path: <cyrus@holtmann.org>
Date: Tue, 30 Apr 2013 10:23:35 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Alex Deymo <deymo@chromium.org>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	keybuk <keybuk@chromium.org>
Subject: Re: Paired devices in discovery mode
Message-ID: <20130430072335.GA31159@x220.ger.corp.intel.com>
References: <CAGd9gwjbOFpaYrZt=4Pn4VLUNX-uq-Ap=pPaWt9snV_Gmiwmtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAGd9gwjbOFpaYrZt=4Pn4VLUNX-uq-Ap=pPaWt9snV_Gmiwmtg@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

On Mon, Apr 29, 2013, Alex Deymo wrote:
> I'm wonder to solve the following situation:
> 1. You pair your BT device with your computer and use it.
> 2. Then go somewhere else and pair it with another computer to use it there.
> 3. Finally you go back to the first computer and want to use the
> device again with the first computer.
> 
> In this situation, depending on the device, the first pairing could be
> lost if the device supports only one pairing. Some mice/keyboards
> support only one pairing, but there are also other devices supporting
> more than one pairing at each time.
> 
> If the device lost the pairing, the connect attempt with the device
> will likely reject our link key. With the current BlueZ, this is
> "Paired: yes" for us, but we can't initiate the secure connection. To
> solve this we would need to, in order:
> 1. Remove the device.
> 2. Wait for the device to appear in the discovery session.
> 3. Pair again with the device (re-trust is if needed, etc).
> 
> Can we solve this or make it easier?
> I'm thinking about adding a "Discovering" boolean property to the
> Device1 interface that tells you if a device (paired or not, connected
> or not) is in discovery mode. We know that because we see an inquiry
> response while discovering. I would also modify the "Pair" method to
> allow to re-pair a device that is Paired and Discovering instead of
> returning an error for that case.
> What do you think?

This has been discussed many times in the past but nothing concrete has
been done about it so far. The core spec essentially gives us two
options: either to reject the link or to ask the user if it's ok to
repair (and loose the old key) and then proceed with repairing. We've so
far only implemented the first option.

I don't think it should be necessary to add any new properties or even
modify the existing behavior of Device1.Pair() though. Instead this
could be done through the normal L2CAP/RFCOMM client socket connect
operation, i.e. Device1.Connect(). We could either introduce a new agent
callback to authorize the repairing or extend the existing
RequestAuthorization callback which is similar to this.

The main thing to keep in mind is to not expose us to spoofing attacks
where some device pretends to be the one we paired with (by having the
same bdaddr) but doesn't have the link key. The first thing to ensure
here is that we do not throw away the old link key until the new pairing
completed successfully. Another thing to ensure is that we do not allow
downgrading the old key, i.e. if the old key was an authenticated one we
must reject an unauthenticated key in the repairing.

All of the above steps could be taken care of by the kernel when it
detects that the remote side doesn't have the key. It'd postpone
indicating completion for the client socket connect() and go ahead with
the necessary steps, including doing a mgmt event to trigger the
Agent1.RequestAuthorization callback.

Johan
