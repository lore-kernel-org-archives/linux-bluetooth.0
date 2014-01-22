Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140122170730.35ecc008@ncopa-desktop.alpinelinux.org>
References: <CABBYNZLmpK51xe80XxAwT7rBRkUGsZNhcmMWSnHSyuY--meu_w@mail.gmail.com>
	<1390398620-1916-1-git-send-email-ncopa@alpinelinux.org>
	<1390398620-1916-2-git-send-email-ncopa@alpinelinux.org>
	<CAJdJm_Mo=hGHMYFhurEO2+L_UPpT3YPy-is020d1_CMrXzDeRw@mail.gmail.com>
	<20140122170730.35ecc008@ncopa-desktop.alpinelinux.org>
Date: Wed, 22 Jan 2014 14:06:42 -0400
Message-ID: <CAJdJm_MB5gAK2-9--n=P-Mni1WBRK8o-zaLSkA=_+0Bc6cCVjQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] various header include fixes for building with
 musl libc
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Natanael Copa <natanael.copa@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Natanael Copa <ncopa@alpinelinux.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Natanael,

On Wed, Jan 22, 2014 at 12:07 PM, Natanael Copa <natanael.copa@gmail.com> wrote:
> The header itself uses mode_t:
> ./src/textfile.h:27:1: error: unknown type name 'mode_t'
>
> So all the files that include textfiles.h needs to include sys/stat.h
> *before* the include textfile.h in that case.
>
> I'd say that all filesm that uses mode_t including textfile.h should
> include sys/stat.h.
>
> I can make a new patch for either. Just let me know what you want.

This is how we have done so far for files in src/* (for src/shared/ as
Marcel mentioned this is being done differently). So I suggest you do
this way.

Note that several files (about 5 out of 10) already include
sys/stat.h, according to a quick grep I did. Maybe they are just not
in the right order.

Best Regards,
-- 
Anderson Lizardo
INdT - Manaus - Brazil
