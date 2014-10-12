Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHF=Y4r+ofDDBv5+YpFPcvctqYAAGiwNj0u94+XDsoskbSF4Mw@mail.gmail.com>
References: <1412991237-20847-1-git-send-email-fons@spotify.com>
 <F4236E26-CB50-4334-9AD9-0D930B2B9955@holtmann.org> <CAHF=Y4o7BE5hVzNgyXR0_jGPqNLnfjj1MgzuTU0iB-tvvgKa3A@mail.gmail.com>
 <5240CE7E-B366-410A-93C4-5FCC3358A68F@holtmann.org> <CAHF=Y4r+ofDDBv5+YpFPcvctqYAAGiwNj0u94+XDsoskbSF4Mw@mail.gmail.com>
From: Alfonso Acosta <fons@spotify.com>
Date: Sun, 12 Oct 2014 12:45:38 +0200
Message-ID: <CAHF=Y4rb3d6=Ys+7pQEuaLRsyYYrj5qmxGdjWW6oHFy9P-dxqA@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: Defer connection-parameter removal when unpairing
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

> I see that, when receiving a Disconnect Complete event,
> hci_disconn_complete_evt() deallocates the connection. But ...
>
> 1. What if the controller misbehaves and doesn't send a Disconnect
> Complete event? AFAIU, the connection will never be deallocated in
> this case.
>
> Wouldn't it make sense to have a timer for this? e.g. make
> hci_disconnect() queue hci_conn_timeout() and, in the later, delete
> the connection if it's not referenced and it was already marked as
> closed.
>
> 2. What if the controller sends an error in the Command Status event
> and the Disconnect Complete never arrives?
>
> I see that  hci_cs_disconnect() notifies userland if it was triggered
> through mgmt, but it doesn't provide a retry mechanism in case the
> disconnection came from the kernel itself. In fact, what happens with
> the connection's deallocation in this case? Is it ensured in any way?

3. What if the controller sends an error in the Disconnect Complete? I
see the same issues as in (2).


-- 
Alfonso Acosta

Embedded Systems Engineer at Spotify
Birger Jarlsgatan 61, Stockholm, Sweden
http://www.spotify.com
