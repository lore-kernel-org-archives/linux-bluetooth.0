Return-Path: <cyrus@holtmann.org>
Date: Sun, 10 Feb 2013 22:30:31 +0100
From: Antonio Ospite <ospite@studenti.unina.it>
To: linux-bluetooth@vger.kernel.org
Cc: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: [PATCH BlueZ 0/2] Add device_set_trusted()
Message-Id: <20130210223031.4664505f4625616ebbd32052@studenti.unina.it>
In-Reply-To: <1359908071-15024-1-git-send-email-ospite@studenti.unina.it>
References: <1359908071-15024-1-git-send-email-ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sun,  3 Feb 2013 17:14:29 +0100
Antonio Ospite <ospite@studenti.unina.it> wrote:

> Hi,
> 
> In patch 1 a device_set_trusted() function is proposed, which I plan to
> use for the playstation-peripheral plugin; I am in the process of
> rebasing the plugin on top of BlueZ 5.2.
> 
> In patch 2 the newly introduced function is used in order to avoid some
> duplication.
> 
> device_set_trusted() looks a lot like device_set_temporary() and
> device_set_legacy(), I hope it makes sense to you too.
>
> Thanks,
>    Antonio
> 
> Antonio Ospite (2):
>   device: add a device_set_trusted() function
>   device: use device_set_trusted() in set_trust()
>

Ping for these two patches.
 
>  src/device.c |   30 +++++++++++++++++++-----------
>  src/device.h |    1 +
>  2 files changed, 20 insertions(+), 11 deletions(-)
> 

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
