Return-Path: <cyrus@holtmann.org>
Date: Wed, 18 Apr 2012 12:12:09 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Daniel Wagner <wagi@monom.org>
Cc: linux-bluetooth@vger.kernel.org,
	Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: Re: [PATCH] Makefile: Always add all test scripts to EXTRA_DIST
Message-ID: <20120418091209.GA27050@x220.ger.corp.intel.com>
References: <1334739217-17509-1-git-send-email-wagi@monom.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1334739217-17509-1-git-send-email-wagi@monom.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniel,

On Wed, Apr 18, 2012, Daniel Wagner wrote:
> With commit e407e9ac6d8bfde31f95ed5d7e7bcecf0cfe48ed
> test-attrib, test-proximity and test-thermometer are only packaged
> when "./configure --enable-gatt && make dist" is called.
> 
> The dist target should be independant on the configure flags.
> ---
>  Makefile.tools |    5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Applied. Thanks.

Johan
