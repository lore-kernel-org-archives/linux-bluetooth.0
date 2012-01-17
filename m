Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: keybuk@google.com
In-Reply-To: <1326786461.6454.283.camel@aeonflux>
References: <1326505957-27555-1-git-send-email-keybuk@chromium.org>
	<1326505957-27555-3-git-send-email-keybuk@chromium.org>
	<1326559307.6454.270.camel@aeonflux>
	<CAHZ1yCm1SuTFrcFscRjg2WdnfkseCw75G+46RL+uZSSH5UFf6Q@mail.gmail.com>
	<CANq1E4TG3=9GZ3G0NKLj1GKd8Vm7L3GV_-CWdKCX3sk5=gVUoQ@mail.gmail.com>
	<CAHZ1yCkKKu2Yk0Q7xU--MJZ9_0-v5U3WAQpkYTVa7gGf6ug8LQ@mail.gmail.com>
	<1326786461.6454.283.camel@aeonflux>
Date: Tue, 17 Jan 2012 00:30:01 -0800
Message-ID: <CAHZ1yCmc0BNQ87+c9v2ZYpu47ANyB06XxN860O_A4qgNd+A9dA@mail.gmail.com>
Subject: Re: [PATCH 2/2] agent: allow agent to reply to RequestPinCode with bytes
From: Scott James Remnant <keybuk@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: David Herrmann <dh.herrmann@googlemail.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Jan 16, 2012 at 11:47 PM, Marcel Holtmann <marcel@holtmann.org> wrote:

> > This thread doesn't give a rationale for why support for Binary PINs
> > couldn't be added to BlueZ, just an alternate implementation in the
> > case of the WiiMote.
>
> the BlueZ agent request is a direct question to the user. And the
> question is meant to give something they can understand and something
> they will also be entering on the other side.
>

Ok, so it'd be appropriate to write a plugin that handled, for
example, sending 0000 to devices within a certain class?

And for keyboard devices, would it be appropriate for the plugin to
generate the PIN itself and send the DisplayPasskey method to the
agent rather than the RequestPinCode? (This is a HID spec
recommendation)

> > It's kinda difficult to do this in a plugin since each authentication
> > request only gets one shot - it's easier (and far cleaner) in the
> > agent, which can outlive each connection attempt and be used for both,
> > keeping track of the PINs it's tried.
>
> I have to send you back to reading the Bluetooth specification for
> Legacy Pairing when trying multiple pairing attempts. There is a
> built-in security concept that will make this concept really
> complicated.
>

I've read it through recently, and I don't recall anything that would
prohibit retrying the link request again.

> And now I have to ask the question, why are we bothering this heavy with
> trying to do auto pairing with Legacy Pairing where almost everything
> has moved on the Simple Pairing and the users have been trained to enter
> 0000 for their HID and headset devices if they ever get asked?
>

Well, "almost everything" unfortunately seems to exclude almost every
device we purchased from Amazon and Fry's, which are all 2.0 at best.

And I don't think users really have been adequately trained - take
keyboards for example, does anyone really know that not only do you
have to try a pin (e.g. 0000) but then you have to type that same
exact pin on the keyboard? No, because a good OS hides all that.


Anyway, I take your point that the Agent is intended to be a direct
representation of the user, so will go down the plugin route and deal
with the lazy (and complicated) devices that way.

Would you like the lazy plugin contributed upstream?

Scott
