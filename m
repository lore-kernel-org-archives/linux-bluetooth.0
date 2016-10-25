Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20161025160436.GB35881@redhat.com>
References: <20161025160436.GB35881@redhat.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 25 Oct 2016 19:08:00 +0300
Message-ID: <CABBYNZJs0AvzH9K=X209VyCbanqHeec0X1k3QFYVWod9YvgvNA@mail.gmail.com>
Subject: Re: Commit 375d02473fb prevents obexd from accepting profile connections
To: Don Zickus <dzickus@redhat.com>
Cc: Luiz Augusto Von Dentz <luiz.von.dentz@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Don,

On Tue, Oct 25, 2016 at 7:04 PM, Don Zickus <dzickus@redhat.com> wrote:
> Hi Luiz,
>
> I was testing 5.42 with my OBEX testsuite and noticed it stopped working due
> to the following commit:
>
> commit 375d02473fb7f8b90e39bc79001ab6f97a81bd3b
> Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> Date:   Mon Aug 8 13:33:35 2016 +0300
>
>     core/service: Fix setting connecting state
>
>     If the profile don't implement .accept callback it means it cannot
>     connect in this mode, which is normally used for GATT profiles, so the
>     code shall not assume the service will start connecting and instead just
>     return an error.
>
> diff --git a/src/service.c b/src/service.c
> index 0da14ab..f387fc4 100644
> --- a/src/service.c
> +++ b/src/service.c
> @@ -197,7 +197,7 @@ int service_accept(struct btd_service *service)
>         }
>
>         if (!service->profile->accept)
> -               goto done;
> +               return -ENOSYS;
>
>         err = service->profile->accept(service);
>         if (!err)
>
>
> It seems all the OBEX profiles lack an .accept function and therefore get
> rejected now?
>
> Unless my test environment is misconfigured.  Basically, I have two machines
> next to each other, one runs a python script to register an authorization
> agent and obex agent and then sits there waiting for remote connections.
> The other machine tries to walk through the various obex apis to connect
> with the server and exchange data.
>
> Any setup of an obex connection with the server is terminated and my tests
> fail.  Thoughts?

This has been resolved in:

commit ccd29841c3799c68ed90eb050661ffeccea78c9b
Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date:   Mon Oct 24 19:32:57 2016 +0300

    core/profile: Fix calling service_accept

    service_accept shall only be used with profiles that implement .accept
    callback, to set connecting state directly use service_set_connecting
    which does not require .accept to be implemented.

-- 
Luiz Augusto von Dentz
