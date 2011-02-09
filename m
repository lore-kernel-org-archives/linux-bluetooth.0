Return-Path: <cyrus@holtmann.org>
Date: Wed, 9 Feb 2011 12:18:18 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Andre Dieb Martins <andre.dieb@signove.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 5/7] Better ATT dump format
Message-ID: <20110209141818.GC1995@joana>
References: <1297260110-10515-1-git-send-email-andre.dieb@signove.com>
 <1297260110-10515-5-git-send-email-andre.dieb@signove.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1297260110-10515-5-git-send-email-andre.dieb@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

* Andre Dieb Martins <andre.dieb@signove.com> [2011-02-09 11:01:48 -0300]:

> ---
>  parser/att.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)

This patch should not exist, make these changes in the patch the actually
introduced this code for the first time. 'git rebase -i'  is your friend. ;)

-- 
Gustavo F. Padovan
http://profusion.mobi
