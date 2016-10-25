Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Tue, 25 Oct 2016 12:26:41 -0400
From: Don Zickus <dzickus@redhat.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Luiz Augusto Von Dentz <luiz.von.dentz@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Commit 375d02473fb prevents obexd from accepting profile
 connections
Message-ID: <20161025162641.GC35881@redhat.com>
References: <20161025160436.GB35881@redhat.com>
 <CABBYNZJs0AvzH9K=X209VyCbanqHeec0X1k3QFYVWod9YvgvNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CABBYNZJs0AvzH9K=X209VyCbanqHeec0X1k3QFYVWod9YvgvNA@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Oct 25, 2016 at 07:08:00PM +0300, Luiz Augusto von Dentz wrote:
> This has been resolved in:
> 
> commit ccd29841c3799c68ed90eb050661ffeccea78c9b
> Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> Date:   Mon Oct 24 19:32:57 2016 +0300
> 
>     core/profile: Fix calling service_accept
> 
>     service_accept shall only be used with profiles that implement .accept
>     callback, to set connecting state directly use service_set_connecting
>     which does not require .accept to be implemented.

Hi Luiz,

Great, thanks!  Yes that worked for me!

Cheers,
Don
