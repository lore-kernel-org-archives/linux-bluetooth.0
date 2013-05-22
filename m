Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1369259656-19683-1-git-send-email-hdante@profusion.mobi>
References: <1369259656-19683-1-git-send-email-hdante@profusion.mobi>
Date: Wed, 22 May 2013 18:35:29 -0400
Message-ID: <CAJdJm_NqYT_3nVHCzenwd2UOvsxnMZGY1FKzxKWbYTZt-jxn6g@mail.gmail.com>
Subject: Re: [PATCH RFC] gdbus: Remove proxies when client disconnects
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Henrique Dante de Almeida <hdante@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Henrique,

On Wed, May 22, 2013 at 5:54 PM, Henrique Dante de Almeida
<hdante@profusion.mobi> wrote:
> Remove proxies and generate proxy_removed callbacks even when there are
> no corresponding InterfaceRemoved signals.
> ---

I think that, for the records, it is a good idea to explain on the
commit message at which circumstances the bug is triggered.

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
