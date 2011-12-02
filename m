Return-Path: <cyrus@holtmann.org>
Date: Fri, 2 Dec 2011 13:26:49 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Santiago Carot-Nemesio <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/6] Confiure C.C.C descriptor during the thermometer
 configuration
Message-ID: <20111202112649.GB17203@x220.ger.corp.intel.com>
References: <1321973388-16300-1-git-send-email-sancane@gmail.com>
 <1321973388-16300-2-git-send-email-sancane@gmail.com>
 <1321973388-16300-3-git-send-email-sancane@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1321973388-16300-3-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santiago,

On Tue, Nov 22, 2011, Santiago Carot-Nemesio wrote:
> +			atval[0] = 0x02;
> +			atval[1] = 0x00;

What are these magic values? Could we have some defines for them or
something else more readable?

Johan
