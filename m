Return-Path: <cyrus@holtmann.org>
Date: Wed, 11 Dec 2013 15:33:00 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 00/10] Refactoring bnep code to reduce redundancy
Message-ID: <20131211133300.GA7138@x220.p-661hnu-f1>
References: <1386756825-934-1-git-send-email-ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1386756825-934-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Wed, Dec 11, 2013, Ravi kumar Veeramally wrote:
>   bnep: Rename bnep_kill_connection to bnep_conndel
>   bnep: Rename send ctrl_rsp and make it global
>   bnep: Move bnep related calls to bnep.h|c
>   profiles/network/server: Delete function which does nothing
>   android/pan: Fix missing cleanup calls
>   android/pan: Fix minor white space

The above patches have been applied. As we discussed offline, the others
were either dropped or need some extra work

Johan
