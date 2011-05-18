Return-Path: <cyrus@holtmann.org>
Date: Wed, 18 May 2011 13:30:10 -0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Fix incorrect number of expected columns in a
 response to NEW_MISSED_CALLS_LIST
Message-ID: <20110518203010.GB16185@dell.amr.corp.intel.com>
References: <1305710013-31563-1-git-send-email-lkslawek@gmail.com>
 <1305710270-31716-1-git-send-email-lkslawek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1305710270-31716-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Slawek,

On Wed, May 18, 2011, Slawomir Bochenski wrote:
> This fixes error "GLIB CRITICAL ** Tracker -
> tracker_db_cursor_get_value_type: assertion `column < n_columns' failed"
> occurring when pulling phone book or doing listing for missed calls. The
> number of expected columns in reply to NEW_MISSED_CALLS_LIST query was
> incorrectly set to PULL_QUERY_COL_AMOUNT (23) but the query actually
> returns 3 columns.
> ---
> Just a little modification of a commit message.
> 
>  plugins/phonebook-tracker.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)

Applied, but I had to first edit your commit message summary line to be
considerably shorter.

Johan
