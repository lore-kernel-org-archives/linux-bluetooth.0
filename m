Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <44EE5C37ADC36343B0625A05DD408C48506899D283@CHEXMB-01.global.atheros.com>
References: <44EE5C37ADC36343B0625A05DD408C48506899D283@CHEXMB-01.global.atheros.com>
Date: Mon, 17 Aug 2009 11:01:27 -0300
Message-ID: <2d5a2c100908170701j7d6f9645o42f89d5ce208f8fa@mail.gmail.com>
Subject: Re: Query about not implemented features in Bluez x.yy version
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Vikram Kandukuri <Vikram.Kandukuri@atheros.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Aug 17, 2009 at 3:22 AM, Vikram
Kandukuri<Vikram.Kandukuri@atheros.com> wrote:
> Hi All,
>
> I have question about finding out what core features are not implemented in any given version of BlueZ.
> By core features, I mean mandatory and optional PICS in L2CAP,GAP,RFCOMM,SDP,SPP sections.
>
> For example, how to know what features are implemented and not implemented in BlueZ 4.32  and/or 4.46 ?
>
> In general , how to know which features are implented or not in version X.YY of BlueZ? Will there
> be any consolidated release notes document or browsing source code is the only method to judge this?

If you want a per release note than there is the Changelog, now if you
are talking about qualification that depends on kernel version too. We
support most of the common profiles distributed in plugins:

audio - avdtp, avctp, avrcp, a2dp, hsp and hfp
input - hid
network - pan
serial - spp and dun

They all can be disabled so you can customize your solution, also some
profiles like a2dp, hsp/hfp and pan(NAP) depend on other subsystems to
work properly and qualify, e.g. our a2dp implementation doesn't stream
any audio but you can use pulseaudio, gstreamer element or alsa plugin
to do that for you.

-- 
Luiz Augusto von Dentz
Engenheiro de Computação
