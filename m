Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1324385848-19101-1-git-send-email-padovan@profusion.mobi>
References: <1324385848-19101-1-git-send-email-padovan@profusion.mobi>
Date: Tue, 20 Dec 2011 09:09:23 -0400
Message-ID: <CAJdJm_MEhpZduv8N8_tk5qxHuyto-0U6P-Sr_v_-SXC=hsXKWw@mail.gmail.com>
Subject: Re: [PATCH 1/3] Bluetooth: Nove l2cap_{set,clear}_timer to l2cap.h
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Padovan,

On Tue, Dec 20, 2011 at 8:57 AM, Gustavo F. Padovan
<padovan@profusion.mobi> wrote:
> From: "Gustavo F. Padovan" <padovan@profusion.mobi>
>
> It is the only place where it is used.

I don't understand. If l2cap.h is the only place where it is used, how
it used to work/compile before? I can only imagine that the macros
using   l2cap_{set,clear}_timer  are in l2cap_core.c , in which case
they should be moved to l2cap_core.c , not the other way around?

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
