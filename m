Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] bluetooth: Fix for security block issue.
From: Marcel Holtmann <marcel@holtmann.org>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, linus.walleij@stericsson.com,
	par-gunnar.p.hjalmdahl@stericsson.com, padovan@profusion.mobi
In-Reply-To: <1295965639-16683-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1295965639-16683-1-git-send-email-lukasz.rymanowski@tieto.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 25 Jan 2011 17:13:10 +0100
Message-ID: <1295971990.1520.53.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

> It can happen that controller will schedule ACL data
> containing L2CAP connect request to host just before
> encryption change event, even though link is encrypted on
> LMP level before L2CAP connect request come.
> With this fix, L2CAP layer will handle such scenario.

I really don't like to have a work around for this. It is clearly a bug
in the controller.

Regards

Marcel


