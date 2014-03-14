Return-Path: <cyrus@holtmann.org>
Date: Fri, 14 Mar 2014 13:30:31 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Natanael Copa <ncopa@alpinelinux.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 0/3] Various build fixes for building bluez with musl libc
Message-ID: <20140314113031.GA15333@localhost.P-661HNU-F1>
References: <1394791167-29933-1-git-send-email-ncopa@alpinelinux.org>
 <20140314110719.GA11158@localhost.P-661HNU-F1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20140314110719.GA11158@localhost.P-661HNU-F1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Mar 14, 2014, Johan Hedberg wrote:
> On Fri, Mar 14, 2014, Natanael Copa wrote:
> > The following fixes are needed to make bluez build on Alpine Linuz with
> > musl libc.
> > 
> > This is kind of a rebase of the previously posted patches:
> > http://www.spinics.net/lists/linux-bluetooth/msg43070.html
> > 
> > Changes since then are:
> > - mention Alpine Linux in commit message
> > - rebase to current git
> > - added fix for proper header include for be32toh, htobe32 and htobe64
> > 
> > Please note that "unit: prevent unintended use of glibc's error(3)"
> > fixes a bug in the unit test that affects glibc too. I suppose that if
> > you add a testcase that triggers any error logging from sdpd-request.c
> > it will likely segfault instead of gracfully hande the error condition.
> > (it only affects the unit test though)
> > 
> > Natanael Copa (3):
> >   shared: include endian.h for be32toh, htobe32 and htobe64 functions
> >   unit: prevent unintended use of glibc's error(3)
> >   bnep: avoid use of caddr_t
> > 
> >  Makefile.am             | 1 +
> >  profiles/network/bnep.c | 4 ++--
> >  src/shared/btsnoop.c    | 1 +
> >  unit/test-sdp.c         | 9 +++------
> >  4 files changed, 7 insertions(+), 8 deletions(-)
> 
> I've applied patches 1 and 3, but am waiting for a v2 on patch 2 since
> it breaks the build:
> 
> unit/test-sdp.c: In function ‘main’:
> unit/test-sdp.c:795:3: error: implicit declaration of function ‘__btd_log_init’ [-Werror=implicit-function-declaration]
>    __btd_log_init("*", 0);

I went ahead and fixed the missing include myself. The patch is now
applied.

Johan
