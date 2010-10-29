Return-Path: <cyrus@holtmann.org>
Date: Fri, 29 Oct 2010 10:40:33 -0400
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lukasz Pawlik <lucas.pawlik@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2] Fix handling nco affiliation fields
Message-ID: <20101029144033.GA3815@jh-x301>
References: <1288361066-21203-1-git-send-email-lucas.pawlik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1288361066-21203-1-git-send-email-lucas.pawlik@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Fri, Oct 29, 2010, Lukasz Pawlik wrote:
> Previously when contact record was divided into separate replies,
> phonebook-tracker would use first reply and merge only phone numbers,
> addresses and emails from next. Now it's merging all fields dependent on the
> nco:hasAffiliation as well.
> ---
>  plugins/phonebook-tracker.c |   16 ++++++++++++++++
>  1 files changed, 16 insertions(+), 0 deletions(-)

Pushed upstream with a couple of minor tweaks.

Johan
