Return-Path: <konrad.zapalowicz@canonical.com>
Date: Fri, 31 Mar 2017 13:32:18 +0200
From: Konrad Zapalowicz <konrad.zapalowicz@canonical.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: marcel@holtmann.org, luiz.von.dentz@intel.com,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] core: replace sizeof(filename) with PATH_MAX
Message-ID: <20170331113218.GA28779@annapurna>
References: <1490958237-9299-1-git-send-email-bergo.torino@gmail.com>
 <1490959289.13868.12.camel@hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1490959289.13868.12.camel@hadess.net>
List-ID: <linux-bluetooth.vger.kernel.org>

On 03/31, Bastien Nocera wrote:
> On Fri, 2017-03-31 at 13:03 +0200, Konrad Zapalowicz wrote:
> > From: Konrad Zapałowicz <konrad.zapalowicz@canonical.com>
> > 
> > This commit replaces sizeof(filename) with PATH_MAX to match the
> > common
> > scheme which is used in other places.
> 
> I wonder why g_strdup_printf() isn't used instead. Would allow ignoring
> PATH_MAX.

I guess it is because it is easier. With g_strdup_printf() one would
have to take care about freeing memory. This is not a case with having
filename as an atomatic variable.
