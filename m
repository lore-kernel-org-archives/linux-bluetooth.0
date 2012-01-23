Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: keybuk@google.com
In-Reply-To: <1327163781.1955.48.camel@aeonflux>
References: <1327100744-28782-1-git-send-email-scott@netsplit.com>
	<1327100744-28782-3-git-send-email-scott@netsplit.com>
	<1327163781.1955.48.camel@aeonflux>
Date: Sun, 22 Jan 2012 22:08:26 -0800
Message-ID: <CAHZ1yC=tERvMeqDz2sx7SoJ+J9cV-4kZvFpfZek-eX6txMyKtQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] agent: add DisplayPinCode method
From: Scott James Remnant <keybuk@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Scott James Remnant <scott@netsplit.com>, linux-bluetooth@vger.kernel.org
Content-Type: multipart/alternative; boundary=e89a8f503756d059ad04b72bdb2b
List-ID: <linux-bluetooth.vger.kernel.org>

--e89a8f503756d059ad04b72bdb2b
Content-Type: text/plain; charset=ISO-8859-1

On Sat, Jan 21, 2012 at 8:36 AM, Marcel Holtmann <marcel@holtmann.org>wrote:


> I am a little bit concerned here since we are using legacy pairing. I
> have not looked at the implementation, but I think we should only reply
> with the random PIN code to the controller once this method got returned
> with a positive reply.
>
> And in addition I prefer if we handle a negative/reject or non reply at
> all to make this work with older agents as well. That way the core can
> fallback to just RequestPinCode if this gets rejected.
>
>
That's a good idea. I'll change that in the patch.


> In addition to that, I am not sure we can actually nicely emulate the
> "entered" feature from SSP. I know you mentioned that Apple does
> something like this, but it is nowhere near a standard. So do we really
> wanna call this method multiple times or just accept that it will be
> only called once and if it gets rejected, we fall back to requesting the
> PIN code.
>
>
I think I tried to document that it will only ever get called once in
contrast to DisplayPasskey which can be called multiple times - and that's
one good reason the UI would want different methods here, if it gets
DisplayPinCode it knows it's never getting typing notification.

I'll adjust the docs to make it clearer.

I looked into the Apple hack, but it's so randomly specific and evil, I
decided to ignore it.

Scott

--e89a8f503756d059ad04b72bdb2b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Sat, Jan 21, 2012 at 8:36 AM, Marcel Holtmann=
 <span dir=3D"ltr">&lt;<a href=3D"mailto:marcel@holtmann.org">marcel@holtma=
nn.org</a>&gt;</span> wrote:<br><div>=A0</div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
">
<div class=3D"im">I am a little bit concerned here since we are using legac=
y pairing. I</div>
have not looked at the implementation, but I think we should only reply<br>
with the random PIN code to the controller once this method got returned<br=
>
with a positive reply.<br>
<br>
And in addition I prefer if we handle a negative/reject or non reply at<br>
all to make this work with older agents as well. That way the core can<br>
fallback to just RequestPinCode if this gets rejected.<br>
<br></blockquote><div><br></div><div>That&#39;s a good idea. I&#39;ll chang=
e that in the patch.</div><div>=A0</div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
In addition to that, I am not sure we can actually nicely emulate the<br>
&quot;entered&quot; feature from SSP. I know you mentioned that Apple does<=
br>
something like this, but it is nowhere near a standard. So do we really<br>
wanna call this method multiple times or just accept that it will be<br>
only called once and if it gets rejected, we fall back to requesting the<br=
>
PIN code.<br><br></blockquote><div><br></div><div>I think I tried to docume=
nt that it will only ever get called once in contrast to DisplayPasskey whi=
ch can be called multiple times - and that&#39;s one good reason the UI wou=
ld want different methods here, if it gets DisplayPinCode it knows it&#39;s=
 never getting typing notification.</div>
<div><br></div><div>I&#39;ll adjust the docs to make it clearer.</div><div>=
<br></div><div>I looked into the Apple hack, but it&#39;s so randomly speci=
fic and evil, I decided to ignore it.</div><div><br></div><div>Scott</div>
</div>

--e89a8f503756d059ad04b72bdb2b--
