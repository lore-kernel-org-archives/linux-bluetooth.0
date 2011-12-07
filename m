Return-Path: <cyrus@holtmann.org>
Date: Wed, 7 Dec 2011 17:19:18 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: jaganath.k@samsung.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd] Fix file size issue in GetProperties
Message-ID: <20111207151918.GA20818@x220>
References: <1322827022-27391-1-git-send-email-jaganath.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1322827022-27391-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

On Fri, Dec 02, 2011, jaganath.k@samsung.com wrote:
> In SendFiles, If application calls GetProperties before
> Request method returns then the file size is zero.
> ---
>  client/session.c  |    4 ++++
>  client/transfer.c |   40 ++++++++++++++++++++++++----------------
>  client/transfer.h |    1 +
>  3 files changed, 29 insertions(+), 16 deletions(-)

The patch has been applied but it generated the following warnings:

Applying: Fix file size issue in GetProperties
/home/jh/src/obexd/.git/rebase-apply/patch:83: new blank line at EOF.
+
warning: 1 line adds whitespace errors.

Please be careful with such issues in the future (and test applying the
patch yourself before applying).

Johan
