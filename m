Return-Path: <cyrus@holtmann.org>
Date: Thu, 24 Mar 2011 16:12:42 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv1 3/3] Bluetooth: delete hanging L2CAP channel
Message-ID: <20110324191242.GD2236@joana>
References: <1300979768-31963-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1300979768-31963-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1300979768-31963-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2011-03-24 17:16:08 +0200]:

> From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
> 
> Sometimes L2CAP connection remains hanging. Make sure that
> L2CAP channel is deleted.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
> ---
>  net/bluetooth/l2cap_sock.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)

This one is applied. Thanks.

-- 
Gustavo F. Padovan
http://profusion.mobi
