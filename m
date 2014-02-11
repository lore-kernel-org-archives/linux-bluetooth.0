Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH 3/6] shared: Add support for disconnect handler in HFP
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1392137346-26272-3-git-send-email-szymon.janc@tieto.com>
Date: Tue, 11 Feb 2014 09:00:27 -0800
Cc: "bluez mailin list (linux-bluetooth@vger.kernel.org)"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <FB263FEA-C682-448B-9DE4-D289CDDBDB5C@holtmann.org>
References: <1392137346-26272-1-git-send-email-szymon.janc@tieto.com> <1392137346-26272-3-git-send-email-szymon.janc@tieto.com>
To: Szymon Janc <szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

> It is no longer possible to send any data after disconnection.
> Extra reference is taken for disconnect watch to allow users to drop
> own reference in disconnect callback.

I am not sure that is the best way to do it. I get the feeling that we might better have an internal bool that is tracking if we are connected/disconnected. Thoughts?

Regards

Marcel

