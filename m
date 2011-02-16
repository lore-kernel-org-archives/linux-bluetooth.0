Return-Path: <cyrus@holtmann.org>
Date: Wed, 16 Feb 2011 20:15:01 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 3/3 v2] Bluetooth: Send LE Connection Update Command
Message-ID: <20110216231501.GJ14085@joana>
References: <AANLkTinJmoaepBp+C6VnXSZ1P06CNYzJwJiTFJ7bAFDm@mail.gmail.com>
 <1297896293-6057-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1297896293-6057-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

* Claudio Takahasi <claudio.takahasi@openbossa.org> [2011-02-16 20:44:53 -0200]:

> If the new connection update parameter are accepted, the LE master
> host sends the LE Connection Update Command to its controller informing
> the new requested parameters.
> 
> Signed-off-by: Claudio Takahasi <claudio.takahasi@openbossa.org>
> ---
>  include/net/bluetooth/hci.h      |   11 +++++++++++
>  include/net/bluetooth/hci_core.h |    2 ++
>  net/bluetooth/hci_conn.c         |   20 ++++++++++++++++++++
>  net/bluetooth/l2cap_core.c       |    8 +++++++-
>  4 files changed, 40 insertions(+), 1 deletions(-)

Applied, thanks.

-- 
Gustavo F. Padovan
http://profusion.mobi
