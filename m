Return-Path: <cyrus@holtmann.org>
Date: Thu, 14 Apr 2011 20:04:08 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	par-gunnar.p.hjalmdahl@stericsson.com,
	henrik.possung@stericsson.com
Subject: Re: [PATCH v2] Add test/test-oob for testing Out Of Band pairing
Message-ID: <20110414170408.GA7152@jh-x301>
References: <1302255474-15128-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1302255474-15128-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Fri, Apr 08, 2011, Szymon Janc wrote:
> This test utilizes D-Bus Out Of Band API so bluetoothd must be
> compiled with dbusoob plugin.
> ---
>  Makefile.tools |    4 +-
>  test/test-oob  |   80 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 82 insertions(+), 2 deletions(-)
>  create mode 100755 test/test-oob

Pushed upstream. Thanks.

Johan
