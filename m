Return-Path: <cyrus@holtmann.org>
Date: Wed, 4 Apr 2012 13:42:25 +0300
From: Johan Hedberg <johan.hedberg@intel.com>
To: "Zheng, Wu" <wu.zheng@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: obexd have not conf file for systemd.
Message-ID: <20120404104225.GA30772@x220>
References: <2CF57A644018A745B8FE029C7223E16E0FCDFAE2@SHSMSX102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2CF57A644018A745B8FE029C7223E16E0FCDFAE2@SHSMSX102.ccr.corp.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Mar 23, 2012, Zheng, Wu wrote:
> I find that Bluez provides configure file (Bluetooth.conf) for
> systemd. For obexd, I do not find any configure file for systemd .
> 
> For upstream, do obexd need to provide a conf file (like
> Bluetooth.conf) for setting policy to systemd?

obexd is supposed to be started through D-Bus activation (on the session
bus) so I don't see any need for something like you propose.

Johan
