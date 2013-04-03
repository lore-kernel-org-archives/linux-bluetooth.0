Return-Path: <cyrus@holtmann.org>
Date: Wed, 3 Apr 2013 10:56:01 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Alvaro Silva <alvaro.silva@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] tools: Add tests for start discovery
Message-ID: <20130403075601.GA3651@x220>
References: <1364945700-17156-1-git-send-email-alvaro.silva@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1364945700-17156-1-git-send-email-alvaro.silva@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alvaro,

On Tue, Apr 02, 2013, Alvaro Silva wrote:
> Add HCI command test and discovering event test for start discovery.
> ---
>  tools/mgmt-tester.c |    8 ++++++++
>  1 file changed, 8 insertions(+)

Both patches in this set have been applied, however I tweaked the commit
messages to be less misleading since you're not really adding new test
cases but just refining existing ones.

Johan
