Return-Path: <cyrus@holtmann.org>
Date: Fri, 11 Jun 2010 23:46:52 +0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Tim Renouf <tpr.vger@botech.co.uk>, linux-bluetooth@vger.kernel.org
Subject: Re: bug and possible patch for dbus DiscoverServices
Message-ID: <20100611154652.GA22315@jh-x301>
References: <20100610125848.GA28631@botech.co.uk>
 <AANLkTinlsskks35CHsSlDueAGCi4HeicWjHLUTQcfzYC@mail.gmail.com>
 <20100610202023.GC16611@botech.co.uk>
 <AANLkTinQ_Tr5fwNquGwW9o5LIuqpAGCqHveGuAA1Av3O@mail.gmail.com>
 <AANLkTilSgydF3eH61rsSZlHILBeW7Yoo-VtpcLzgQUzt@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTilSgydF3eH61rsSZlHILBeW7Yoo-VtpcLzgQUzt@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Fri, Jun 11, 2010, Luiz Augusto von Dentz wrote:
> There were some problems with the changes I suggested previously,
> basically  device_probe_drivers was freeing there records before we
> return. The following patches should fix this issue and another one
> with btd_device_get_record not looking into records storage when it is
> missing on temporary cache.

Both patches seem fine me (I hope you tested them too) and have now been
pushed upstream. Thanks.

Johan
