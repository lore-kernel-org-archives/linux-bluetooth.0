Return-Path: <cyrus@holtmann.org>
Date: Wed, 3 Aug 2011 12:35:04 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org,
	Sheldon Demario <sheldon.demario@openbossa.org>
Subject: Re: [PATCH BlueZ] Test script for LinkLossAlertLevel property
Message-ID: <20110803093504.GA21750@dell>
References: <1311961657-28925-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1311961657-28925-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Jul 29, 2011, Claudio Takahasi wrote:
> Initial test script for Proximity Monitor. This patch allows the
> user to set the Link Loss alert level of a given Reporter.
> Usage example:
> $test-proximity.py -i hci1 --device <mac> LinkLossAlertLevel mild
> ---
>  test/test-proximity.py |   65 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 65 insertions(+), 0 deletions(-)
>  create mode 100755 test/test-proximity.py

Please get rid of the .py suffix to be consistent with the other
scripts.

Johan
