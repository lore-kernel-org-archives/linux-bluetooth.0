Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: keybuk@google.com
In-Reply-To: <1326559307.6454.270.camel@aeonflux>
References: <1326505957-27555-1-git-send-email-keybuk@chromium.org>
	<1326505957-27555-3-git-send-email-keybuk@chromium.org>
	<1326559307.6454.270.camel@aeonflux>
Date: Sat, 14 Jan 2012 12:32:23 -0800
Message-ID: <CAHZ1yCkPOtZZeJX-KPpJcSPPYdnX_eM+ycdU5OzD9VPG6mkZxQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] agent: allow agent to reply to RequestPinCode with bytes
From: Scott James Remnant <keybuk@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: multipart/alternative; boundary=f46d040714d905e94904b682e1b1
List-ID: <linux-bluetooth.vger.kernel.org>

--f46d040714d905e94904b682e1b1
Content-Type: text/plain; charset=ISO-8859-1

On Sat, Jan 14, 2012 at 8:41 AM, Marcel Holtmann <marcel@holtmann.org>wrote:


> > Since the specification allows the PIN to be a sequence of arbitrary
> > octets, and not a UTF-8 string, allow the userspace agent to reply
> > with such a sequence (as a D-Bus Array of Bytes).
> >
> > This means a userspace agent can deal with devices that require their
> > BD_ADDR (or the host's) as a PIN, and take care of trying multiple of
> > such requirements.
>
> this has been discussed before and the answer is a clear no to this.
>
>
Why a no? I couldn't find the discussion in the archives.


> You can however write a plugin that can handle binary PIN codes.
>
>
The problem there is that the plugin can only try one, and can't retry the
authentication if that PIN fails.

Scott

--f46d040714d905e94904b682e1b1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Sat, Jan 14, 2012 at 8:41 AM, Marcel Holtmann=
 <span dir=3D"ltr">&lt;<a href=3D"mailto:marcel@holtmann.org">marcel@holtma=
nn.org</a>&gt;</span> wrote:<br><div>=A0</div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
">
<div class=3D"im">&gt; Since the specification allows the PIN to be a seque=
nce of arbitrary<br>
&gt; octets, and not a UTF-8 string, allow the userspace agent to reply<br>
&gt; with such a sequence (as a D-Bus Array of Bytes).<br>
&gt;<br>
&gt; This means a userspace agent can deal with devices that require their<=
br>
&gt; BD_ADDR (or the host&#39;s) as a PIN, and take care of trying multiple=
 of<br>
&gt; such requirements.<br>
<br>
</div>this has been discussed before and the answer is a clear no to this.<=
br><br></blockquote><div><br></div><div>Why a no? I couldn&#39;t find the d=
iscussion in the archives.</div><div>=A0</div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
">

You can however write a plugin that can handle binary PIN codes.<br>
<br></blockquote><div><br></div><div>The problem there is that the plugin c=
an only try one, and can&#39;t retry the authentication if that PIN fails.<=
/div><div><br></div><div>Scott</div></div>

--f46d040714d905e94904b682e1b1--
