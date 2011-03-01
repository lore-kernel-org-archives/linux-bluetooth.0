Return-Path: <cyrus@holtmann.org>
Date: Tue, 1 Mar 2011 16:13:40 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lukasz Pawlik <lucas.pawlik@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix pulling phonebook entries without last name
Message-ID: <20110301191340.GB10738@jh-x301>
References: <1298906383-14521-1-git-send-email-lucas.pawlik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1298906383-14521-1-git-send-email-lucas.pawlik@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Mon, Feb 28, 2011, Lukasz Pawlik wrote:
> This patch fix problem with pulling phonebook entries using PBAP without
> last name filled. Previously last name was used to sort phonebook data
> now only tracker id is used.
> ---
>  plugins/phonebook-tracker.c |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)

Pushed upstream. Thanks.

Johan
