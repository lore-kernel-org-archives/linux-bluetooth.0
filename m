Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20121028022942.3bcd1bd7@i7>
References: <1351272036-4875-1-git-send-email-frederic.dalleau@linux.intel.com>
	<1351272036-4875-7-git-send-email-frederic.dalleau@linux.intel.com>
	<20121028020621.3653ac8e@i7>
	<20121028022942.3bcd1bd7@i7>
Date: Mon, 29 Oct 2012 08:42:08 +0100
Message-ID: <CA+QXtDvsWoQd+JVxKC0HVRGZxUKg-JeN7_V+MfHXotg_N6EBKQ@mail.gmail.com>
Subject: Re: [PATCH v3 06/10] sbc: Add mmx primitive for 1b 8s analyse
From: "Dalleau, Frederic" <frederic.dalleau@intel.com>
To: Siarhei Siamashka <siarhei.siamashka@gmail.com>
Cc: =?ISO-8859-1?Q?Fr=E9d=E9ric_Dalleau?=
	<frederic.dalleau@linux.intel.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Siarhei,

Since only neon is concerned by this, I'd rather add a one liner like this :

#ifdef SBC_BUILD_WITH_NEON_SUPPORT
       sbc_init_primitives_neon(state);
+
+     if (state->increment == 1)
+             state->sbc_analyze_4b_8s = sbc_analyze_1b_8s_simd;
#endif

It is more explicit, doesn't change priority and doesn't add needless code
to other implementations.

And what about sbc_analyze_8s?


Regarding point 2, this is the reason why patch 4 was a bit bigger, the simd
implementation is complete.

Regards,
Frédéric
