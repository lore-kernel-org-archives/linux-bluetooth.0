Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1274883694-18120-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1274883694-18120-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Mon, 7 Jun 2010 17:11:28 +0300
Message-ID: <AANLkTinfV50-6wEG8ylEc6XTZXtCpcwZDYick-0GcIlO@mail.gmail.com>
Subject: Re: [PATCHv1 0/2] Don't delete l2cap chan and sk when sk is owned by
	user
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, May 26, 2010 at 5:21 PM, Emeltchenko Andrei
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
>
> When sk is owned by user we shall not delete l2cap shannel structures and socket sk.
> The first patch which is less hackish than using timer to delete l2cap channel.
>
> Andrei Emeltchenko (2):
>  Bluetooth: Check sk is not owned before freeing l2cap_conn
>  Bluetooth: Prevent sk freeing in tasklet using refcount
>
>  net/bluetooth/l2cap.c |   16 +++++++++++++---
>  1 files changed, 13 insertions(+), 3 deletions(-)

Ping
