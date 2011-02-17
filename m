Return-Path: <cyrus@holtmann.org>
Date: Thu, 17 Feb 2011 16:05:33 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: PATCH [2/2] batostr(): Replace batostr() where possible with
 ba2str to avoid memleaks
Message-ID: <20110217190533.GB22042@jh-x301>
References: <AANLkTimfR_dhOE-k5c3zJ1+dwMwOCBqq-Y6Df-=rp8FP@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTimfR_dhOE-k5c3zJ1+dwMwOCBqq-Y6Df-=rp8FP@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

On Wed, Feb 16, 2011, David Herrmann wrote:
> batostr() returns a dynamically allocated string which must be freed
> later, although, the function looks like the standard berkeley socket
> functions that work on static buffers. Two functions inside bluez
> incorrectly use batostr() and do not free the returned pointer. I
> replaced the occurrence of batostr() with a ba2str().

This patch looks good, but you've managed to format it in such away that
I can't feed it directly to git am. Could you try resending with git
send-email?

Johan
