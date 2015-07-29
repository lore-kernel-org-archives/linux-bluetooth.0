Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLVdcNQTAaXFqdHp_Me4LjuT0ZuauJ2YU1PsROihmsrVA@mail.gmail.com>
References: <CAASrBQ=8icxs8ZyW56CXObZH7DFuPf0XDGz=uQPXB1SsQsuimw@mail.gmail.com>
	<CABBYNZL7x4GpgC+JRU=owGmOfs5JdVRHaiCXOe_5oC+oY9BbNg@mail.gmail.com>
	<CAASrBQmkn3L1MhJbJ9NCGUQz1QJ1YAt6WSnBp-gT7Cn3Ti1YWA@mail.gmail.com>
	<CABBYNZLVdcNQTAaXFqdHp_Me4LjuT0ZuauJ2YU1PsROihmsrVA@mail.gmail.com>
Date: Wed, 29 Jul 2015 17:08:01 -0600
Message-ID: <CAASrBQmtpSUZiE2PHrE2z4vi7JX9+Q1C9zV55QPU404cyY-afA@mail.gmail.com>
Subject: Re: bluetoothctl list-attributes command
From: Mark Rages <markrages@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Jul 23, 2015 at 1:27 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Take the log then, bluetoothd and HCI using btmon should show us what
> is happening.
>

I solved my problem.

I was not starting bluetoothd with the -E (experimental) option.

Once I did that, I could list attributes after connecting.

-- 
Regards,
Mark
markrages@gmail
