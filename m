Return-Path: <cyrus@holtmann.org>
Date: Thu, 4 Oct 2012 17:17:22 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org,
	Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: Re: [PATCH BlueZ v4 00/15] Properties + ObjectManager
Message-ID: <20121004141722.GA4173@x220>
References: <1349335599-12443-1-git-send-email-lucas.de.marchi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1349335599-12443-1-git-send-email-lucas.de.marchi@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Thu, Oct 04, 2012, Lucas De Marchi wrote:
> Here is a rebased version of the patches. Most notable change is on patch
> implementing the Set() method after feedback from Marcel. It doesn't cover the
> concerns from Luiz about checking privileges per-property since I think this
> could be added in a separate patch. As far as I could see the only user is
> MediaTransport interface. The most obvious way would be to add another hook in
> GDBusPropertyTable in order to check the privileges. Suggestions?
> 
> First 2 patches could be applied nonetheles. Get and GetAll are well tested,
> both now and in the previous version of this patch set. Set() is still a
> bit raw - the users implementing it are very big (adapter, device) so
> they are not converted yet (previous patch doesn't apply anymore and there's a
> change in the API that requires them to be rewritten).
> 
> 
> Lucas De Marchi (10):
>   gdbus: Move typedefs up
>   gdbus: Use macros to add annotations
>   gdbus: Add skeleton of DBus.Properties interface
>   gdbus: Implement DBus.Properties.Get method
>   gdbus: Implement DBus.Properties.GetAll method
>   gdbus: Implement DBus.Properties.Set method
>   gdbus: Add properties into Introspectable interface
>   gdbus: Implement PropertiesChanged signal
>   Use DBus.Properties on Control interface
>   Use DBus.Properties on Manager interface
> 
> Luiz Augusto von Dentz (5):
>   gdbus: Add support for org.freedesktop.DBus.ObjectManager interface
>   gdbus: Group interface changes to reduce the amount of signals
>     emitted
>   gdbus: Only export ObjectManager interface on root path
>   gdbus: Integrates ObjectManager with Properties interface
>   gdbus: Simplify code for appending properties
> 
>  audio/control.c |  57 ++--
>  gdbus/gdbus.h   |  74 +++--
>  gdbus/object.c  | 867 +++++++++++++++++++++++++++++++++++++++++++++++++++-----
>  src/manager.c   |  81 ++----
>  4 files changed, 897 insertions(+), 182 deletions(-)

This initial set has been applied. Now let's get testing it and fix any
pending issues that are found. Also please remember send the adapter and
device conversions when you've got them ready so that we get them stress
tested at the UPF next week.

Johan
