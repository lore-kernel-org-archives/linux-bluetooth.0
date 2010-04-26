Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <x2z2c3916b71004260339j3cd86068g3b4adf5cd523c450@mail.gmail.com>
References: <r2h2c3916b71004260229p48a39235m917ee7ebb0006efe@mail.gmail.com>
	 <x2z2c3916b71004260339j3cd86068g3b4adf5cd523c450@mail.gmail.com>
Date: Mon, 26 Apr 2010 21:24:19 +0300
Message-ID: <g2s2d5a2c101004261124lcd36410dhbfe959945f0aa5a9@mail.gmail.com>
Subject: Re: no client session close in obexd 0.23?
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Daniel Abraham <daniel.shrugged@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Apr 26, 2010 at 1:39 PM, Daniel Abraham
<daniel.shrugged@gmail.com> wrote:
> Oops, didn't notice the (also new) client method "RemoveSession"
>
> Out of curiosity, what's the benefit of moving close/remove from
> session scope to client scope?

No self destruction, in general it is bad idea, but in this case it
even worse because the internally the session may be referred in many
places.


-- 
Luiz Augusto von Dentz
Computer Engineer
