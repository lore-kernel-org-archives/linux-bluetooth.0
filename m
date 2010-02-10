Return-Path: <cyrus@holtmann.org>
Date: Wed, 10 Feb 2010 09:06:47 -0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	padovan@profusion.mobi
Subject: Re: [PATCH] Add argument verification when unregistering Handsfree
 agent
Message-ID: <20100210110647.GA21192@jh-x301>
References: <f9d4bd31002091425l3cf8a4e0u7e3ad0ec0f1766ec@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f9d4bd31002091425l3cf8a4e0u7e3ad0ec0f1766ec@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Tue, Feb 09, 2010, Claudio Takahasi wrote:
> this patch fix a minor problem in the handsfree gateway/agent code:
> the object path argument is not being verified.

Thanks. The patch has been pushed upstream.

Johan
