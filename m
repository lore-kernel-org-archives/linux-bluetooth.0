Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1392052498-9229-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1392052498-9229-1-git-send-email-anderson.lizardo@openbossa.org>
Date: Mon, 17 Feb 2014 07:56:57 -0400
Message-ID: <CAJdJm_MgzPVKCX5r2VUnW043e+FeAYgcuf1pjGUwgNqjoSzr=Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/3] gdbus: Fix memory leak
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Feb 10, 2014 at 1:14 PM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> data->conn and data->path must be destroyed before freeing "data".
> ---
>  gdbus/object.c |    2 ++
>  1 file changed, 2 insertions(+)

ping.

-- 
Anderson Lizardo
http://www.indt.org/?lang=en
INdT - Manaus - Brazil
