Return-Path: <cyrus@holtmann.org>
Date: Wed, 27 Jan 2010 20:41:30 +0000 (GMT)
To: Ed Tsang <netdesign_98@yahoo.com>
Cc: Bluettooth Linux <linux-bluetooth@vger.kernel.org>
Subject: Re: hcitool cc ....    connected and drop
In-Reply-To: <615585.7801.qm@web52606.mail.re2.yahoo.com>
References: <615585.7801.qm@web52606.mail.re2.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Message-Id: <1264624890.117914.1293.nullmailer@galant.ukfsn.org>
From: Iain Hibbert <plunky@rya-online.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 27 Jan 2010, Ed Tsang wrote:

> I am trying to use hcitool to create a connection. The connection seem
> to be connected and dropped right the way. Looking at the hcidump, look
> like the connect command is ok, but then there is a "read remote
> supported feature", "read remote name" then a "disconnect command".  I
> tried to search "hci_read_remote_features" or usage of
> "OCF_READ_REMOTE_FEATURES" and put in debug print on all functions but
> could not figure out where the "read remote supported feature" was
> called from the "hcitool cc" command. Anyone please point me to the
> trivial stuff.

the Linux kernel does that for all completed connections

iain
