Return-Path: <cyrus@holtmann.org>
Date: Sat, 23 Feb 2008 13:36:03 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Tobias Klauser <tklauser@distanz.ch>
Cc: marcel@holtmann.org, bluez-devel@lists.sourceforge.net,
        Dave Young
 <hidave.darkstar@gmail.com>
Subject: Re: [PATCH] bluetooth: Make bnep_sock_cleanup() return void
Message-Id: <20080223133603.e85b7bc2.akpm@linux-foundation.org>
In-Reply-To: <20080223212620.GA8227@distanz.ch>
References: <20080223212620.GA8227@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <bluez-devel.lists.sourceforge.net>

On Sat, 23 Feb 2008 22:26:20 +0100 Tobias Klauser <tklauser@distanz.ch> wrote:

> bnep_sock_cleanup() always returns 0 and its return value isn't used
> anywhere in the code.

Please cc netdev@vger.kernel.org on bluetooth patches.

Apparently bluez-devel is a complete spamfest, and davem has set up
linux-bluetooth@vger.kernel.org, but we haven't done anything with it yet.

I guess we should put out an announcement and modify ./MAINTAINERS, etc. 
ANy volunteers?
