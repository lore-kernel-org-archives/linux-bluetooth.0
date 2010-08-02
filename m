Return-Path: <cyrus@holtmann.org>
Date: Tue, 3 Aug 2010 01:50:44 +0300
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Radoslaw Jablonski <ext-jablonski.radoslaw@Nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Add NULL checking for name param
Message-ID: <20100802225044.GA2284@jh-x301>
References: <1280759046-11571-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1280759046-11571-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Radek,

On Mon, Aug 02, 2010, Radoslaw Jablonski wrote:
> Added NULL checking for "name" param in pbap_open_* functions. If on
> this level this variable will be NULL, then setting -EBADR error code
> and ending function. This fixes many obexd crashes.
> ---
>  plugins/pbap.c |   13 +++++++++++--
>  1 files changed, 11 insertions(+), 2 deletions(-)

The patch is now upstream. Thanks.

Johan
