Return-Path: <cyrus@holtmann.org>
Date: Thu, 19 May 2011 16:34:01 -0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 1/2] Fix change to numbers GSlist in new missed calls
Message-ID: <20110519233401.GB4016@dell.ger.corp.intel.com>
References: <1305809864-9963-1-git-send-email-dmitriy.paliy@nokia.com>
 <1305809864-9963-2-git-send-email-dmitriy.paliy@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1305809864-9963-2-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitriy,

On Thu, May 19, 2011, Dmitriy Paliy wrote:
> It is possible that phonebook_pull_read is invoked several times
> submitting multiple pull requests without closing PBAP object. E.g.,
> when history is large enough and maxlistcount>VCARDS_PART_COUNT.
> 
> The result is possibility of different data structures (GString and
> contact_data) to be mixed in a single GSlist that may lead to
> undefined behaviour.
> ---
>  plugins/phonebook-tracker.c |   57 ++++++++++++++++++++++++-------------------
>  1 files changed, 32 insertions(+), 25 deletions(-)

Both patches have been pushed upstream. Could you still explain what
data->numbers is supposed to be useful for? It's not used anywhere in
the code (except where creating and freeing the list).

Johan
