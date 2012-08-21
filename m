Return-Path: <cyrus@holtmann.org>
Message-ID: <1345550923.13726.84.camel@aeonflux>
Subject: Re: [PATCH obexd v0] client-doc: Guarantee prefix in transfer paths
From: Marcel Holtmann <marcel@holtmann.org>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: Patrick Ohly <patrick.ohly@intel.com>,
	linux-bluetooth@vger.kernel.org
Date: Tue, 21 Aug 2012 14:08:43 +0200
In-Reply-To: <CANT-zCV9exkSjQhvGqLVqdBL+GBvNG97EUnPGo55_AaAO60P+A@mail.gmail.com>
References: <1345533815-5611-1-git-send-email-mikel.astiz.oss@gmail.com>
	 <1345537878.29868.185.camel@pohly-mobl1.fritz.box>
	 <CANT-zCV9exkSjQhvGqLVqdBL+GBvNG97EUnPGo55_AaAO60P+A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

> >> The client D-Bus documentation should mention that all transfer paths
> >> contain a prefix consisting of the path of the session they belong to.
> >>
> >> This can be conveniently used by clients to install D-Bus signal matches
> >> that concentrate on the relevant signals.
> >> ---
> >>  doc/client-api.txt |    2 +-
> >>  1 files changed, 1 insertions(+), 1 deletions(-)
> >>
> >> diff --git a/doc/client-api.txt b/doc/client-api.txt
> >> index 839a78c..7ca65cc 100644
> >> --- a/doc/client-api.txt
> >> +++ b/doc/client-api.txt
> >> @@ -466,7 +466,7 @@ Transfer hierarchy
> >>
> >>  Service              org.bluez.obex.client
> >>  Interface    org.bluez.obex.Transfer
> >> -Object path  [variable prefix]/{transfer0,transfer1,...}
> >> +Object path  [variable prefix]/{session0,session1,...}/{transfer0,...}
> >>
> >>  Methods              dict GetProperties()
> >
> > It would be even better to explicitly mention that the "[variable
> > prefix]" here is the same as the "[variable prefix]" in the Session.
> 
> This documentation pattern can be widely found in Obexd and Bluez, as
> well as oFono. It's implicit that the variable prefix matches in both
> cases.

it actually means that you can not count on this prefix. It might change
and it is perfect legal that it changes from one run of the daemon to
another. The variable prefix is discovered via some defined initial
method.

Remember that I intermixed the PID in the object path of BlueZ. Simple
because people started hardcoding object paths.

Regards

Marcel


