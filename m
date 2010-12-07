Return-Path: <cyrus@holtmann.org>
Date: Tue, 7 Dec 2010 23:35:37 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Remove automatic battery state change on attribute
 example
Message-ID: <20101207213537.GA30415@jh-x301>
References: <1291386290-2521-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1291386290-2521-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Fri, Dec 03, 2010, Claudio Takahasi wrote:
> Legacy code implemented to test Indication and Notification
> ---
>  attrib/example.c |   19 -------------------
>  1 files changed, 0 insertions(+), 19 deletions(-)

Sorry, but you'll need to rebase this one since it doesn't apply anymore
cleanly (due to the "Initial attribute permission implementation"
patch).

Johan
