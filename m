Return-Path: <cyrus@holtmann.org>
Date: Wed, 5 Mar 2014 22:32:37 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Natanael Copa <natanael.copa@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Natanael Copa <ncopa@alpinelinux.org>
Subject: Re: [PATCH v3] various header include fixes for building with musl
 libc
Message-ID: <20140305203237.GA13142@localhost.P-661HNU-F1>
References: <CAJdJm_MB5gAK2-9--n=P-Mni1WBRK8o-zaLSkA=_+0Bc6cCVjQ@mail.gmail.com>
 <1390425638-15241-1-git-send-email-ncopa@alpinelinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1390425638-15241-1-git-send-email-ncopa@alpinelinux.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Natanael,

On Wed, Jan 22, 2014, Natanael Copa wrote:
> we need:
>  sys/stat.h for mode_t
>  limits.h for PATH_MAX
> 
> Fixes compile errors:
> In file included from tools/hciconfig.c:45:0:
> ./src/textfile.h:27:1: error: unknown type name 'mode_t'
>  int create_file(const char *filename, const mode_t mode);
>  ^
> 
> tools/csr_usb.c: In function 'read_value':
> tools/csr_usb.c:71:12: error: 'PATH_MAX' undeclared (first use in this function)
>   char path[PATH_MAX];
>             ^
> ---
> Changes v2 -> v3:
>  - include the sys/stat.h in hciconfig.c instead of textfile.h. This was
>    the only needed change for defining mode_t everywhere.
> 
>  tools/csr_usb.c   | 1 +
>  tools/hciconfig.c | 1 +
>  tools/hid2hci.c   | 1 +
>  3 files changed, 3 insertions(+)

Seems this patch was forgotten. It has now finally been applied
upstream.

Johan
