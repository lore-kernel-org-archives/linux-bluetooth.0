Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110615124847.GA12633@dell.ger.corp.intel.com>
References: <1308035981-3623-1-git-send-email-dmitriy.paliy@nokia.com>
	<1308035981-3623-2-git-send-email-dmitriy.paliy@nokia.com>
	<20110615124847.GA12633@dell.ger.corp.intel.com>
Date: Wed, 15 Jun 2011 23:02:33 +0300
Message-ID: <BANLkTik7qQeMSeOCE4jfLt4zrUwdXps_kQ@mail.gmail.com>
Subject: Re: [PATCH] Add capability option to simple-agent
From: Dmitriy Paliy <dmitriy.paliy@gmail.com>
To: Dmitriy Paliy <dmitriy.paliy@nokia.com>,
	linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Wed, Jun 15, 2011 at 3:48 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Applied, thanks. I think you could also fix the mandatory adapter
> argument to be consistent with the rest of the test scripts so that
> "./simple-agent <addr>" is equivalent to "./simple-agent -i hci0 <addr>".
> And please look into this argparser thing to see if we can convert all
> our scripts to use it (one pre-requisite is that it's present in the
> python versions of latest mainstream distro releases).

Thanks, sounds wise. It looks to me that bonding types would be quite
useful in simple-agent. However, how to fit those is not very clear
yet. Any opinions would be appreciated.

BR,
Dmitriy
