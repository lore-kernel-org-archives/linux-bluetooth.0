Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH 3/6] shared: Add support for disconnect handler in HFP
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <92817127.UgR6P4lKdQ@leonov>
Date: Wed, 12 Feb 2014 10:47:27 -0800
Cc: "bluez mailin list (linux-bluetooth@vger.kernel.org)"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <529F1B4B-504D-48A7-8F58-9AC55A672169@holtmann.org>
References: <1392137346-26272-1-git-send-email-szymon.janc@tieto.com> <1392137346-26272-3-git-send-email-szymon.janc@tieto.com> <FB263FEA-C682-448B-9DE4-D289CDDBDB5C@holtmann.org> <92817127.UgR6P4lKdQ@leonov>
To: Szymon Janc <szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

>>> It is no longer possible to send any data after disconnection.
>>> Extra reference is taken for disconnect watch to allow users to drop
>>> own reference in disconnect callback.
>> 
>> I am not sure that is the best way to do it. I get the feeling that we might
>> better have an internal bool that is tracking if we are
>> connected/disconnected. Thoughts?
> 
> You mean don't have a public HFP disconnect handler and just fail on write() 
> or use bool instead of io pointer for state tracking?

we should still have a disconnect handler. However we should not take these extra reference and have these extra checks for something.

I rather see us tracking the actual state of the IO and not trying to reference count our way into something insane. It is dangerous to have to many indirect reference counts.

Regards

Marcel

