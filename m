Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTimbLBxcU5nZE9UUQJGkHgMLe5LNnvLt1G0jckVF@mail.gmail.com>
References: <1277320206-6969-1-git-send-email-harri.mahonen@gmail.com>
	<AANLkTikqyXXpC0guYSAZb4L-V6Cg5A_L6MJdcc5ChRpJ@mail.gmail.com>
	<AANLkTimbLBxcU5nZE9UUQJGkHgMLe5LNnvLt1G0jckVF@mail.gmail.com>
Date: Thu, 24 Jun 2010 17:36:38 +0300
Message-ID: <AANLkTinpwLVnJwrAyDS87p0wavVFCNzssiNJl7TkyTaE@mail.gmail.com>
Subject: Re: [PATCH] audio: fix memory leak with typefinding
From: =?ISO-8859-1?Q?Harri_M=E4h=F6nen?= <harri.mahonen@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Jun 24, 2010 at 11:09 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Sorry, I misunderstood the problem, it is really gstreamer only issue,
> but I would suggest using the return of sbc_parse so we don't have to
> hardcode sbc sync word detection, something like the following:

Thank you for your comments, I agree with using sbc_parse to avoid
hardcoded sbc sync word detection. I'll repost updated patch.

Br,
Harri
