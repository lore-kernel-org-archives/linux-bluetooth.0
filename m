Return-Path: <cyrus@holtmann.org>
Date: Fri, 4 Sep 2015 12:30:03 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Chuck Ebbert <cebbert.lkml@gmail.com>
Cc: Oon-Ee Ng <ngoonee.talk@gmail.com>, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH - untested] bluetooth: Don't check for SMP security too
 early
Message-ID: <20150904093003.GB19882@t440s.lan>
References: <20150904045626.4881d34b@as>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150904045626.4881d34b@as>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Sep 04, 2015, Chuck Ebbert wrote:
> Commit 25ba26539 ("Bluetooth: Fix NULL pointer dereference in
> smp_conn_security") added a check for NULL SMP, but it was checked
> too early. It is possible for this function to return success even
> when that is NULL. Move the check down to just before the variable
> gets used.
> 
> Fixes: 25ba26539 ("Bluetooth: Fix NULL pointer dereference in smp_conn_security")
> 
> ---
> 
> NOTE: UNTESTED, no signoff

Looks like the exact same fix I just sent myself :) If the fix works
(which I think it should) you should of course get the credits since
your patch made it to the list a bit before mine. You might want to
check the commit message and my other email for a bit deeper analysis of
the issue.

Johan
