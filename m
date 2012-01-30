Return-Path: <cyrus@holtmann.org>
Message-ID: <1327953929.2400.80.camel@novo.hadess.net>
Subject: Re: [RFC PATCHv2] autopair: add autopair plugin
From: Bastien Nocera <hadess@hadess.net>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Scott James Remnant <scott@netsplit.com>,
 linux-bluetooth@vger.kernel.org,  keybuk@chromium.org
Date: Mon, 30 Jan 2012 20:05:29 +0000
In-Reply-To: <1327952977.1955.160.camel@aeonflux>
References: <1327448862-21964-1-git-send-email-scott@netsplit.com>
	 <1327952977.1955.160.camel@aeonflux>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 2012-01-30 at 11:49 -0800, Marcel Holtmann wrote:
> Hi Scott,
> 
> > This plugin handles automatically generating PIN codes for certain
> > device types following rules specified in an XML file derived from
> > that used by the GNOME Bluetooth wizard.
> > 
> > The plugin deliberately ignores unknown elements and attributes so
> > that this file can be extended by the UI, for example adding hints
> > that pairing shouldn't be attempted for certain devices (e.g. mice)
> > or other special pairing considerations.
> > 
> > Should autopairing fail for a device, it is blacklisted and will
> > be retried using the agent as usual. These blacklist files can be
> > harvested by distributions in order to further improve the database.
> > ---
> >  Makefile.am                   |    9 +
> >  acinclude.m4                  |    6 +
> >  plugins/autopair.c            |  363 +++++++++++++++++++++++++++++++++++++++++
> >  plugins/pin-code-database.xml |  174 ++++++++++++++++++++
> >  4 files changed, 552 insertions(+), 0 deletions(-)
> >  create mode 100644 plugins/autopair.c
> >  create mode 100644 plugins/pin-code-database.xml
> 
> <snip>
> 
> > +<!--
> > +  The autopair plugin will match devices, following the order of the XML
> > +  file [1], on any combination of type, OUI, or name.
> > +
> > +  [1]: So specific devices should be at the top, and generic ones at the bottom,
> > +  so settings for specific devices are overridden as expected.
> > +-->
> > +
> > +<!DOCTYPE devices [
> > +	<!ELEMENT devices (device)+>
> > +	<!ELEMENT device EMPTY>
> > +	<!ATTLIST device type (any|mouse|tablet|keyboard|headset|headphones|audio|printer|network) "any">
> > +	<!ATTLIST device oui CDATA #IMPLIED>
> > +	<!ATTLIST device name CDATA #IMPLIED>
> > +	<!ATTLIST device pin CDATA #REQUIRED>
> > +]>
> 
> I think we need to have a discussion on this database format first. I
> honestly do not like it at all. It does matching and result handling in
> a single XML element. That seems like a bad idea.
> 
> And in addition making pin attribute required and then trying to disable
> PIN with "NULL" magic is something that I rather not have.
> 
> I am also wondering why this has to be XML and not simple key-value INI
> style files.

Mostly because:
- it already exists
- it can be validated without writing another tool

I'm fine if you want to change the parsing code, but removing the use of
XML seems like a not very useful requirement to me.

As for the patch itself, we will still need from the wizard to check for
those NULL hints (CreateDevice vs. CreatePairedDevice), or presentation
hints (ICADE and keyboard for example), so the file itself needs to be
made available to the front-ends (and its location exported).

For the NULL hints, I would like to see something like
CreatePairedDevice() but that would get whether to pair or not from the
database.

The PIN length hint is also ignored in the current code:
+       <device type="audio" oui="00:1A:80:" name="CMT-DH5BT" pin="max:4"/>

Cheers
