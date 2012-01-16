Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHZ1yCm1SuTFrcFscRjg2WdnfkseCw75G+46RL+uZSSH5UFf6Q@mail.gmail.com>
References: <1326505957-27555-1-git-send-email-keybuk@chromium.org>
	<1326505957-27555-3-git-send-email-keybuk@chromium.org>
	<1326559307.6454.270.camel@aeonflux>
	<CAHZ1yCm1SuTFrcFscRjg2WdnfkseCw75G+46RL+uZSSH5UFf6Q@mail.gmail.com>
Date: Mon, 16 Jan 2012 16:44:04 +0100
Message-ID: <CANq1E4TG3=9GZ3G0NKLj1GKd8Vm7L3GV_-CWdKCX3sk5=gVUoQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] agent: allow agent to reply to RequestPinCode with bytes
From: David Herrmann <dh.herrmann@googlemail.com>
To: Scott James Remnant <keybuk@chromium.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Scott

On Sat, Jan 14, 2012 at 9:34 PM, Scott James Remnant
<keybuk@chromium.org> wrote:
> On Sat, Jan 14, 2012 at 8:41 AM, Marcel Holtmann <marcel@holtmann.org> wr=
ote:
>
>> > Since the specification allows the PIN to be a sequence of arbitrary
>> > octets, and not a UTF-8 string, allow the userspace agent to reply
>> > with such a sequence (as a D-Bus Array of Bytes).
>> >
>> > This means a userspace agent can deal with devices that require their
>> > BD_ADDR (or the host's) as a PIN, and take care of trying multiple of
>> > such requirements.
>>
>> this has been discussed before and the answer is a clear no to this.
>>
>
> Why a no? I couldn't find the discussion in the archives.

See here:
http://thread.gmane.org/gmane.linux.bluez.kernel/13380

>> You can however write a plugin that can handle binary PIN codes.
>>
>
> The problem there is that the plugin can only try one, and can't retry
> the authentication if that PIN fails.

Does your device provide proper PID/VID information? Then I see no
need to try several different PINs. Could you provide more information
with what kind of devices you are working here?

> Scott
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
