Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <9469082.LestBIZf2H@uw000953>
References: <1391513842-9548-1-git-send-email-andrzej.kaczmarek@tieto.com>
	<9469082.LestBIZf2H@uw000953>
Date: Tue, 4 Feb 2014 14:44:34 +0200
Message-ID: <CABBYNZJwb1pxj+TjkmSztwwm0RqtTaoxJTOHBREqjJZ7cxVq-A@mail.gmail.com>
Subject: Re: [PATCH] android/hal-audio: Add simple downmix to mono
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Tue, Feb 4, 2014 at 1:49 PM, Szymon Janc <szymon.janc@tieto.com> wrote:
> Hi Andrzej,
>
> On Tuesday 04 of February 2014 12:37:22 Andrzej Kaczmarek wrote:
>> This patch adds simple downmix support from stereo to mono in order to
>> support mono channel mode as it's mandatory for SBC codec. It uses
>> simple (L+R)/2 calculation which should be good enough.

Not following this one, doesn't AudioFlinger supports mono?
