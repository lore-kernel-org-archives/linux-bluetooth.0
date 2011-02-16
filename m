Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110215212022.GG7219@joana>
References: <1297459736-24514-1-git-send-email-claudio.takahasi@openbossa.org>
	<1297459736-24514-4-git-send-email-claudio.takahasi@openbossa.org>
	<20110215212022.GG7219@joana>
Date: Wed, 16 Feb 2011 11:09:50 -0200
Message-ID: <AANLkTinJmoaepBp+C6VnXSZ1P06CNYzJwJiTFJ7bAFDm@mail.gmail.com>
Subject: Re: [RFC 3/3] Bluetooth: Send LE Connection Update Command
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Tue, Feb 15, 2011 at 7:20 PM, Gustavo F. Padovan
<padovan@profusion.mobi> wrote:
> Hi Claudio,
>
> * Claudio Takahasi <claudio.takahasi@openbossa.org> [2011-02-11 19:28:56 -0200]:
>
>> If the new connection update parameter are accepted, the LE master
>> host sends the LE Connection Update Command to its controller informing
>> the new requested parameters.
>>
>> Signed-off-by: Claudio Takahasi <claudio.takahasi@openbossa.org>
>> ---
>>  include/net/bluetooth/hci.h      |   11 +++++++++++
>>  include/net/bluetooth/hci_core.h |    2 ++
>>  net/bluetooth/hci_conn.c         |   20 ++++++++++++++++++++
>>  net/bluetooth/l2cap_core.c       |    7 ++++++-
>>  4 files changed, 39 insertions(+), 1 deletions(-)
>
> Actually it is this one that doesn't apply, not 2 of 3.
>
> --
> Gustavo F. Padovan
> http://profusion.mobi
>

I will rebase it against bluetooth-next. All patches were using
Vinicius SMP branch as baseline.

Br,
Claudio
