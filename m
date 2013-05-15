Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLNyiAUXPQgX558egJ_f33vkq8JQbgbLXu-jq-_5U3ntQ@mail.gmail.com>
References: <CAGd9gwjqSiH3=JwR80VcuXf2Z7KA8zOsYFT9N5gAZgZnTfF2wQ@mail.gmail.com>
	<CABBYNZ+dE7Pkt5-RpzQQ1YSgj9pa4cM+MMDwGKFmdidApDtUKQ@mail.gmail.com>
	<CAGd9gwi=72xSK5=ne2+wPU-A=oEz2VXnpPqjxMW9Z6OnyHOUMA@mail.gmail.com>
	<CABBYNZJNxEnKk-E5TcSwwNwkeBDhbsBgyMUJ_MuL02-MeV_i1Q@mail.gmail.com>
	<CAGd9gwj7c=EL8bQ_qjEq7XR5LonH_c=sQyTrhvnxompiN687Vg@mail.gmail.com>
	<CABBYNZLf7JANb+QxKWczvQNeG1DvqYkbbD9_nncdfznCajLOWg@mail.gmail.com>
	<CAHZ1yCmMOyYiBYO2Fg8SRc_9h-_3Jw=74mAuvucZJUrVm76ieA@mail.gmail.com>
	<CABBYNZLNyiAUXPQgX558egJ_f33vkq8JQbgbLXu-jq-_5U3ntQ@mail.gmail.com>
Date: Wed, 15 May 2013 09:25:54 -0700
Message-ID: <CAHZ1yC=PvjXVBtT7982MiwJAgUqQK1VtmuZjiemwVSf52zeZrw@mail.gmail.com>
Subject: Re: Audio sink stream remains suspended on reconnection
From: Scott James Remnant <keybuk@chromium.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Alex Deymo <deymo@chromium.org>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, May 15, 2013 at 9:00 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Scott,
>
> On Wed, May 15, 2013 at 6:33 PM, Scott James Remnant
> <keybuk@chromium.org> wrote:
>> It's still not fully clear to me how the state could be handled. For
>> example, the following:
>>
>> We only acquire the transport stream when we have actual sound to be
>> played, and once we've finished playback we release the transport
>> stream again. In most circumstances this seems correct, and matches
>> what we see on other platforms - with a suspend being sent to the
>> device, and a start being sent when we have more sound to play.
>>
>> What I can't figure out is what we're supposed to do in the case where
>> the device sends the start (state goes to pending) when we _don't_
>> have any sound to play.
>>
>> Are we still expected to acquire the transport stream? What happens if we don't?
>
> No top posting, please.
>

I wasn't replying to anything particular in your message

> The headset controlling the A2DP stream like this is normally a bad
> behavior/implementation, it should be using AVRCP Play/Pause, but
> anyway it is possible that the headset takes over the control in fact
> I remember someone trying to use those commands to do some kind of
> audio transfer like in HFP.
>
> Anyway the answer for your question about pending state is probably
> don't Acquire if you wont gonna use it, the start will fail and the
> stream will stay suspended, you could also attempt to assume control
> and Acquire the stream but if this is to work like audio transfer the
> headset wants to override the routing so the speakers are used
> instead.

The device appears to sulk and drop the ACL entirely :-/
