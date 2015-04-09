Return-Path: <cyrus@holtmann.org>
Date: Thu, 9 Apr 2015 12:42:43 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Florian Grandel <fgrandel@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [BlueZ v2 0/3] Minor improvements to the docs and mgmt API tests
Message-ID: <20150409094243.GA10676@t440s.lan>
References: <1428259165-10021-3-git-send-email-fgrandel@gmail.com>
 <1428261088-14121-1-git-send-email-fgrandel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1428261088-14121-1-git-send-email-fgrandel@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Florian,

On Sun, Apr 05, 2015, Florian Grandel wrote:
> v1 -> v2: found more instances of misleading test messages
> 
> Florian Grandel (3):
>   doc: fix minor typos
>   tools: fix misleading test output
>   tools: add read adv features success tests
> 
>  doc/coding-style.txt          |  2 +-
>  doc/maintainer-guidelines.txt |  2 +-
>  doc/test-coverage.txt         |  2 +-
>  tools/mgmt-tester.c           | 37 +++++++++++++++++++++++++++++++++----
>  4 files changed, 36 insertions(+), 7 deletions(-)

All three patches have been applied. Thanks.

One note: I had to manually remove the "Signed-off-by" from one patch
1/3 since we don't use that for the user space tree.

Johan
