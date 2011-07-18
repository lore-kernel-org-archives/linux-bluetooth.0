Return-Path: <cyrus@holtmann.org>
Date: Mon, 18 Jul 2011 17:43:17 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd] Fix quoting in readline checks
Message-ID: <20110718144317.GA4504@dell.ger.corp.intel.com>
References: <1310988263-4944-1-git-send-email-lkslawek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1310988263-4944-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Slawek,

On Mon, Jul 18, 2011, Slawomir Bochenski wrote:
> Readline check was underquoted causing not very helpful error message
> when readline is missing.
> ---
>  acinclude.m4 |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

Applied. Thanks.

Johan
