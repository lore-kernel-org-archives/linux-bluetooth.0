Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: keybuk@google.com
In-Reply-To: <1326795820.6454.309.camel@aeonflux>
References: <1326505957-27555-1-git-send-email-keybuk@chromium.org>
	<1326505957-27555-3-git-send-email-keybuk@chromium.org>
	<1326559307.6454.270.camel@aeonflux>
	<CAHZ1yCm1SuTFrcFscRjg2WdnfkseCw75G+46RL+uZSSH5UFf6Q@mail.gmail.com>
	<CANq1E4TG3=9GZ3G0NKLj1GKd8Vm7L3GV_-CWdKCX3sk5=gVUoQ@mail.gmail.com>
	<CAHZ1yCkKKu2Yk0Q7xU--MJZ9_0-v5U3WAQpkYTVa7gGf6ug8LQ@mail.gmail.com>
	<1326786461.6454.283.camel@aeonflux>
	<CAHZ1yCmc0BNQ87+c9v2ZYpu47ANyB06XxN860O_A4qgNd+A9dA@mail.gmail.com>
	<1326795820.6454.309.camel@aeonflux>
Date: Tue, 17 Jan 2012 09:57:45 -0800
Message-ID: <CAHZ1yC=i=CFGforhNJFYTA6aEEUharP5xMWn_kEC_G3xp=xSzQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] agent: allow agent to reply to RequestPinCode with bytes
From: Scott James Remnant <keybuk@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: David Herrmann <dh.herrmann@googlemail.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Thanks for the feedback!

On Tue, Jan 17, 2012 at 2:23 AM, Marcel Holtmann <marcel@holtmann.org> wrote:

>> Ok, so it'd be appropriate to write a plugin that handled, for
>> example, sending 0000 to devices within a certain class?
>
> as long as you know that it is correct PIN code. If it is not, then you
> might end up in the funky case that you have to try again. Meaning
> actually pair again. If the remote device lets you do this again without
> pressing the magic buttons again.
>

Yeah, that's a concern we'd have to test - on the other hand, OS X
does seem to just send 0000 for a whole class of devices without ever
prompting the user, so there's a chance this is "safe enough"

>> And for keyboard devices, would it be appropriate for the plugin to
>> generate the PIN itself and send the DisplayPasskey method to the
>> agent rather than the RequestPinCode? (This is a HID spec
>> recommendation)
>
> Something like that could be done, but you do wanna solve that part
> inside the bluetoothd core somehow. Play a little bit with the timing
> details on this idea. There might be a problem. You can easily run into
> a LMP timeout if you supply the PIN code too fast.
>

No problem

>> > I have to send you back to reading the Bluetooth specification for
>> > Legacy Pairing when trying multiple pairing attempts. There is a
>> > built-in security concept that will make this concept really
>> > complicated.
>> >
>>
>> I've read it through recently, and I don't recall anything that would
>> prohibit retrying the link request again.
>
> The is a backoff algorithm inside the core LMP on your device that will
> effectively prevent these kind of "attacks".
>

Fair point, I'll try rejecting OS X's 0000 PIN and see whether there
are interesting timings going on there that they've solved.

>> Well, "almost everything" unfortunately seems to exclude almost every
>> device we purchased from Amazon and Fry's, which are all 2.0 at best.
>
> That is seriously funny. I have not bought a single 2.0 device in a long
> time. Only exceptions are keyboards and mice. That device class seems to
> be waiting for HID over Low Energy.
>

That may be true, K+M are my focus for now, other than insane silly devices ...

> Sure. Send them all upstream. You will need to touch the core anyway at
> some point. Some of your ideas can not be solved with a pure plugin
> right now. Especially if you wanna change the part that interacts with
> the agent as well.
>
Sweet, thanks for your advice!

Scott
