Return-Path: <cyrus@holtmann.org>
Date: Thu, 24 Mar 2011 11:24:52 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Dieb Martins <andre.dieb@signove.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/5] Inline ATT dump functions
Message-ID: <20110324092452.GE30621@jh-x301>
References: <1300891601-11412-1-git-send-email-andre.dieb@signove.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1300891601-11412-1-git-send-email-andre.dieb@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi André,

On Wed, Mar 23, 2011, Andre Dieb Martins wrote:
> ---
>  parser/att.c |   32 ++++++++++++++++----------------
>  1 files changed, 16 insertions(+), 16 deletions(-)

Do you have some measurements that show that inlining actually has a
noticable effect? You're also missing the justification for this change
in the commit message.

Johan
