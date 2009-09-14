Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Revert "[Bluetooth] Eliminate checks for impossible
 conditions in IRQ handler"
From: Marcel Holtmann <marcel@holtmann.org>
To: Mike Frysinger <vapier@gentoo.org>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michael Hennerich <michael.hennerich@analog.com>
In-Reply-To: <1252905504-26666-1-git-send-email-vapier@gentoo.org>
References: <1252905504-26666-1-git-send-email-vapier@gentoo.org>
Content-Type: text/plain
Date: Mon, 14 Sep 2009 02:58:35 -0700
Message-Id: <1252922315.3421.0.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mike,

> Commit ac019360fe3 changed the irq handler logic to BUG_ON rather than
> returning IRQ_NONE when the incoming argument is invalid.  While this
> works in most cases, it doesn't work when the IRQ is shared with other
> devices (or when DEBUG_SHIRQ is enabled).
> 
> So revert the previous change and replace the warning message with a
> comment.

please don't use git revert here. Send an updated patch that fixes this
issue correct and please send it with a proper subject line.

Regards

Marcel


