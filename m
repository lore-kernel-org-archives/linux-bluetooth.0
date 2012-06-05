Return-Path: <cyrus@holtmann.org>
Date: Tue, 5 Jun 2012 16:10:45 +0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC hcidump 2/2] Make assoc dump function available for HCI
 parser
Message-ID: <20120605081045.GA9761@x220>
References: <1338819436-15549-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1338819436-15549-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1338819436-15549-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Mon, Jun 04, 2012, Andrei Emeltchenko wrote:
>  Makefile.am    |    3 +-
>  lib/a2mp.h     |   38 -----------------
>  parser/amp.c   |  127 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  parser/l2cap.c |  104 ++--------------------------------------------

As before, any lib/ changes must be in a separate patch so that we can
keep bluez.git and bluez-hcidump.git in sync.

Johan
