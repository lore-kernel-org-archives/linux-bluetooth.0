Return-Path: <cyrus@holtmann.org>
Message-ID: <1327952977.1955.160.camel@aeonflux>
Subject: Re: [RFC PATCHv2] autopair: add autopair plugin
From: Marcel Holtmann <marcel@holtmann.org>
To: Scott James Remnant <scott@netsplit.com>
Cc: linux-bluetooth@vger.kernel.org, keybuk@chromium.org,
	hadess@hadess.net
Date: Mon, 30 Jan 2012 11:49:37 -0800
In-Reply-To: <1327448862-21964-1-git-send-email-scott@netsplit.com>
References: <1327448862-21964-1-git-send-email-scott@netsplit.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Scott,

> This plugin handles automatically generating PIN codes for certain
> device types following rules specified in an XML file derived from
> that used by the GNOME Bluetooth wizard.
> 
> The plugin deliberately ignores unknown elements and attributes so
> that this file can be extended by the UI, for example adding hints
> that pairing shouldn't be attempted for certain devices (e.g. mice)
> or other special pairing considerations.
> 
> Should autopairing fail for a device, it is blacklisted and will
> be retried using the agent as usual. These blacklist files can be
> harvested by distributions in order to further improve the database.
> ---
>  Makefile.am                   |    9 +
>  acinclude.m4                  |    6 +
>  plugins/autopair.c            |  363 +++++++++++++++++++++++++++++++++++++++++
>  plugins/pin-code-database.xml |  174 ++++++++++++++++++++
>  4 files changed, 552 insertions(+), 0 deletions(-)
>  create mode 100644 plugins/autopair.c
>  create mode 100644 plugins/pin-code-database.xml

<snip>

> +<!--
> +  The autopair plugin will match devices, following the order of the XML
> +  file [1], on any combination of type, OUI, or name.
> +
> +  [1]: So specific devices should be at the top, and generic ones at the bottom,
> +  so settings for specific devices are overridden as expected.
> +-->
> +
> +<!DOCTYPE devices [
> +	<!ELEMENT devices (device)+>
> +	<!ELEMENT device EMPTY>
> +	<!ATTLIST device type (any|mouse|tablet|keyboard|headset|headphones|audio|printer|network) "any">
> +	<!ATTLIST device oui CDATA #IMPLIED>
> +	<!ATTLIST device name CDATA #IMPLIED>
> +	<!ATTLIST device pin CDATA #REQUIRED>
> +]>

I think we need to have a discussion on this database format first. I
honestly do not like it at all. It does matching and result handling in
a single XML element. That seems like a bad idea.

And in addition making pin attribute required and then trying to disable
PIN with "NULL" magic is something that I rather not have.

I am also wondering why this has to be XML and not simple key-value INI
style files.

Regards

Marcel


