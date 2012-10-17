Return-Path: <cyrus@holtmann.org>
Date: Wed, 17 Oct 2012 11:03:20 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Ludek Finstrle <luf@pzkagis.cz>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Memory leak introduced in commit
 f8619bef3406a2134082dc41c208105fe028c09f
Message-ID: <20121017140320.GA30533@samus>
References: <20121017124931.GA32194@pzkagis.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20121017124931.GA32194@pzkagis.cz>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luf,

On 14:49 Wed 17 Oct, Ludek Finstrle wrote:
> Hello,
> 
>   I see memory leak which was introduced in commit f8619bef3406a2134082dc41c208105fe028c09f:
> attrib: Fix not checking if att_data_list_alloc fails
> 
> It returns (in src/attrib-server.c) from functions when adl local variable is NULL but 
> it doesn't free local variables (read_by_group: group; read_by_type: type; find_info: info).

Thanks a lot for the report.

Ugh, I will fix it.

> 
> The patch is very easy but I can't test it with head so I don't want to send possible
> crapy patch.
> 
> Luf
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Cheers,
-- 
Vinicius
