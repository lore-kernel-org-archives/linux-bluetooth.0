Return-Path: <cyrus@holtmann.org>
Message-ID: <4CC6DDA8.6080900@nokia.com>
Date: Tue, 26 Oct 2010 16:54:48 +0300
From: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
MIME-Version: 1.0
To: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Add separate queries for listing size in PBAP
References: <1288078932-9547-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
In-Reply-To: <1288078932-9547-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

  Hi,
On 10/26/2010 10:42 AM, Radoslaw Jablonski wrote:
> 	"nmo:to ?c ."						\
> +	"}"
> +
> +
> +#define COMBINED_CALLS_COUNT_QUERY					\
> +	"SELECT COUNT(?call) WHERE {"					\
> +	"{"								\
>
Please ignore this patch.
I've noticed after sending that has unneeded 2 empty lines instead of
one between these queries.
I resend new version of this patch - so new version of this is the 
correct one.

BR,
Radek

