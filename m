Return-Path: <cyrus@holtmann.org>
Date: Thu, 5 Mar 2015 09:51:18 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v5 1/3] Bluetooth: Move Service Discovery logic before
 refactoring
Message-ID: <20150305075118.GA17762@t440s.lan>
References: <1425515066-28323-1-git-send-email-jpawlowski@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1425515066-28323-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Wed, Mar 04, 2015, Jakub Pawlowski wrote:
> This patch moves whole packet filering logic of service discovery
> into new function is_filter_match. It's done because logic inside
> mgmt_device_found is very complicated and needs some
> simplification.
> 
> Also having whole logic in one place will allow to simplify it in
> the future.
> 
> Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
> ---
>  net/bluetooth/mgmt.c | 141 +++++++++++++++++++++++++++++----------------------
>  1 file changed, 79 insertions(+), 62 deletions(-)

All three patches in this set have now been applied. Thanks.

Johan
