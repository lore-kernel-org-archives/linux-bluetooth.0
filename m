Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1317825160-21429-4-git-send-email-lkslawek@gmail.com>
References: <1317825160-21429-1-git-send-email-lkslawek@gmail.com>
	<1317825160-21429-4-git-send-email-lkslawek@gmail.com>
Date: Wed, 5 Oct 2011 17:04:01 +0200
Message-ID: <CA+i+Aw3WLMrFdxLZieVy9CoDQxtG=NNgVyo9HFPmQkDK2+5jRA@mail.gmail.com>
Subject: Re: [PATCH obexd 4/4] Simplify code for calling mime driver flush()
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Oct 5, 2011 at 4:32 PM, Slawomir Bochenski <lkslawek@gmail.com> wrote:
> OBEX_EV_REQ is the last thing that we are going to receive on PUT and
> this is always going to be delivered. As the service driver will start
> receiving data at or before its .put(), we can simply call flush() after
> that. This also makes flush() usable in PUTs without length header.

One thing I've forgotten to mention:

Additionally the return value from flush() now follows the usual
conventions - -EAGAIN is used to suspend request, other values less
than zero will set appropriate OBEX error code.
