Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120809094323.GB32525@pzkagis.cz>
References: <20120809094323.GB32525@pzkagis.cz>
Date: Thu, 9 Aug 2012 12:49:09 +0300
Message-ID: <CABBYNZJ-O+_QHMwir6gR+C8cagSqDxEdT=OBwVVULtyDGv2NQA@mail.gmail.com>
Subject: Re: Obexd 0.46: PBAP and GetSize
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Ludek Finstrle <luf@pzkagis.cz>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ludek,

On Thu, Aug 9, 2012 at 12:43 PM, Ludek Finstrle <luf@pzkagis.cz> wrote:
> Hello,
>
>   I see strange behaviour with my obexd 0.46 on N900 (ARM) and pbap-client on notebook (x86_64):
>
> --- Select Phonebook CCH ---
>
>
> --- GetSize ---
>
> Size = 12802
>
>
> --- List vCard ---
>
> ...
> 562.vcf : Name
> BEGIN:VCARD
> VERSION:2.1
> N:Name
> Tel:Number
> END:VCARD
>
> --- PullAll ---
> ...
>
> Binary representation of the numbers:
> 12802
> 0011001000000010
> 562
> 0000001000110010
>
> (another numbers):
> 15360
> 0011110000000000
> 60
> 0000000000111100
>
> As you can see there is swapped bytes. Can someone reproduce the problem?
> Has anyone idea where should be the problem (it seems like little x big endians)?

Here it works fine but it might be because my machine is little
endian, anyway Im about the send some changes in the way we handle
application parameters like this.

-- 
Luiz Augusto von Dentz
