Return-Path: <cyrus@holtmann.org>
Date: Tue, 27 Mar 2012 14:31:39 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: james.steele@accenture.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Adding SSP debug mode configuration to hciconfig.
Message-ID: <20120327113139.GE14481@x220>
References: <81C9FA9C1C2E9E45A9AC3EDD1858BC4323E01AC4@048-CH1MPN1-101.048d.mgd.msft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <81C9FA9C1C2E9E45A9AC3EDD1858BC4323E01AC4@048-CH1MPN1-101.048d.mgd.msft.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi James,

On Mon, Mar 19, 2012, james.steele@accenture.com wrote:
> --- a/lib/hci.h
> +++ b/lib/hci.h
> @@ -1428,7 +1428,7 @@ typedef struct {
>  #define WRITE_REMOTE_AMP_ASSOC_RP_SIZE 2
> 
>  /* Testing commands */
> -#define OGF_TESTING_CMD                0x3e
> +#define OGF_TESTING_CMD                0x06
> 
>  #define OCF_READ_LOOPBACK_MODE                 0x0001
> 

I see you've got the change I mentioned in my previous mail here but
this really should be a separate patch since we try to keep shared lib/*
changes for bluez and hcidump in sync on the commit-level.

Johan
