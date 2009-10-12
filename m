Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1e9e22610910111120p25a850bflcc31794f7e29192e@mail.gmail.com>
References: <1e9e22610910111120p25a850bflcc31794f7e29192e@mail.gmail.com>
Date: Mon, 12 Oct 2009 12:06:13 +0200
Message-ID: <2d5a2c100910120306g54a8c79bt42164babb123f4b2@mail.gmail.com>
Subject: Re: Failed to connect to SDP server / Connection reset by peer
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Addo Del Grossi <addo.delgrossi@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Sun, Oct 11, 2009 at 8:20 PM, Addo Del Grossi
<addo.delgrossi@gmail.com> wrote:
> Hi,
>
> I upgraded to Ubuntu Karmic and found problems when using the command sdptool.
> I was found that the problem only when use the kernel 2.6.31,
> using the old 2.6.28 Kernel sdptool the command works correctly.
>
> Note: We also did the test by downloading the Vanilla kernel
> kernel.org site and the same error was found.
>

It is difficult to guess without hcidump output, could you please try
this: > sudo hcidump -XVt

There is a high chance that this is not really related to sdptool
itself, as you are using the same BlueZ version in both cases, but
some pairing/bonding/security issue.

-- 
Luiz Augusto von Dentz
Engenheiro de Computação
