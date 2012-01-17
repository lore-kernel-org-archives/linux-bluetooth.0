Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: keybuk@google.com
In-Reply-To: <CANq1E4TG3=9GZ3G0NKLj1GKd8Vm7L3GV_-CWdKCX3sk5=gVUoQ@mail.gmail.com>
References: <1326505957-27555-1-git-send-email-keybuk@chromium.org>
	<1326505957-27555-3-git-send-email-keybuk@chromium.org>
	<1326559307.6454.270.camel@aeonflux>
	<CAHZ1yCm1SuTFrcFscRjg2WdnfkseCw75G+46RL+uZSSH5UFf6Q@mail.gmail.com>
	<CANq1E4TG3=9GZ3G0NKLj1GKd8Vm7L3GV_-CWdKCX3sk5=gVUoQ@mail.gmail.com>
Date: Mon, 16 Jan 2012 22:23:45 -0800
Message-ID: <CAHZ1yCkKKu2Yk0Q7xU--MJZ9_0-v5U3WAQpkYTVa7gGf6ug8LQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] agent: allow agent to reply to RequestPinCode with bytes
From: Scott James Remnant <keybuk@chromium.org>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Jan 16, 2012 at 7:44 AM, David Herrmann
<dh.herrmann@googlemail.com> wrote:

> On Sat, Jan 14, 2012 at 9:34 PM, Scott James Remnant
> <keybuk@chromium.org> wrote:
>> On Sat, Jan 14, 2012 at 8:41 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
>>
>>> > Since the specification allows the PIN to be a sequence of arbitrary
>>> > octets, and not a UTF-8 string, allow the userspace agent to reply
>>> > with such a sequence (as a D-Bus Array of Bytes).
>>> >
>>> > This means a userspace agent can deal with devices that require their
>>> > BD_ADDR (or the host's) as a PIN, and take care of trying multiple of
>>> > such requirements.
>>>
>>> this has been discussed before and the answer is a clear no to this.
>>>
>>
>> Why a no? I couldn't find the discussion in the archives.
>
> See here:
> http://thread.gmane.org/gmane.linux.bluez.kernel/13380
>

This thread doesn't give a rationale for why support for Binary PINs
couldn't be added to BlueZ, just an alternate implementation in the
case of the WiiMote.

>>> You can however write a plugin that can handle binary PIN codes.
>>>
>>
>> The problem there is that the plugin can only try one, and can't retry
>> the authentication if that PIN fails.
>
> Does your device provide proper PID/VID information? Then I see no
> need to try several different PINs. Could you provide more information
> with what kind of devices you are working here?
>

No, but the name of the device can be strcmp()d to identify it

But that's not the problem - the problem is that the PIN varies on the
device depending on the exact mode being paired - and that's not
something we can tell from the host.

We simply need to try one of three PINs, two of which are annoyingly
binary (they're the Bluetooth address of the device and the host
respectively)

It's kinda difficult to do this in a plugin since each authentication
request only gets one shot - it's easier (and far cleaner) in the
agent, which can outlive each connection attempt and be used for both,
keeping track of the PINs it's tried.

(Likewise the agent is already trying "0000" on devices, and dealing
with not presenting a PIN for keyboards, etc.)

Scott
