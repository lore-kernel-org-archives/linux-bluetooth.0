Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH 1/1] mesh: Fixed warning-to-error from GCC 8.1.1
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180823191324.12712-1-brian.gix@intel.com>
Date: Thu, 23 Aug 2018 21:57:45 +0200
Cc: linux-bluetooth@vger.kernel.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        inga.stotland@intel.com, Johan Hedberg <johan.hedberg@intel.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Message-Id: <9C902AA8-FEF4-4819-AC35-42B3EC5835EF@holtmann.org>
References: <20180823191324.12712-1-brian.gix@intel.com>
To: Brian Gix <brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

> Fixed compiler flagged unsafe usage of strncpy
> ---
> mesh/storage.c | 14 ++++++++------
> 1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/mesh/storage.c b/mesh/storage.c
> index 85fa81dda..1be403297 100644
> --- a/mesh/storage.c
> +++ b/mesh/storage.c
> @@ -298,13 +298,14 @@ bool storage_parse_config(struct mesh_net *net, const char *config_name)
> 	result = parse_config(net, config_name, false);
> 
> 	if (!result) {
> -		char *bak = (char *) l_malloc(strlen(config_name) + 5);
> +		size_t len = strlen(config_name) + 5;
> +		char *bak = (char *) l_malloc(len);

The (char *) cast is utterly pointless since l_malloc return void *.

> 
> 		if (!bak)
> 			goto done;

So why are we still doing? l_malloc will abort if no memory can be allocated. We need to stop dealing with memory allocation error handling. If you need that large memory then malloc should be used. If you use l_malloc then expect the daemon might be killed. Which is fine systemd can restart it.

Regards

Marcel
