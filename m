Return-Path: <cyrus@holtmann.org>
Date: Fri, 25 Feb 2011 12:47:28 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	par-gunnar.p.hjalmdahl@stericsson.com,
	henrik.possung@stericsson.com
Subject: Re: [PATCH v2 2/3] Bluetooth: Move index to common header in
 management interface
Message-ID: <20110225154728.GB19437@jh-x301>
References: <1298476240-18124-1-git-send-email-szymon.janc@tieto.com>
 <1298476240-18124-2-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1298476240-18124-2-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Feb 23, 2011, Szymon Janc wrote:
> Most mgmt commands and event are related to hci adapter. Moving index to
> common header allow to easily use it in command status while reporting errors.
> For those not related to adapter use MGMT_INDEX_NONE (0xFFFF) as index.
> 
> Signed-off-by: Szymon Janc <szymon.janc@tieto.com>

Acked-by: Johan Hedberg <johan.hedberg@nokia.com>

Johan
