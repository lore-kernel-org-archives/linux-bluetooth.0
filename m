Return-Path: <cyrus@holtmann.org>
Date: Fri, 5 Aug 2011 15:27:15 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bartosz Szatkowski <bulislaw@linux.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd] Fix handling vCard type "OTHER" emails in PBAP
Message-ID: <20110805122715.GA32410@dell>
References: <1312542090-11434-1-git-send-email-bulislaw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1312542090-11434-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bartosz,

On Fri, Aug 05, 2011, Bartosz Szatkowski wrote:
> Until now contacts with emails, without type specified, were not included
> in vCards. Also default type for vCard 3.0 is set to "OTHER" - not
> empty field as it is in vCard 2.1.
> ---
>  plugins/phonebook-tracker.c |    6 +++---
>  plugins/vcard.c             |    2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)

Pushed upstream. Thanks.

Johan
