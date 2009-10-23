Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <e8892a6a0910230817l6f096f70s4de1fe534799de86@mail.gmail.com>
References: <1256253562-22532-1-git-send-email-jaikumar@google.com>
	 <2d5a2c100910230649u1946e632qa4c50b33b6654218@mail.gmail.com>
	 <e8892a6a0910230817l6f096f70s4de1fe534799de86@mail.gmail.com>
Date: Fri, 23 Oct 2009 14:44:44 -0300
Message-ID: <2d5a2c100910231044u6a6c65e0ka8258a6f65d08f41@mail.gmail.com>
Subject: Re: [PATCH] Update SDP storage records when a record is deleted.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Jaikumar Ganesh <jaikumar@google.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Oct 23, 2009 at 12:17 PM, Jaikumar Ganesh <jaikumar@google.com> wrote:
>
> My mail to linux bluetooth bounced yesterday.  Sending it again.
>
>    The req->profiles_removed gets updated from device->uuids.
> However, in the case, where we are paired with the remote device and
> we unpair and then repair, since we will free device->uuids on the
> unpair, the req->profiles_removed won't get updated after the SDP
> query on repair. And so we would need to update the storage from
> device->uuids.

Im not sure if I get you right, but if you are saying that when device
object is gone profiles_removed is empty that is the a new device and
we shouldn't have any profile at that point for consistence, so either
we remove the sdp cache on device_remove_stored or we never remove
records from the cache. Perhaps the record cache is really useless and
we should only cache the uuids information and query the record on
every connect attempt (we are going to connect anyway so the cost is
about the same.)

> Since req->profiles_removed would be empty, device_remove_drivers
> won't get called. Also I believe it makes sense to have 2 functions,
> even though there is slight overhead, since the deletion of SDP
> records from storage, and removing device_probe_drivers are 2 distinct
> operations.

Maybe if you called it on device_remove_stored too, but if we are
going to validate that information on every connection attempt I doubt
this is useful in the end.

-- 
Luiz Augusto von Dentz
Engenheiro de Computação
