Return-Path: <cyrus@holtmann.org>
Date: Fri, 29 Jun 2012 14:29:29 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: Re: [PATCH] test: add test-audiosource
Message-ID: <20120629112929.GB24842@x220>
References: <1339739557-6992-1-git-send-email-gustavo@padovan.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1339739557-6992-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Fri, Jun 15, 2012, Gustavo Padovan wrote:
> From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> 
> ---
>  Makefile.tools        |    2 +-
>  test/test-audiosource |   46 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 47 insertions(+), 1 deletion(-)
>  create mode 100644 test/test-audiosource

I suppose this patch has to be updated to be python 3 compliant since we
already applied the patch to convert all existing scripts.

Johan
