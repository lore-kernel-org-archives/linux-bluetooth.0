Return-Path: <cyrus@holtmann.org>
Date: Tue, 15 Feb 2011 18:20:22 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 3/3] Bluetooth: Send LE Connection Update Command
Message-ID: <20110215212022.GG7219@joana>
References: <1297459736-24514-1-git-send-email-claudio.takahasi@openbossa.org>
 <1297459736-24514-4-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1297459736-24514-4-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

* Claudio Takahasi <claudio.takahasi@openbossa.org> [2011-02-11 19:28:56 -0200]:

> If the new connection update parameter are accepted, the LE master
> host sends the LE Connection Update Command to its controller informing
> the new requested parameters.
> 
> Signed-off-by: Claudio Takahasi <claudio.takahasi@openbossa.org>
> ---
>  include/net/bluetooth/hci.h      |   11 +++++++++++
>  include/net/bluetooth/hci_core.h |    2 ++
>  net/bluetooth/hci_conn.c         |   20 ++++++++++++++++++++
>  net/bluetooth/l2cap_core.c       |    7 ++++++-
>  4 files changed, 39 insertions(+), 1 deletions(-)

Actually it is this one that doesn't apply, not 2 of 3.

-- 
Gustavo F. Padovan
http://profusion.mobi
