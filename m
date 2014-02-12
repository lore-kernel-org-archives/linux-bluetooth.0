Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "bluez mailin list (linux-bluetooth@vger.kernel.org)" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 3/6] shared: Add support for disconnect handler in HFP
Date: Wed, 12 Feb 2014 19:40:31 +0100
Message-ID: <92817127.UgR6P4lKdQ@leonov>
In-Reply-To: <FB263FEA-C682-448B-9DE4-D289CDDBDB5C@holtmann.org>
References: <1392137346-26272-1-git-send-email-szymon.janc@tieto.com> <1392137346-26272-3-git-send-email-szymon.janc@tieto.com> <FB263FEA-C682-448B-9DE4-D289CDDBDB5C@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tuesday 11 of February 2014 09:00:27 Marcel Holtmann wrote:
> Hi Szymon,
> 
> > It is no longer possible to send any data after disconnection.
> > Extra reference is taken for disconnect watch to allow users to drop
> > own reference in disconnect callback.
> 
> I am not sure that is the best way to do it. I get the feeling that we might
> better have an internal bool that is tracking if we are
> connected/disconnected. Thoughts?

You mean don't have a public HFP disconnect handler and just fail on write() 
or use bool instead of io pointer for state tracking?

-- 
BR
Szymon Janc
