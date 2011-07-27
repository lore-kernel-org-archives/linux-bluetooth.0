Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_PiY-xyV89DTqKTXBawfvDtufqn+Mz97-KNJKLsLcgTNw@mail.gmail.com>
References: <1310986874-30015-1-git-send-email-szymon.janc@tieto.com>
	<CAB7rCTihq=vZBhUSNvFuJmtEPU_OOCABXugZKVTnFe61TkaGMQ@mail.gmail.com>
	<CAJdJm_PiY-xyV89DTqKTXBawfvDtufqn+Mz97-KNJKLsLcgTNw@mail.gmail.com>
Date: Wed, 27 Jul 2011 15:56:34 -0500
Message-ID: <CAB7rCThO2w43fN2f91fHQG6zF_Y8Yuep_BMFgBwvgtq+7a5V4w@mail.gmail.com>
Subject: Re: [PATCH] Fix compilation with --disable-sap and glib < 2.28
From: Mike <puffy.taco@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: Szymon Janc <szymon.janc@tieto.com>,
	linux-bluetooth@vger.kernel.org,
	par-gunnar.p.hjalmdahl@stericsson.com, ulrik.lauren@stericsson.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Jul 27, 2011 at 3:48 PM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> Hi Mike,
>
> On Wed, Jul 27, 2011 at 5:05 PM, Mike <puffy.taco@gmail.com> wrote:
>>> +#include <bluetooth/sdp.h>
>>
>> I must be missing something, because I'm trying to compile from git
>> (d7f192a) and I get an error "audio/telephony-ofono.c:38: fatal error:
>> bluetooth/sdp.h: No such file or directory".  I was previously
>> compiling bluez 4.94 just fine.  Ideas?
>
> Try applying the patch from this email:
>
> http://article.gmane.org/gmane.linux.bluez.kernel/14625

That fixes it!  Thanks!
