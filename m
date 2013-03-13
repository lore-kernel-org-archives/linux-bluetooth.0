Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <FA4A6ABA-3968-4787-8572-EEBAA64F2F0B@holtmann.org>
References: <1359986188-24432-1-git-send-email-frederic.dalleau@linux.intel.com>
	<1359986188-24432-2-git-send-email-frederic.dalleau@linux.intel.com>
	<1361229298.1583.48.camel@aeonflux>
	<CA+QXtDtu-fCY9JXueApOEzfyB8NZF87Xbnh5T_RYBPrNSNRavw@mail.gmail.com>
	<FA4A6ABA-3968-4787-8572-EEBAA64F2F0B@holtmann.org>
Date: Wed, 13 Mar 2013 18:02:00 +0100
Message-ID: <CA+QXtDuRVrVTX5xYHSEaFJNrQ+R5FYLiU_Mwm2qWe7WOntPAOg@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] Bluetooth: Add option for SCO socket mode
From: "Dalleau, Frederic" <frederic.dalleau@intel.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: =?ISO-8859-1?Q?Fr=E9d=E9ric_Dalleau?= <frederic.dalleau@linux.intel.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Marcel,

On Wed, Mar 13, 2013 at 5:26 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> maybe it is not worth supporting 8-bit SCO, but it is a feature that we s=
hould not ignore. And in case you want to do multiple SCO connections (some=
 people want to actually), one way of getting less bandwidth usage is to sw=
itch to 8-bit PCM. So my current thinking is that we should support it.

There is still a problem : how would you enable specific synchronous
connection settings (max bandwith, latency, ...) ? And which one would
you choose.

Another way to reduce bandwith (at the price of some latency and some
computation) is to use mSBC, with less bandwith and a better quality
(msbc encode 240 bytes to 60).
I you really want 8 bit sco, then a suggestion in line with my patches
could be to have a dedicated mode: SCO_MODE_PCM8.

> Right now I am for working in the context of what we actually have. The C=
SA2 is not deployed at this moment and it is rather complex. So my thinking=
 is to do voice setting right now and sort out CSA2 at some point later. Un=
less someone can come up with a good way of integrating CSA2 right now and =
allow a smooth backward compatibility to non CSA2 devices.

I agree that CSA2 is not top priority, but the "mode" options is
designed to make such a transition possible.


Fred
