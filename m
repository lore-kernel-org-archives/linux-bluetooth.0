Return-Path: <cyrus@holtmann.org>
Date: Fri, 16 Oct 2015 08:20:24 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: properly initialize conn_params in scan
 phase
Message-ID: <20151016052024.GA28796@t440s.P-661HNU-F1>
References: <1444947529-11824-1-git-send-email-jpawlowski@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1444947529-11824-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Thu, Oct 15, 2015, Jakub Pawlowski wrote:
> This patch makes sure that conn_params that were created just for
> explicit_connect, will get properly deleted during cleanup.
> 
> Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
> ---
>  net/bluetooth/hci_conn.c | 22 +++++++++++++++-------
>  net/bluetooth/mgmt.c     |  6 +++++-
>  2 files changed, 20 insertions(+), 8 deletions(-)

This one looks good to me, except:

> -	params = hci_conn_params_add(hdev, addr, addr_type);
> -	if (!params)
> -		return -EIO;
> +	params = hci_conn_params_lookup(hdev, addr, addr_type);
> +	if (!params) {
> +		params = hci_conn_params_add(hdev, addr, addr_type);
> +		if (!params)
> +			return -EIO;

I know it's in the original code, but since you're changing these lines
it might make sense to fix the error code to be something reasonable.
The only case hci_conn_params_add() will fail is memory allocation
failure, so EIO is kind of weird. ENOMEM would be more appropriate.

Johan
