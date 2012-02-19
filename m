Return-Path: <cyrus@holtmann.org>
Date: Sun, 19 Feb 2012 12:51:26 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC v2 0/4] MGMT Start Discovery interleaved support
Message-ID: <20120219105126.GA27110@x220.P-661HNU-F1>
References: <1329521978-8537-1-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1329521978-8537-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Fri, Feb 17, 2012, Andre Guedes wrote:
> This RFCv2 series implements Marcel's and Johan's comments from previous
> version. The changes are:
> 1. Use MGMT_ADDR_* macros instead of hard-coded values to define discovery
> type macros;
> 2. Fix locking in mgmt_interleaved_discovery
> 
> Marcel, I removed your ack from patch 1/4 because I changed it a little
> bit. MGMT_ADDR_* macros were moved to hci_core.h since they are needed to
> define discovery type macros.

All four patches have been applied to my bluetooth-next tree. Thanks.

I'd still like to have consistency in the locking since now your
function is the only one handling the hdev lock by itself and that's
something that can easily cause bugs in the long run. I.e. probably all
mgmt_* functions should be converted to take hdev unlocked and handle
the locking by themselves.

Johan
