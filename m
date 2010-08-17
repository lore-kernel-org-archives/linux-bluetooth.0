Return-Path: <cyrus@holtmann.org>
Date: Tue, 17 Aug 2010 17:41:32 +0300
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/5] Add fast connectable to hciops
Message-ID: <20100817144132.GA22079@jh-x301>
References: <1282053934-19445-1-git-send-email-dmitriy.paliy@nokia.com>
 <1282053934-19445-3-git-send-email-dmitriy.paliy@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1282053934-19445-3-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitry,

On Tue, Aug 17, 2010, Dmitriy Paliy wrote:
> +	if ( hci_send_cmd(dd, OGF_HOST_CTL, OCF_WRITE_PAGE_ACTIVITY,
> +				WRITE_PAGE_ACTIVITY_CP_SIZE, &cp) < 0 ) {
> +		err = -errno;
> +	} else if ( hci_send_cmd(dd, OGF_HOST_CTL, OCF_WRITE_PAGE_SCAN_TYPE,
> +							1, &type) < 0 ) {
> +		err = -errno;
> +	}

A few coding style issues: no braces for one-line if-statements and
remove the spaces after ( and before ) should be removed.

Johan
