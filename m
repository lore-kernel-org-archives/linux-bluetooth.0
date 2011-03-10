Return-Path: <cyrus@holtmann.org>
Date: Thu, 10 Mar 2011 10:52:20 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	par-gunnar.p.hjalmdahl@stericsson.com,
	henrik.possung@stericsson.com
Subject: Re: [PATCH v2] pand: Fix for TP_BNEP_CTRL_BV_01_C qualification
 test
Message-ID: <20110310085220.GA2883@jh-x301>
References: <1299264115-10702-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1299264115-10702-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Fri, Mar 04, 2011, Lukasz Rymanowski wrote:
> With this fix pand will correctly respond on
> unknown BNEP control command
> ---
>  compat/bnep.c |   16 ++++++++++++++++
>  1 files changed, 16 insertions(+), 0 deletions(-)

Pushed upstream. Could you also create a matching patch for the network
plugin, please? (network/server.c bnep_setup function).

Johan
