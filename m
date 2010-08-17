Return-Path: <cyrus@holtmann.org>
Date: Tue, 17 Aug 2010 17:43:10 +0300
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 4/5] Add set fast connectable to audio manager
Message-ID: <20100817144310.GB22079@jh-x301>
References: <1282053934-19445-1-git-send-email-dmitriy.paliy@nokia.com>
 <1282053934-19445-5-git-send-email-dmitriy.paliy@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1282053934-19445-5-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitriy,

On Tue, Aug 17, 2010, Dmitriy Paliy wrote:
> +		if ( btd_adapter_set_fast_connectable(adapter->btd_adapter,
> +								enable) )
> +			error("Changing fast connectable for hci%d failed",
> +				adapter_get_dev_id(adapter->btd_adapter) );
> +	}

Same coding style issues I already mentioned for the other patch: no
braces for one-line if-statements and no space after ( or before ).

Johan
