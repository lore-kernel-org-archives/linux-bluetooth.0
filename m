Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1284550124-31201-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1284550124-31201-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Mon, 27 Sep 2010 15:50:43 +0300
Message-ID: <AANLkTikH-aTpvOM_NRgkZ0tiDGO=C0+8eOOL70nKJS0Z@mail.gmail.com>
Subject: Re: [PATCHv4 0/3] Bluetooth: L2CAP robustness fixes
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Ping

On Wed, Sep 15, 2010 at 2:28 PM, Emeltchenko Andrei
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
>
> Fixes increase L2CAP robustness to DOS attacks to BT stack.
> Updated version after comments from Mat Martineau <mathewm@codeaurora.org>
> and Gustavo Padovan <padovan@profusion.mobi>.
>
> Andrei Emeltchenko (3):
>  Bluetooth: fix MTU L2CAP configuration parameter
>  Bluetooth: check for l2cap header in start fragment
>  Bluetooth: check L2CAP length in first ACL fragment
>
>  net/bluetooth/l2cap.c |   25 +++++++++++++++++++++----
>  1 files changed, 21 insertions(+), 4 deletions(-)
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
