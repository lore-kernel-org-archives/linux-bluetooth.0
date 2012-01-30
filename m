Return-Path: <cyrus@holtmann.org>
Message-ID: <1327952480.1955.154.camel@aeonflux>
Subject: Re: [PATCHv2 0/4] Add support for bonding callbacks and retrying
From: Marcel Holtmann <marcel@holtmann.org>
To: Scott James Remnant <scott@netsplit.com>
Cc: linux-bluetooth@vger.kernel.org, keybuk@chromium.org
Date: Mon, 30 Jan 2012 11:41:20 -0800
In-Reply-To: <1327430878-23913-1-git-send-email-scott@netsplit.com>
References: <1327430878-23913-1-git-send-email-scott@netsplit.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Scott,

> Thanks for the comments on the autopair plugin patches, I'm still
> working on updating that but I wanted to submit the underlying core
> changes necessary while I do so.
> 
> This adds plugin support for a callback called when bonding completes,
> either successfully or fails, or is cancelled. In the success or failure
> cases the callback may return TRUE, in which case the bonding is retried
> after a short backoff period.
> 
> The (to be submitted) autopair plugin will use this to retry bonding if
> a fixed PIN it provides fails, and ignore the subsequent attempt so that
> the ordinary PIN handling (user agent, keyboard auto-generation, etc.)
> happens.

yesterday Johan and talked about this a little bit and I just wanna
quickly iterate some small comments here.

So we should only allow retrying when we initiated the bonding. If the
other side started the pairing, then retrying should not even be
considered.

We have to also ensure that we do not disconnect the ACL in between the
retry attempts. Otherwise some car kits might cancel their pairing
procedure and you have to have user interaction to get it back into
pairing mode. So if the ACL gets disconnect, then we should just fail
and cancel the bonding.

For some extra credit we might need to retry the pairing in the kernel
if we happen to run into an LMP collision due to role switch changes or
similar issues. And hide that from the user if this happens.

Regards

Marcel


