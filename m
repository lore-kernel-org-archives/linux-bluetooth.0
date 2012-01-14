Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: keybuk@google.com
In-Reply-To: <1326559307.6454.270.camel@aeonflux>
References: <1326505957-27555-1-git-send-email-keybuk@chromium.org>
	<1326505957-27555-3-git-send-email-keybuk@chromium.org>
	<1326559307.6454.270.camel@aeonflux>
Date: Sat, 14 Jan 2012 12:34:07 -0800
Message-ID: <CAHZ1yCm1SuTFrcFscRjg2WdnfkseCw75G+46RL+uZSSH5UFf6Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] agent: allow agent to reply to RequestPinCode with bytes
From: Scott James Remnant <keybuk@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, Jan 14, 2012 at 8:41 AM, Marcel Holtmann <marcel@holtmann.org> wrote:

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

Why a no? I couldn't find the discussion in the archives.

> You can however write a plugin that can handle binary PIN codes.
>

The problem there is that the plugin can only try one, and can't retry
the authentication if that PIN fails.

Scott
