Return-Path: <cyrus@holtmann.org>
Date: Fri, 5 Aug 2011 12:29:00 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd v2 2/2] Fix several issues in FTP action support
Message-ID: <20110805092900.GB19836@dell>
References: <1312465504-26373-2-git-send-email-lkslawek@gmail.com>
 <1312526431-5192-1-git-send-email-lkslawek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1312526431-5192-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Slawek,

On Fri, Aug 05, 2011, Slawomir Bochenski wrote:
> Fixed issues:
> - Incorrect handling of absolute path in DestName header
> - Possibility of exploiting DestName header to escape FTP plugin root
> - Incorrect checking of whether path resides inside FTP root (not
>   allowing to move or copy files up)
> - Ignoring symbolic links and options regarding them
> ---
> v2: fixed incorrect path verification for DestName
> 
>  plugins/ftp.c |   57 +++++++++++++++++++++++++++++++++++++++++++++++++++++----
>  1 files changed, 53 insertions(+), 4 deletions(-)

After some coding style fixes both patches have now been pushed
upstream. Thanks.

Johan
