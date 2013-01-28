Return-Path: <cyrus@holtmann.org>
Date: Mon, 28 Jan 2013 12:23:32 -0600
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Damjan Cvetko <Damjan.Cvetko@monotek.net>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: LE auto connect
Message-ID: <20130128182332.GA23272@x220.ger.corp.intel.com>
References: <CEE0DF8E7B2727428D202DA3F3FBC4DD8C753ABB@PULWAR.mtk.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CEE0DF8E7B2727428D202DA3F3FBC4DD8C753ABB@PULWAR.mtk.lan>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Damjan,

On Mon, Jan 28, 2013, Damjan Cvetko wrote:
> I checked out latest code, and found that LE auto connection does not
> work at all. Dug a bit in the code to see there is no relevant
> implementation (related to connect_list).
>
> Here a few lines that make it work.

Thanks. I pushed a cleaned up version of the adapter.c changes since
that needs to be in a separate patch anyway. Could you create a proper
git patch (git format-patch & git send-email) from the first part of the
patch and resend it?

Johan
