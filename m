Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1320440796.15441.299.camel@aeonflux>
References: <1320415430-2054-1-git-send-email-luiz.dentz@gmail.com>
	<1320440796.15441.299.camel@aeonflux>
Date: Tue, 15 Nov 2011 11:53:17 +0200
Message-ID: <CABBYNZK469cXc3GmBjrY5rVEycGrMb0RzqmoLSU8-R11kjhPFw@mail.gmail.com>
Subject: Re: [PATCH 1/2] Bluetooth: make L2CAP sockets to inherit parent's priority
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Nov 4, 2011 at 11:06 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Luiz,
>
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> This makes priority set on a listen socket to be passed when accepting
>> new connections.
>
> I am in general fine with this, but is this the expected behavior of
> SO_PRIORITY from other socket types?

Apparently it is not inherited in other socket types, so I guess we
should not inherit. In this case I will fix l2test/rctest to use
setsockopt on accepted sockets, similar to what is done with
SO_LINGER.

-- 
Luiz Augusto von Dentz
