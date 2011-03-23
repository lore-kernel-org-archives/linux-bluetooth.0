Return-Path: <cyrus@holtmann.org>
Date: Wed, 23 Mar 2011 15:09:18 +0200
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3] Add release all sessions when adapter is switched
 off
Message-ID: <20110323130918.GB7124@jh-x301>
References: <1300796947-1518-1-git-send-email-dmitriy.paliy@nokia.com>
 <1300796947-1518-2-git-send-email-dmitriy.paliy@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1300796947-1518-2-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitriy,

On Tue, Mar 22, 2011, Dmitriy Paliy wrote:
> All sessions should be released when adapter is switched off. Then a new
> RequestSession method call always results in change from power off to power
> on such ensuring operational mode. Otherwise, it is possible to end up in
> adapter state being powered off after RequestSession succeded.
> 
> g_slist_free is not called after g_slist_foreach because the list is updated
> using g_slist_remove inside of session_free, which is called for each element
> by g_slist_foreach.
> ---
>  src/adapter.c |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)

Pushed upstream. Thanks.

Johan
