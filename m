Return-Path: <cyrus@holtmann.org>
Date: Tue, 17 Jan 2012 21:35:09 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/3] Fix wrong offset in EIR name parsing
Message-ID: <20120117193509.GA29544@x220.P-661HNU-F1>
References: <1326817082-6787-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1326817082-6787-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Tue, Jan 17, 2012, Anderson Lizardo wrote:
> When looking for NUL byte terminators on EIR names, the first two bytes
> of the EIR field should be skipped, which correspond to field length and
> EIR type.
> ---
>  src/eir.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)

Actually I already noticed the issues in the first two patches and have
fixes in my local tree which I'll push in minute. I also ended up adding
a data pointer (to &eir_data[2]) and a generic data_len (field_len - 1)
to make the code more readable. Once I've pushed those I'll apply your
patch 3/3.

Johan
