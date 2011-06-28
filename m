Return-Path: <cyrus@holtmann.org>
Date: Tue, 28 Jun 2011 11:01:15 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd] Add copy and move support for filesystem plugin
Message-ID: <20110628080115.GD18047@dell.ger.corp.intel.com>
References: <1308645454-2724-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1308645454-2724-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Jun 21, 2011, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Move is implemented using rename and copy uses sendfile, both part of
> POSIX.
> ---
>  plugins/filesystem.c |   96 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 96 insertions(+), 0 deletions(-)

Applied. Thanks.

Johan
