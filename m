Return-Path: <cyrus@holtmann.org>
Date: Thu, 20 Nov 2008 15:34:26 +0200
From: Johan Hedberg <johan.hedberg@nokia.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: Simple-agent in C
Message-ID: <20081120133426.GA24814@localhost>
References: <37367b3a0811200516y71890f0es7b1aafaac5ef873b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <37367b3a0811200516y71890f0es7b1aafaac5ef873b@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alan,

On Thu, Nov 20, 2008, Alan Carvalho de Assis wrote:
> Please, can you point me to some simple-agent implemented in C?

There's test/agent.c in the source tree. However, now that I took a
quick look at it it's not up-to-date with the latest 4.x API (it e.g.
hardcodes "/org/bluez/hci0" and doesn't use the correct Agent method
names). You'll still be able to use it as a good starting point though.

Johan
