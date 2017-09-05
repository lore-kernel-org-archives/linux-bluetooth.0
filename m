Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1504602205.5928.5.camel@hadess.net>
Subject: Re: [PATCH 4/9] plugins/sixaxis: Move device discovery to shared
 header
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Date: Tue, 05 Sep 2017 11:03:25 +0200
In-Reply-To: <20170904181212.5639-4-hadess@hadess.net>
References: <20170904181212.5639-1-hadess@hadess.net>
         <20170904181212.5639-4-hadess@hadess.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 2017-09-04 at 20:12 +0200, Bastien Nocera wrote:
> <snip>
> +
> +inline CablePairingType
> +get_pairing_type(uint16_t   vid,
> +		 uint16_t   pid,
> +		 char     **name,
> +		 uint16_t  *source,
> +		 uint16_t  *version)

I have a slightly updated version of that section. "static" is missing
in front of the inline function for use with RPM build's strict linker
settings, and I'm sure the indentation police would like to see that
function return type and name on the same line ;)
