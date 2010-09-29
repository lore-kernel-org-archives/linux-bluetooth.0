Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20100929134521.GA19362@jh-x301>
References: <AANLkTindKFz1fx9cJMu9aSpehG5LaUHHO7TkgWqMzqj=@mail.gmail.com>
	<20100929134521.GA19362@jh-x301>
Date: Wed, 29 Sep 2010 11:05:46 -0300
Message-ID: <AANLkTimvvp=D+X+TcP3Ji7WuGaMZF7+LA+8BWZiQCStr@mail.gmail.com>
Subject: Re: Pull request: git://git.infradead.org/users/cktakahasi/bluez.git for-upstream
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Sep 29, 2010 at 10:45 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Claudio,
>
> On Thu, Sep 23, 2010, Claudio Takahasi wrote:
>>       Rename hciops {start, stop}_discovery to {start, stop}_inquiry
>
> I'm not sure about this patch. Wasn't the idea to hide the device
> discovery details from the higher layers? I.e. the method could be
> called discovery and it'd take care of both BR/EDR and LE discovery
> methods.
>
> Johan
>

Hi Johan,

StartDiscovery() triggers all the process. The adapter type: BR/EDR
only/LE only or dual mode is hidden from the higher layers.
So, your suggestion it try to hide all discovery details inside the
hciops as much as possible? I am not sure at the moment if it is
possible, but we can try. We need to clean the code anyway in order to
have a "smooth" migration to the new Bluetooth Management Interface.

Regards,
Claudio
