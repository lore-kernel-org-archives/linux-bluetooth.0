Return-Path: <cyrus@holtmann.org>
Date: Thu, 18 Nov 2010 14:22:06 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bartosz Szatkowski <bulislaw@linux.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 2/2] Split pull_contacts to smaller functions
Message-ID: <20101118122206.GA3914@jh-x301>
References: <1290078266-16279-1-git-send-email-bulislaw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1290078266-16279-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bartosz,

On Thu, Nov 18, 2010, Bartosz Szatkowski wrote:
> Parts of pull_contact responsible for filling contact fields moved
> to new functions.
> ---
>  plugins/phonebook-tracker.c |  176 ++++++++++++++++++++++++++----------------
>  1 files changed, 109 insertions(+), 67 deletions(-)

Thanks. The patch looks now fine and has been pushed upstream.

Johan
