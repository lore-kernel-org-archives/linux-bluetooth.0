Return-Path: <cyrus@holtmann.org>
Message-ID: <1326786461.6454.283.camel@aeonflux>
Subject: Re: [PATCH 2/2] agent: allow agent to reply to RequestPinCode with
 bytes
From: Marcel Holtmann <marcel@holtmann.org>
To: Scott James Remnant <keybuk@chromium.org>
Cc: David Herrmann <dh.herrmann@googlemail.com>,
	linux-bluetooth@vger.kernel.org
Date: Tue, 17 Jan 2012 08:47:41 +0100
In-Reply-To: <CAHZ1yCkKKu2Yk0Q7xU--MJZ9_0-v5U3WAQpkYTVa7gGf6ug8LQ@mail.gmail.com>
References: <1326505957-27555-1-git-send-email-keybuk@chromium.org>
	 <1326505957-27555-3-git-send-email-keybuk@chromium.org>
	 <1326559307.6454.270.camel@aeonflux>
	 <CAHZ1yCm1SuTFrcFscRjg2WdnfkseCw75G+46RL+uZSSH5UFf6Q@mail.gmail.com>
	 <CANq1E4TG3=9GZ3G0NKLj1GKd8Vm7L3GV_-CWdKCX3sk5=gVUoQ@mail.gmail.com>
	 <CAHZ1yCkKKu2Yk0Q7xU--MJZ9_0-v5U3WAQpkYTVa7gGf6ug8LQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Scott,

> >> On Sat, Jan 14, 2012 at 8:41 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> >>
> >>> > Since the specification allows the PIN to be a sequence of arbitrary
> >>> > octets, and not a UTF-8 string, allow the userspace agent to reply
> >>> > with such a sequence (as a D-Bus Array of Bytes).
> >>> >
> >>> > This means a userspace agent can deal with devices that require their
> >>> > BD_ADDR (or the host's) as a PIN, and take care of trying multiple of
> >>> > such requirements.
> >>>
> >>> this has been discussed before and the answer is a clear no to this.
> >>>
> >>
> >> Why a no? I couldn't find the discussion in the archives.
> >
> > See here:
> > http://thread.gmane.org/gmane.linux.bluez.kernel/13380
> >
> 
> This thread doesn't give a rationale for why support for Binary PINs
> couldn't be added to BlueZ, just an alternate implementation in the
> case of the WiiMote.

the BlueZ agent request is a direct question to the user. And the
question is meant to give something they can understand and something
they will also be entering on the other side.

It is not for trying to shoehorn Legacy Pairing into Simple Pairing.
Never was and never will be. Hence we are doing UTF-8 only strings.

> >>> You can however write a plugin that can handle binary PIN codes.
> >>>
> >>
> >> The problem there is that the plugin can only try one, and can't retry
> >> the authentication if that PIN fails.
> >
> > Does your device provide proper PID/VID information? Then I see no
> > need to try several different PINs. Could you provide more information
> > with what kind of devices you are working here?
> >
> 
> No, but the name of the device can be strcmp()d to identify it
> 
> But that's not the problem - the problem is that the PIN varies on the
> device depending on the exact mode being paired - and that's not
> something we can tell from the host.
> 
> We simply need to try one of three PINs, two of which are annoyingly
> binary (they're the Bluetooth address of the device and the host
> respectively)
> 
> It's kinda difficult to do this in a plugin since each authentication
> request only gets one shot - it's easier (and far cleaner) in the
> agent, which can outlive each connection attempt and be used for both,
> keeping track of the PINs it's tried.

I have to send you back to reading the Bluetooth specification for
Legacy Pairing when trying multiple pairing attempts. There is a
built-in security concept that will make this concept really
complicated.

Nothing you should handle inside the UI anyway. The agent is not meant
for this. Built a plugin that can handle this for you. We support that
for exactly these weird devices that wanna emulate Simple Pairing, but
are too lazy to do just use a Bluetooth 2.1 stack + device.

And now I have to ask the question, why are we bothering this heavy with
trying to do auto pairing with Legacy Pairing where almost everything
has moved on the Simple Pairing and the users have been trained to enter
0000 for their HID and headset devices if they ever get asked?

Regards

Marcel


