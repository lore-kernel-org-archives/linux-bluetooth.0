Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1510291473.2624.81.camel@hadess.net>
Subject: Re: [PATCH] device: Fix possible run-time warning
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Date: Fri, 10 Nov 2017 06:24:33 +0100
In-Reply-To: <20171110052329.477-1-hadess@hadess.net>
References: <20171110052329.477-1-hadess@hadess.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 2017-11-10 at 06:23 +0100, Bastien Nocera wrote:
> When a reconnect timeout has previously run for a device, setting a
> new
> one will throw a warning as the timeout id is not reset when the
> timeout
> is cancelled from within its callback.

Note that this is the 2nd patch I send with the same subject. They're
not the same patches, and fix 2 different bugs in that part of the
code.

Cheers
