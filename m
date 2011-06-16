Return-Path: <cyrus@holtmann.org>
Date: Thu, 16 Jun 2011 10:42:56 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd] Fix build when pcsuite plugin is enabled
Message-ID: <20110616074255.GA21478@dell.ger.corp.intel.com>
References: <1308209699-3819-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1308209699-3819-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Jun 16, 2011, Luiz Augusto von Dentz wrote:
> Commit 4ae4f7c4949c6e53cd4c874c9cc533038cd03fb2 breakes the pcsuite
> plugin by changing the .read API.
> ---
>  plugins/pcsuite.c |    6 +-----
>  1 files changed, 1 insertions(+), 5 deletions(-)

Applied. Thanks.

Johan
