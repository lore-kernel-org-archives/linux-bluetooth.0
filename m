Return-Path: <cyrus@holtmann.org>
Date: Wed, 23 Mar 2011 15:00:00 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v5 3/4] Sim Access Profile dummy driver
Message-ID: <20110323130000.GA20755@jh-x301>
References: <1300277421-8053-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <1300277421-8053-3-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1300277421-8053-3-git-send-email-waldemar.rymarkiewicz@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Waldek,

On Wed, Mar 16, 2011, Waldemar Rymarkiewicz wrote:
> Add SAP dummy driver implementation and extend configure
> with --with-sap=<driver>.
> ---
>  .gitignore      |    1 +
>  Makefile.am     |   13 +++-
>  acinclude.m4    |    6 ++
>  sap/sap-dummy.c |  269 ++++++++++++++++++++++++++++++++++++++++++++++++++++---
>  4 files changed, 275 insertions(+), 14 deletions(-)

The first three patches have been pushed upstream. Thanks. However, I
hope you do pay attention the refactoring suggestions that were made and
keep a look-out for possibilities for simplifying the code.

Johan
