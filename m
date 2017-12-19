Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Tue, 19 Dec 2017 17:52:16 +0100
From: Johan Hedberg <johan.hedberg@intel.com>
To: Inga Stotland <inga.stotland@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] mesh:meshctl: make model parsing more manageable
Message-ID: <20171219165216.GA31289@x1c>
References: <20171218203551.6142-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171218203551.6142-1-inga.stotland@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Inga,

On Mon, Dec 18, 2017, Inga Stotland wrote:
> Extract functionality for finding an existing model from
> parse_configuration_models() into new function find_configured_model().
> This removes confusing logic from overloaded implementation of
> parse_configuration_models().
> ---
>  mesh/prov-db.c | 54 ++++++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 42 insertions(+), 12 deletions(-)

Applied. Thanks.

Johan
