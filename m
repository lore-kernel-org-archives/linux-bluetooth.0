Return-Path: <cyrus@holtmann.org>
Date: Mon, 20 May 2013 18:52:24 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Chen Gang <gang.chen@asianux.com>
Cc: Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	David Miller <davem@davemloft.net>, andrei.emeltchenko@intel.com,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH v3] Bluetooth: hidp: using strlcpy instead of strncpy,
 also beautify code.
Message-ID: <20130520215224.GE17712@joana>
References: <518906A8.7060708@asianux.com>
 <CANq1E4SmY+CD0uf53_b6GeFkQ-LYnpdxsDGSRMWdn2i1mnb6WQ@mail.gmail.com>
 <5189A417.503@asianux.com>
 <5189C7C6.8090408@asianux.com>
 <alpine.LNX.2.00.1305091041140.23038@pobox.suse.cz>
 <51904ACF.6010904@asianux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <51904ACF.6010904@asianux.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen,

* Chen Gang <gang.chen@asianux.com> [2013-05-13 10:07:11 +0800]:

> 
> For NUL terminated string, need always let it ended by zero.
> 
> Since have already called memcpy() to initialize 'ci', so need not
> redundant initialization.
> 
> Better use ''if(session->hid) {} else if(session->input) {}"" instead
> of ''if(session->hid) {}; if(session->input) {};''
> 
> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> ---
>  net/bluetooth/hidp/core.c |   14 ++++----------
>  1 files changed, 4 insertions(+), 10 deletions(-)

Sorry for the big delay on this, patches has now been applied to
bluetooth-next. Thanks all.

	Gustavo
