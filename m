Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Johan Hedberg <johan.hedberg@nokia.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [PATCH] Variable arguments to Inquiry and PeriodicInquiry D-BUS methods
Message-ID: <20051108173152.GA10590@localhost.localdomain>
References: <20051108134311.GA7150@localhost.localdomain> <1131458070.5824.181.camel@blade> <20051108143016.GA7919@localhost.localdomain> <e1effdeb0511080645u30fb24dep3243ce434b0f07c2@mail.gmail.com> <1131462224.5824.198.camel@blade> <e1effdeb0511080817j48cec525r8ba84a66fc6aaaf1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e1effdeb0511080817j48cec525r8ba84a66fc6aaaf1@mail.gmail.com>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 8 Nov 2005 19:31:52 +0200

On Tue, Nov 08, 2005, Claudio Takahasi wrote:
> HAL implements 5 different methods to set device properties.
> void SetProperty(string key, any value)
> void SetPropertyString(string key, string value)
> void SetPropertyInteger(string key, int32 value)
> void SetPropertyBoolean(string key, bool value)
> void SetPropertyDouble(string key, double value)
> 
> We don't need use this approach because we are extracting/comparing
> the message signature before call the function responsible to execute
> the task. Our design of having the same method name with differents
> signatures is fine! Regarding the name, it's better use the same
> method name "SetProperty" or only "Set" for both(device configuration
> and Controller).

I think it's a matter of what the interface name is. If the interface is
"org.bluez.Device", then "SetProperty" describes the method better than
"Set". If the interface is "org.bluez.Defaults" then just "Set" would
probably be enough.

Johan


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
