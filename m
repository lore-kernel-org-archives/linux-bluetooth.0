Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Add rfkill plugin
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1248798884.23466.12024.camel@localhost.localdomain>
References: <1248798884.23466.12024.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 29 Jul 2009 16:13:28 +0100
Message-Id: <1248880408.28327.906.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2009-07-28 at 17:34 +0100, Bastien Nocera wrote:
> The plugin allows us to restore the previous power state on
> adapters when the killswitch on them has been unblocked.
> 
> Otherwise we end up with the adapter disabled when coming back from a
> soft killswitch.

Just a note that __u32 causes failures with newer GCCs (not sure why),
using uint32_t instead fixes the problem.

I'll send another patch when this one gets committed.

