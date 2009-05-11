Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Fix introspection issue in gdbus
From: Marcel Holtmann <marcel@holtmann.org>
To: Denis Kenzior <denis.kenzior@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <200905111345.50534.denis.kenzior@intel.com>
References: <79DD16001F75DB4EB7DE37CDD687BB2001B7238D@dalamsexb02.AMERICAS.ROOT.PRI>
	 <20090507212508.GA23276@jh-x301>
	 <79DD16001F75DB4EB7DE37CDD687BB2001B723C4@dalamsexb02.AMERICAS.ROOT.PRI>
	 <200905111345.50534.denis.kenzior@intel.com>
Content-Type: text/plain
Date: Mon, 11 May 2009 11:51:33 -0700
Message-Id: <1242067893.3384.17.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Denis,

please don't hijack older threads :)

> Attached is a patch to fix a small issue with introspection when using gdbus 
> library.  Basically the introspection data for '/' can never be invalidated, 
> which leads to funny results when objects are added & removed from '/' 
> hierarchy.
> 
> Attached patch should fix the issue.

patch has been applied to BlueZ, obexd, ConnMan and oFono. Thanks.

Regards

Marcel


