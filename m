Return-Path: <cyrus@holtmann.org>
Date: Thu, 9 May 2013 10:42:15 +0200 (CEST)
From: Jiri Kosina <jkosina@suse.cz>
To: Chen Gang <gang.chen@asianux.com>,
	Gustavo Padovan <gustavo@padovan.org>
Cc: David Herrmann <dh.herrmann@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	David Miller <davem@davemloft.net>, andrei.emeltchenko@intel.com,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH v2] Bluetooth: hidp: using strlcpy instead of strncpy,
 also beautify code.
In-Reply-To: <5189C7C6.8090408@asianux.com>
Message-ID: <alpine.LNX.2.00.1305091041140.23038@pobox.suse.cz>
References: <518906A8.7060708@asianux.com> <CANq1E4SmY+CD0uf53_b6GeFkQ-LYnpdxsDGSRMWdn2i1mnb6WQ@mail.gmail.com> <5189A417.503@asianux.com> <5189C7C6.8090408@asianux.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 8 May 2013, Chen Gang wrote:

> 
> For NUL terminated string, need always let it ended by zero.
> 
> Since have already called memcpy() to initialize 'ci', so need not
> redundent initializations.
> 
> Better use ''if(session->hid) {} else if(session->input) {}'' instead
> of ''if(session->hid) {}; if(session->input) {};''
> 
> Signed-off-by: Chen Gang <gang.chen@asianux.com>

Makes sense.

Acked-by: Jiri Kosina <jkosina@suse.cz>

Gustavo, going to take this, please?

-- 
Jiri Kosina
SUSE Labs
