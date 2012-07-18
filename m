Return-Path: <cyrus@holtmann.org>
Date: Wed, 18 Jul 2012 15:14:37 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd 01/10] client: Change
 MessageAccess.GetFolderListing to not return raw xml
Message-ID: <20120718121437.GA28815@x220.ger.corp.intel.com>
References: <1341340094-32522-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1341340094-32522-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Jul 03, 2012, Luiz Augusto von Dentz wrote:
> This parses the response and return as a list of dictionary where each
> entry is a folder and its properties, similar to what
> FileTransfer.ListFolder does.
> ---
>  client/map.c |   88 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 86 insertions(+), 2 deletions(-)

This set has been pushed upstream. Thanks.

Johan
