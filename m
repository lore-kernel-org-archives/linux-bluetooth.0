Return-Path: <cyrus@holtmann.org>
Date: Thu, 9 Dec 2010 22:09:27 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Convert CreateDevice on test-device script to an
 asynchronous call
Message-ID: <20101209200927.GA4283@jh-x301>
References: <1291923166-30880-1-git-send-email-claudio.takahasi@openbossa.org>
 <1291923734-30979-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1291923734-30979-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Thu, Dec 09, 2010, Claudio Takahasi wrote:
> Change required to test the scenario when the sender of a CreateDevice
> request disconnects from the system bus. Current implementation is
> blocking and it doesn't allow the user to cancel a request.
> ---
>  test/test-device |   22 +++++++++++++++++++---
>  1 files changed, 19 insertions(+), 3 deletions(-)

Pushed upstream. Thanks.

Johan
