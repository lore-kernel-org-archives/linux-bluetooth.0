Return-Path: <cyrus@holtmann.org>
Date: Wed, 3 Aug 2011 16:08:10 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org,
	Sheldon Demario <sheldon.demario@openbossa.org>
Subject: Re: [PATCH BlueZ v3] Test script for LinkLossAlertLevel property
Message-ID: <20110803130810.GA6332@dell>
References: <CAKT1EBdDvDkmTAyfgcoc1Y-25nwcpvLj=jLa6Y85rKyVi55AFQ@mail.gmail.com>
 <1312375546-19293-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1312375546-19293-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Aug 03, 2011, Claudio Takahasi wrote:
> Initial test script for Proximity Monitor. This patch allows the
> user to set the Link Loss alert level of a given Reporter.
> Usage example:
> $test-proximity -i hci1 --device <mac> LinkLossAlertLevel mild
> ---
>  Makefile.tools      |    7 +++--
>  test/test-proximity |   65 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 69 insertions(+), 3 deletions(-)
>  create mode 100755 test/test-proximity

Applied. Thanks.

Johan
