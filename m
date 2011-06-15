Return-Path: <cyrus@holtmann.org>
Date: Wed, 15 Jun 2011 15:48:47 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: Re: [PATCH] Add capability option to simple-agent
Message-ID: <20110615124847.GA12633@dell.ger.corp.intel.com>
References: <1308035981-3623-1-git-send-email-dmitriy.paliy@nokia.com>
 <1308035981-3623-2-git-send-email-dmitriy.paliy@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1308035981-3623-2-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitriy,

On Tue, Jun 14, 2011, Dmitriy Paliy wrote:
> A new option is added to simple-agent facilitating use of "DisplayOnly",
> "DisplayYesNo", "KeyboardOnly" and "NoInputNoOutput" agent capabilities.
> ---
>  test/simple-agent |   24 +++++++++++++++++-------
>  1 files changed, 17 insertions(+), 7 deletions(-)

Applied, thanks. I think you could also fix the mandatory adapter
argument to be consistent with the rest of the test scripts so that
"./simple-agent <addr>" is equivalent to "./simple-agent -i hci0 <addr>".
And please look into this argparser thing to see if we can convert all
our scripts to use it (one pre-requisite is that it's present in the
python versions of latest mainstream distro releases).

Johan
