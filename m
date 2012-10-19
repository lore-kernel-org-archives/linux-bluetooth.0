Return-Path: <cyrus@holtmann.org>
Date: Fri, 19 Oct 2012 10:40:22 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org,
	Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: Re: [RFC 0/6] DBus.Properties: Converting SAP, HEALTH and fix to
 input
Message-ID: <20121019074022.GB2243@x220>
References: <1350597831-28380-1-git-send-email-lucas.demarchi@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1350597831-28380-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Thu, Oct 18, 2012, Lucas De Marchi wrote:
> Here is a patch set to convert SAP and HEALTH profiles to
> DBus.Properties. It's only compile-tested.
> 
> Patch 0002 contains a fix to sap server. Unless I'm blind,
> GetProperties() callback was doing random things using that pointer.
> 
> Patch 0001 adds the missing update to PropertiesChanged signal in
> INPUT profile.
> 
> Finally last patch convert HEALTH's documentation to a format similar
> to what we have in other profiles.
> 
> Lucas De Marchi (6):
>   input: Fix not sending PropertiesChanged signal
>   sap: Fix usage of wrong struct in get_properties()
>   sap: Convert to DBus.Properties
>   health: Convert HealthChannel to DBus.Properties
>   health: Convert HealthDevice to DBus.Properties
>   doc: Update Health to BlueZ 5
> 
>  doc/health-api.txt      | 198 ++++++++++++++++++++++++------------------------
>  doc/sap-api.txt         |  12 ---
>  profiles/health/hdp.c   | 124 +++++++++++++++---------------
>  profiles/input/device.c |  13 +---
>  profiles/sap/server.c   |  61 +++++----------
>  5 files changed, 184 insertions(+), 224 deletions(-)

I didn't see any major issues so I went ahead and pushed this set. I
didn't see any updates to the test scripts though. Is it so that they
don't use the old properties interfaces?

Johan
