Return-Path: <cyrus@holtmann.org>
Date: Thu, 15 Dec 2011 13:29:10 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Santiago Carot-Nemesio <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Health Thermometer Profile patches
Message-ID: <20111215112910.GB3396@x220>
References: <1323454744-14589-1-git-send-email-sancane@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1323454744-14589-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santiago,

On Fri, Dec 09, 2011, Santiago Carot-Nemesio wrote:
> This is a new set of patches wich implement most of the features in
> HTP. GATT reconnections are the only missing feature up to now.
> 
> These patches depend on the patch:
> att.h: Add client characteristic configuration bit fields
> 
> Changes include next patches:
> [PATCH 1/6] thermometer.c: Implement SetProperty D-Bus method
> [PATCH 2/6] thermometer.c: Confiure C.C.C descriptor during the
> [PATCH 3/6] thermometer.c: Process measurement interval indications
> [PATCH 4/6] thermometer.c: Fix possible null pointer deference
> [PATCH 5/6] thermometer.c: Fix bad read operation when time stamp isn't provided
> [PATCH 6/6] thermometer.c: Use system types instead of GLIB ones.

All patches have been applied. I'd prefer if you use the prefix
"thermometer" instead of "thermometer.c" in the future (I fixed it
manually this time). Also pay attention to your commit message line
lengths. git log indents the message by 4 characters and git shortlog by
6, so to be on the safe side on 80 character wide terminals keep the
lines less than 74 characters (e.g. patch 2/6 had a too long summary
line).

Johan
