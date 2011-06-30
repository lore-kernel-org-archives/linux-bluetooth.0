Return-Path: <cyrus@holtmann.org>
Date: Thu, 30 Jun 2011 22:55:11 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 0/3] Fixes for AVRCP 1.0 and preparation for AVRCP 1.3
Message-ID: <20110630195511.GA18253@dell.ger.corp.intel.com>
References: <1309459835-11434-1-git-send-email-lucas.demarchi@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1309459835-11434-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Thu, Jun 30, 2011, Lucas De Marchi wrote:
> These are simple fixes for AVRCP 1.0 and a preparation for the upcoming 1.3.
> I'm working on the task of implementing AVRCP 1.3 now, based when possible on
> previous patches sent to this list.
> 
> Lucas De Marchi (3):
>   avrcp: Check that AVCTP packet is of type COMMAND
>   avrcp: Factor out function to handle vendordep pdu
>   avrcp: return NOT_IMPLEMENTED on request for vendor dep command
> 
>  audio/control.c |   31 +++++++++++++++----------------
>  1 files changed, 15 insertions(+), 16 deletions(-)

All three patches have been applied. Thanks.

Johan
