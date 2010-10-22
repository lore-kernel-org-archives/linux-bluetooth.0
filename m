Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20101022135804.6f55be40@lxorguk.ukuu.org.uk>
References: <AANLkTinHV3qyMRsjAn92uZZp22whESpJDZUfCHcy=Eh9@mail.gmail.com>
	<20101022135804.6f55be40@lxorguk.ukuu.org.uk>
Date: Fri, 22 Oct 2010 15:40:02 +0200
Message-ID: <AANLkTimVGzQ0yxgQvbZ8UX=i414_MXc8a-0u-hW_4iNT@mail.gmail.com>
Subject: Re: [PATCH 6/9] mfd: Add support for the ST-Ericsson CG2900 Audio.
From: Par-Gunnar Hjalmdahl <pghatwork@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linus.walleij@stericsson.com, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Thanks for you comments Alan.

I guess I didn't put enough comments in the code or the commit message
regarding this.
In fact we (ST-Ericsson) are writing drivers that e.g. maps to the V4L
framework. They then
call the API in this driver. This driver has never been intended to
map directly towards ALSA
or V4L. We have other drivers under development that does that.

/P-G

2010/10/22 Alan Cox <alan@lxorguk.ukuu.org.uk>:
> On Fri, 22 Oct 2010 12:39:06 +0200
> Par-Gunnar Hjalmdahl <par-gunnar.p.hjalmdahl@stericsson.com> wrote:
>
>> This patch adds support for controlling audio paths within
>> the ST-Ericsson CG2900 Connectivity Combo controller.
>> This patch adds API for the Kernel as well as a char device for
>> user space stacks to control the CG2900 audio paths.
>
> I don't see any ALSA hooks for audio or any V4L hooks for the FM radio.
> Surely the audio routing wants exposing as a mixer and the audio via
> ALSA, likewise FM radio is video4linux so that it'll have the standard
> interfaces that are expected by the rest of the Linux OS.
>
> Alan
>
