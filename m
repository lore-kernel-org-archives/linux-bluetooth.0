Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <014a01cd1f55$aeff71b0$0cfe5510$@ytram.com>
References: <CAB7rCTjRzTZP6TDgsrWvFxE8zuFuYDBQdMnjyvnM4p6Cw=ro2g@mail.gmail.com>
	<014a01cd1f55$aeff71b0$0cfe5510$@ytram.com>
Date: Fri, 20 Apr 2012 19:45:30 -0500
Message-ID: <CAB7rCTiRt9H9+xr6Txt=NnSFunSTT=WHYcJ-qWWPHg7ZgXQdKw@mail.gmail.com>
Subject: Re: PTS / linkkey issue
From: Mike <puffy.taco@gmail.com>
To: wyrles@ytram.com
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tom,

On Fri, Apr 20, 2012 at 7:28 PM, Tom Allebrandi <wyrles@ytram.com> wrote:
> Hi Mike -
>
>> -----Original Message-----
>> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
>> owner@vger.kernel.org] On Behalf Of Mike
>> Sent: Friday, April 20, 2012 3:40 PM
>> To: linux-bluetooth
>> Subject: PTS / linkkey issue
>>
>> Hi,
>>
>> I'm having a somewhat relate issue to Vishal AGARWAL [1].  The trouble I
>> have is that the PTS system is requesting auth type 0, and Bluez happily
>> obliges.  This leaves the PTS device as temporary, and BlueZ then deletes
> this
>> device after the end of the connection.  This prevents me from being able
> to
>> pass TP/OOR/BV-02-I: [HF reconnects to AG].  The code is designed to
>> periodically reconnect to the AG after it detects a link timeout.  But, if
> BlueZ
>> has deleted the device, I don't do that.  This also somewhat applies to
> the
>> A2DP test cases, as my device must be left in pairing mode in order for
> the
>> tests to pass.
>>
>> So, my question to people who have used PTS, is there a way to get the PTS
>> to perform a pairing that is not 0x00 MITM Protection Not Required - No
>> Bonding. Numeric comparison with automatic accept allowed?  I'm using an
>> older kernel that doesn't have the mgmt interface (2.6.33 with some
>> features/fixes backported from newer kernels) but am using the latest
> BlueZ
>> from git (at least of a month ago or so).  But even so, the proposal of
> keeping
>> the linkkey around for the ACL session would be useless, I think, because
> the
>> intent is to have a link timeout event.
>>
>> Thanks,
>> Mike
>>
>> [1] http://www.spinics.net/lists/linux-bluetooth/msg23346.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in
>> the body of a message to majordomo@vger.kernel.org More majordomo
>> info at  http://vger.kernel.org/majordomo-info.html
>
> PTS may be requesting "no man in the middle protection" but what is your
> system (BlueZ) requesting? If your system is also requesting no MITM then
> that would explain what you are seeing.
>
> If your system is requesting "man in the middle protection", then I think
> that is what gets used resulting in an authenticated link key. Do you have
> an HCIdump or PTSPV trace around so we can see what your device is asking
> for.
>
> At least that's the way I read the core spec. I could be wrong, that area is
> a little confusing :-).
>
> --- tom
> tom allebrandi
> wyrles@ytram.com
>

There's not much to the trace.  The PTS' response to the HCI IO
Capability request event gives a 0x00.  The default in the BlueZ code
is 0x04, but it appears it gives that up and takes the 0x00.  In
pairing with an iPhone, I see BlueZ respond with a 0x04 code, and
eventually both sides have indicated 0x04.

The bluetoothd log with PTS containted:

bluetoothd[501]: plugins/hciops.c:link_key_notify() key type 0x04 old
key type 0x04
bluetoothd[501]: plugins/hciops.c:link_key_notify() local auth 0x00
and remote auth 0x00

Thanks,
Mike
