Return-Path: <cyrus@holtmann.org>
Date: Mon, 30 Jul 2012 13:55:06 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Eder Ruiz Maria <eder.ruiz@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/3] att: Add prepare write support
Message-ID: <20120730105506.GA13548@x220.ger.corp.intel.com>
References: <1343420976-19921-1-git-send-email-eder.ruiz@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1343420976-19921-1-git-send-email-eder.ruiz@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Eder,

On Fri, Jul 27, 2012, Eder Ruiz Maria wrote:
> Add functions for encoding/decoding Prepare Write Request and
> Response PDUs.
> ---
>  attrib/att.c |   55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  attrib/att.h |    5 +++++
>  2 files changed, 60 insertions(+)

This doesn't apply:

Applying: att: Add prepare write support
/home/jh/src/bluez/.git/rebase-apply/patch:68: new blank line at EOF.
+
fatal: 1 line adds whitespace errors.
Patch failed at 0001 att: Add prepare write support

Please fix (including other potentially similar issues in the other patches)
and resend. Thanks.

Johan
