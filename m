Return-Path: <cyrus@holtmann.org>
Date: Tue, 27 Jul 2010 15:31:29 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: "Counihan, Tom" <tom.counihan@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] De-register pbap drivers on init failure scenarios
Message-ID: <20100727123129.GA6483@jh-x301>
References: <B09AD526409DF14F8DA79CC5429052C299EE0FC7@irsmsx505.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <B09AD526409DF14F8DA79CC5429052C299EE0FC7@irsmsx505.ger.corp.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tom,

On Tue, Jul 27, 2010, Counihan, Tom wrote:
> Unwind the driver registration/phonebook initialization stack on pbap plugin init failure scenarios.
> 
> 
> ---
>  plugins/pbap.c |   25 ++++++++++++++++++++-----
>  1 files changed, 20 insertions(+), 5 deletions(-)

Thanks for the patch! It's now upstream. In the future please pay
attention to your commit message line length. It shouldn't exceed 74
characters (or so) in order to be nicely viewable on a 80-character wide
terminal using git log. I fixed it this time for you manually.

Johan
