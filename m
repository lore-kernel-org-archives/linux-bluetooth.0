Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <o2w2d5a2c101004270010gf01c8228ve01bbbcb3e58fa67@mail.gmail.com>
References: <r2h2c3916b71004260229p48a39235m917ee7ebb0006efe@mail.gmail.com>
	 <x2z2c3916b71004260339j3cd86068g3b4adf5cd523c450@mail.gmail.com>
	 <g2s2d5a2c101004261124lcd36410dhbfe959945f0aa5a9@mail.gmail.com>
	 <h2s2c3916b71004261637le0d83946y724f6ddb538c093@mail.gmail.com>
	 <o2w2d5a2c101004270010gf01c8228ve01bbbcb3e58fa67@mail.gmail.com>
Date: Tue, 27 Apr 2010 13:35:47 +0300
Message-ID: <y2j2c3916b71004270335qa7cd0aa7l704685202ce19d90@mail.gmail.com>
Subject: Re: no client session close in obexd 0.23?
From: Daniel Abraham <daniel.shrugged@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Apr 27, 2010 at 10:10 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> It's a bug, could you please try this:
>
> http://gitorious.org/~vudentz/obexd/vudentzs-clone/commit/fd4e8e2cef72542fb5bc924817f4b409415b3b54
>
> I guess that should fix the problem.

Confirmed, the fix works as intended.
