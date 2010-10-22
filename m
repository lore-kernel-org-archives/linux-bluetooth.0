Return-Path: <cyrus@holtmann.org>
Date: Fri, 22 Oct 2010 13:58:04 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: pghatwork@gmail.com
Cc: par-gunnar.p.hjalmdahl@stericsson.com,
	linus.walleij@stericsson.com, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] mfd: Add support for the ST-Ericsson CG2900 Audio.
Message-ID: <20101022135804.6f55be40@lxorguk.ukuu.org.uk>
In-Reply-To: <AANLkTinHV3qyMRsjAn92uZZp22whESpJDZUfCHcy=Eh9@mail.gmail.com>
References: <AANLkTinHV3qyMRsjAn92uZZp22whESpJDZUfCHcy=Eh9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 22 Oct 2010 12:39:06 +0200
Par-Gunnar Hjalmdahl <par-gunnar.p.hjalmdahl@stericsson.com> wrote:

> This patch adds support for controlling audio paths within
> the ST-Ericsson CG2900 Connectivity Combo controller.
> This patch adds API for the Kernel as well as a char device for
> user space stacks to control the CG2900 audio paths.

I don't see any ALSA hooks for audio or any V4L hooks for the FM radio.
Surely the audio routing wants exposing as a mixer and the audio via
ALSA, likewise FM radio is video4linux so that it'll have the standard
interfaces that are expected by the rest of the Linux OS.

Alan
