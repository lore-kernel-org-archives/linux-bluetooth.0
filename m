Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20121017124931.GA32194@pzkagis.cz>
References: <20121017124931.GA32194@pzkagis.cz>
Date: Wed, 17 Oct 2012 11:08:16 -0300
Message-ID: <CAJdJm_NiL522WPLrV-RiaJKBZeOBBgo_vSzQCwTdZwLZLTw88A@mail.gmail.com>
Subject: Re: Memory leak introduced in commit f8619bef3406a2134082dc41c208105fe028c09f
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Ludek Finstrle <luf@pzkagis.cz>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ludek,

On Wed, Oct 17, 2012 at 9:49 AM, Ludek Finstrle <luf@pzkagis.cz> wrote:
> Hello,
>
>   I see memory leak which was introduced in commit f8619bef3406a2134082dc41c208105fe028c09f:
> attrib: Fix not checking if att_data_list_alloc fails
>
> It returns (in src/attrib-server.c) from functions when adl local variable is NULL but
> it doesn't free local variables (read_by_group: group; read_by_type: type; find_info: info).
>
> The patch is very easy but I can't test it with head so I don't want to send possible
> crapy patch.

Please feel free to send it marked as RFC on the subject (e.g. "[RFC]
bla bla") and rebased against master, so we can review the fix.

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
