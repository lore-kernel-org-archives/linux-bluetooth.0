Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20111207145851.GA19842@x220>
References: <1321973388-16300-1-git-send-email-sancane@gmail.com>
	<1321973388-16300-2-git-send-email-sancane@gmail.com>
	<20111207145851.GA19842@x220>
Date: Fri, 9 Dec 2011 11:02:43 +0100
Message-ID: <CACLukzJS4e3BOzmsC=scGZ93A-gHig6wTdnBpbRuYEecbJ0mOQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] Implement SetProperty D-Bus method
From: Santiago Carot <sancane@gmail.com>
To: Santiago Carot-Nemesio <sancane@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

2011/12/7 Johan Hedberg <johan.hedberg@gmail.com>:
> Hi Santiago,
>
> On Tue, Nov 22, 2011, Santiago Carot-Nemesio wrote:
>> ---
>>  thermometer/thermometer.c |  118 +++++++++++++++++++++++++++++++++++++-------
>>  1 files changed, 99 insertions(+), 19 deletions(-)
>
> Is this patch set still valid? If so, could you resend it with proper
> commit messages. "Implement SetProperty D-Bus method" is much too
> generic. It'd be nice if you could start using the convention we've
> tried to adopt where we add context dependent prefixes to the message
> summaries. In this case "thermometer: Add SetProperty D-Bus method"
> would have already given enough of context to not have to look at the
> patch content to know what it does.
>

Discard this set of patches for now, I'll prepare a new set after
fixing the magic number issue in GATT.
Regards.
