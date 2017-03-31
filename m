Return-Path: <hadess@hadess.net>
Message-ID: <1490959289.13868.12.camel@hadess.net>
Subject: Re: [PATCH] core: replace sizeof(filename) with PATH_MAX
From: Bastien Nocera <hadess@hadess.net>
To: Konrad Zapalowicz <konrad.zapalowicz@canonical.com>, marcel@holtmann.org
Cc: luiz.von.dentz@intel.com, linux-bluetooth@vger.kernel.org
Date: Fri, 31 Mar 2017 13:21:29 +0200
In-Reply-To: <1490958237-9299-1-git-send-email-bergo.torino@gmail.com>
References: <1490958237-9299-1-git-send-email-bergo.torino@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 2017-03-31 at 13:03 +0200, Konrad Zapalowicz wrote:
> From: Konrad Zapałowicz <konrad.zapalowicz@canonical.com>
> 
> This commit replaces sizeof(filename) with PATH_MAX to match the
> common
> scheme which is used in other places.

I wonder why g_strdup_printf() isn't used instead. Would allow ignoring
PATH_MAX.
