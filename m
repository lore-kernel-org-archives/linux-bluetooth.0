Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] bluetooth: move back hci_conn_del_sysfs to
 hci_conn_del avoid device destruct too early
From: Marcel Holtmann <marcel@holtmann.org>
To: Dave Young <hidave.darkstar@gmail.com>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <499EA5F6.2060206@gmail.com>
References: <499EA5F6.2060206@gmail.com>
Content-Type: text/plain
Date: Fri, 20 Feb 2009 20:48:59 +0100
Message-Id: <1235159339.24255.3.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dave,

> The following commit introduce a regression:
> 
> 	commit 7d0db0a373195385a2e0b19d1f5e4b186fdcffac
> 	Author: Marcel Holtmann <marcel@holtmann.org>
> 	Date:   Mon Jul 14 20:13:51 2008 +0200
> 
> 		[Bluetooth] Use a more unique bus name for connections
> 
> I get panic as following (by netconsole):

can you please send a version against my bluetooth-testing.git tree.

Regards

Marcel


