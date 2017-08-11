Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] gdbus: Fix calling GetAll while GetManagedObject is pending
In-Reply-To: <20170811125815.964-1-luiz.dentz@gmail.com>
References: <20170811125815.964-1-luiz.dentz@gmail.com>
Date: Fri, 11 Aug 2017 12:56:17 -0700
Message-ID: <87shgxev4u.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

Luiz Augusto von Dentz <luiz.dentz@gmail.com> writes:

> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> If proxies are created while the client is not ready put them into a
> pending list so only if they are not found in GetManagedObject reply
> call GetAll.

I tested this with a hacked gdbus/object.c to get into that
GetAll/GetManagedObjects condtion, and it works.

I just think that it could be simplified somewhat. What I am thinking is
that we don't need a "pending" list, each proxy can have a 'pending'
boolean, and instead we add it to proxy_list as soon as it is allocated.

I didn't try it, but it feels like it would work.

What do you think?

If you don't think it would work, or that it would end up harder to
read, this patch looks good to me.


Cheers,
--
Vinicius
