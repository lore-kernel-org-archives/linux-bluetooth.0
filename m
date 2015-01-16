Return-Path: <cyrus@holtmann.org>
Date: Fri, 16 Jan 2015 13:08:47 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] bluetooth: Remove unused function
Message-ID: <20150116110847.GA4102@t440s.lan>
References: <1420386914-12885-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1420386914-12885-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rickard,

On Sun, Jan 04, 2015, Rickard Strandqvist wrote:
> Remove the function hci_conn_change_link_key() that is not used anywhere.
> 
> This was partially found by using a static code analysis program
> called cppcheck.
> 
> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
> ---
>  include/net/bluetooth/hci_core.h |    1 -
>  net/bluetooth/hci_conn.c         |   15 ---------------
>  2 files changed, 16 deletions(-)

Applied to the bluetooth-next tree. Thanks.

Johan
