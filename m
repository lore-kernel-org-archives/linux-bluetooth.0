Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [RFC] queue: Add queue_foreach_if
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1403598452-4391-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Tue, 24 Jun 2014 10:35:38 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <FDFF8D9B-E5C8-44C2-9C14-189C02E54672@holtmann.org>
References: <1403598452-4391-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Function allows to search for a second level queue inside first level
> queue. In the current implementation since head is hidden this is not
> possible.

this is not something we want in a generic helper. This is a specific case and better model that on top of queue and not within it. Queues of queues are not a thing.

Regards

Marcel

