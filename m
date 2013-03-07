Return-Path: <cyrus@holtmann.org>
Date: Thu, 7 Mar 2013 15:54:08 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/3 v2] audio: Remove profile enabling/disabling
 logic
Message-ID: <20130307135408.GA19756@x220>
References: <1362649284-24335-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1362649284-24335-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Mar 07, 2013, Luiz Augusto von Dentz wrote:
> This should be handle by the core for all profiles
> ---
> v2: Match only local_uuid to avoid end up disabling both roles whenever one
> role is disabled.

The first two patches of this set have been applied while I think 3/3
needs a bit more discussion.

Johan
