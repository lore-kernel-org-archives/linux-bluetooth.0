Return-Path: <cyrus@holtmann.org>
Date: Mon, 27 Oct 2014 06:22:41 +0100
From: Alexander Aring <alex.aring@gmail.com>
To: Martin Townsend <mtownsend1973@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org,
	marcel@holtmann.org, jukka.rissanen@linux.intel.com,
	Martin Townsend <martin.townsend@xsilon.com>
Subject: Re: [PATCH v5 bluetooth-next 0/4] 6lowpan: Move skb delivery out of
 IPHC
Message-ID: <20141027052237.GA21400@omega>
References: <1414075256-9448-1-git-send-email-martin.townsend@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1414075256-9448-1-git-send-email-martin.townsend@xsilon.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Oct 23, 2014 at 03:40:52PM +0100, Martin Townsend wrote:
> This series moves skb delivery out of IPHC and into the receive routines of
> both bluetooth and 802.15.4.  The reason is that we need to support more
> (de)compression schemes in the future.  It also means that calling 
> lowpan_process_data now only returns error codes or 0 for success so 
> this has been cleaned up.  The final patch then renames occurences of
> lowpan_process_data and process_data to something more meaningful.
> 

Acked-by: Alexander Aring <alex.aring@gmail.com>

on the complete serie.

- Alex
