Return-Path: <cyrus@holtmann.org>
Date: Fri, 1 Feb 2013 09:57:37 -0600
From: Johan Hedberg <johan.hedberg@gmail.com>
To: patrik.flykt@linux.intel.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] network: Fix user data handling on unregister
Message-ID: <20130201155737.GA22624@x220>
References: <1359717591-32532-1-git-send-email-patrik.flykt@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1359717591-32532-1-git-send-email-patrik.flykt@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Patrik,

On Fri, Feb 01, 2013, patrik.flykt@linux.intel.com wrote:
> User data in unregister_server() is a network_adapter struct. Unregistering
> using full UUID will now also work.
> ---
>  profiles/network/server.c |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Applied. Thanks.

Johan
