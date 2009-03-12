Return-Path: <cyrus@holtmann.org>
Date: Thu, 12 Mar 2009 09:41:06 +0000
From: James Le Cuirot <chewi@aura-online.co.uk>
To: linux-bluetooth@vger.kernel.org
Subject: Re: dund: how to config for handset platform
Message-ID: <20090312094106.4a95d26e@symphony>
In-Reply-To: <6edf6b480903120218i6066199bx2f0dd6cad564f59f@mail.gmail.com>
References: <6edf6b480903100602x6b84b8f3o8e2f3266e6b69c47@mail.gmail.com>
	<6edf6b480903100618k15f77f25p6c2ef1ab42b7b269@mail.gmail.com>
	<6edf6b480903120218i6066199bx2f0dd6cad564f59f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 12 Mar 2009 17:18:09 +0800
yesir yao <yesiryao@gmail.com> wrote:

> after I run "dund --listen --dialup --msdun --nodetach"

I'm afraid dund is obsolete in Bluez 4. I think the right way to do it
is to use rfcomm to create a serial device like /dev/rfcomm0 and use
pppd to dial-up through that. I've only done that with Bluez 3 though
so I could be wrong.

James
