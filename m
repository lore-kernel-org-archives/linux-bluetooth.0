Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1367912644-17401-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1367912644-17401-1-git-send-email-mikel.astiz.oss@gmail.com>
Date: Tue, 7 May 2013 11:51:05 -0300
Message-ID: <CAE6HaMmP6VzUdqn1xNfo5zC2_Bx33cJ5bR37FAwU_fOSa7-WYQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1 0/3] Issue with incoming connections
From: Vinicius Gomes <vinicius.gomes@openbossa.org>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Tue, May 7, 2013 at 4:44 AM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
>
> Vinicius reported this issue and tried to fix it in his patch "profile: Create a service for incomming connections".
>
> As compared to his original patch, this patchset avoid creating an additional service instance (which should already be created) and instead performs a search within the list of existing services for the given device.

In the AG case when the external profile registers itself with the
"server" role, the service doesn't get created.

Nowadays, the service is created when the service is probed (with
requires profile->device_probe), which doesn't happen for "adapter"
services. I am still not sure about the right place/time to create the
service for these cases.

But this is another problem. Apart from the minor issue pointed in
3/3, you have my Ack.

>
> Patch 2/3 is the actual fix which makes use of patch 1/1.
>
> Patch 3/3 is an attempt to make the code more robust, but I'm not 100% sure if there are cases where the device can be set to NULL as handled in the upstream create_conn() body as first introduced in 86842030039583d092a1d3ce5004e7bc5b7d2b01.
>
> Mikel Astiz (3):
>   device: Add function to find a given service
>   profile: Fix remotely initiated connections without service
>   profile: Error-cases for incoming connections
>
>  src/device.c  | 16 ++++++++++++++++
>  src/device.h  |  3 +++
>  src/profile.c | 26 +++++++++++++++++++++-----
>  3 files changed, 40 insertions(+), 5 deletions(-)
>
> --
> 1.8.1.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Cheers,
--
Vinicius
