Return-Path: <cyrus@holtmann.org>
Date: Tue, 15 May 2012 10:38:40 +0300
From: Johan Hedberg <johan.hedberg@intel.com>
To: "Zhang, Jingke" <jingke.zhang@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Bluez/Obexd upstream test result_20120515
Message-ID: <20120515073840.GA19367@x220>
References: <8C91AD8ED4077A4786B34154085899251024A31C@SHSMSX102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8C91AD8ED4077A4786B34154085899251024A31C@SHSMSX102.ccr.corp.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jingke,

On Tue, May 15, 2012, Zhang, Jingke wrote:
> https://bugs.meego.com/show_bug.cgi?id=25111 upstream bluez configure
> parameter needs VDP profile enabled Does upstream bluez support VDP
> profile?

BlueZ doesn't support VDP so this bug doesn't seem valid, and even if it
did support it configure script options and config file settings are a
packaging issue, i.e. not upstream related.

Johan
