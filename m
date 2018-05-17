Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: [PATCH BlueZ] shared/io-ell: Add support for ELL based IO
 handling
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
        "Stotland, Inga" <inga.stotland@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <20180514235614.25231-1-inga.stotland@intel.com>
 <C65C87C6-375D-46B1-8CB1-3C96EF9939E4@holtmann.org>
 <5b6349ba-e0dd-8b56-5654-c1e0e20be4a8@gmail.com>
 <CABBYNZ+dmaLOTOJgYMoLS2jzWNZCqHYjVvcJsKYiFTgv1en-wg@mail.gmail.com>
 <7edd28a2-c446-2323-169a-b8630fdb1557@gmail.com>
 <CABBYNZ+TVBd83x_28BzQM9-qwymtXU19gc5CKYW=o12Ljw1Szg@mail.gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
Message-ID: <22877125-36df-f879-1a0c-aff57ce380c9@gmail.com>
Date: Thu, 17 May 2018 11:29:51 -0500
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+TVBd83x_28BzQM9-qwymtXU19gc5CKYW=o12Ljw1Szg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

>> I would rather not do that actually.  It is already weird that you guys have
>> io_send but not io_recv.  And since io is not only used with streams /
>> files, but with datagram sockets as well, we would have to add a bunch of
>> methods for symmetry.  Not to mention that somehow 'send' uses iovecs and
>> the convention inside ell for this is to suffix the method with a 'v'.
> 
> Ive thought of adding io_recv, it just that it was not necessary by
> anyone currently, anyway I guess having _v alternative makes ell play
> nice if the application is using iovec, or you are saying that with
> ell the application would have to use the fd directly and handle
> errors?

Right, that's the intent of the ell api.  We only handle the mainloop 
integration with io.  The actual send/recv/write/read/etc should be 
handled outside l_io to keep the l_io API minimal.  There are too many 
variations between socket types, streams, etc.  Most of our projects 
bypassed the weird GLib I/O functions (with its buffering semantics, 
etc) and just invoked the system calls directly anyway.

>> By the way, correct me if I'm wrong, but I think there is zero need for
>> TEMP_FAILURE_RETRY inside BlueZ since it uses signalfd and non-blocking IO
>> anyway.  The only reason ell uses this macro is because we can't assume how
>> signals are used in the enclosing application.
> 
> Usually, BlueZ tools would use signalfd, including the daemon, we
> could perhaps remove the handling of EINTR if we could detect if
> signalfd is in fact being used but I don't know if that is possible,
> so better be save than sorry.

So I personally wouldn't introduce quasi-ell API that is not mirrored 
inside ell proper.  That will just make your job harder in the future. 
And if the caller of io_send just handles the writev invocation you can 
know exactly if TEMP_FAILURE_RETRY is needed or not.

Ideally this file should not exist.  You might get away with just 
(struct l_io *) io or vice-versa.

Regards,
-Denis
