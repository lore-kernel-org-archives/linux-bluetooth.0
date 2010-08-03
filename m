Return-Path: <cyrus@holtmann.org>
Date: Tue, 3 Aug 2010 11:42:50 +0300
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Add NULL checking for name and path params
Message-ID: <20100803084250.GA12004@jh-x301>
References: <1280823784-14551-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1280823784-14551-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Radek,

On Tue, Aug 03, 2010, Radoslaw Jablonski wrote:
> Added NULL checking for "name" and "path" parameters in pbap_open_*
> functions. If this variables will be NULL, then setting -EBADR error
> code and ending function. This fixes many obexd crashes.
> ---
>  plugins/pbap.c |   15 ++++++++++++++-
>  1 files changed, 14 insertions(+), 1 deletions(-)

Please update your tree against latest upstream. Your patch doesn't
apply anymore (it seems like a new version of the previous one, but that
one got already pushed upstream). Also fix the commit message to explain
what issue in the previous patch this one fixes.

Johan
