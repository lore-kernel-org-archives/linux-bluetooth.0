Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1284018181-29928-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1284018181-29928-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Tue, 14 Sep 2010 16:48:54 +0300
Message-ID: <AANLkTinsx1RL6m5FO+W3FAHTjANwoup3GV0HzyXt1G12@mail.gmail.com>
Subject: Re: [PATCHv3 0/3] Bluetooth: L2CAP robustness fixes
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

ping

On Thu, Sep 9, 2010 at 10:42 AM, Emeltchenko Andrei
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
>
> Fixes increase L2CAP robustness to DOS attacks to BT stack.
>
> Andrei Emeltchenko (3):
>  Bluetooth: fix MTU L2CAP configuration parameter
>  Bluetooth: check for l2cap header in start fragment
>  Bluetooth: check L2CAP length in first ACL fragment
>
>  net/bluetooth/l2cap.c |   26 ++++++++++++++++++++++----
>  1 files changed, 22 insertions(+), 4 deletions(-)
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
