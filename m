Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 2/3] drivers/bluetooth: Add kmalloc NULL tests
From: Marcel Holtmann <marcel@holtmann.org>
To: Julia Lawall <julia@diku.dk>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0908062204290.19100@ask.diku.dk>
References: <Pine.LNX.4.64.0908062204290.19100@ask.diku.dk>
Content-Type: text/plain
Date: Thu, 06 Aug 2009 13:14:02 -0700
Message-Id: <1249589642.21101.27.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Julia,

> From: Julia Lawall <julia@diku.dk>
> 
> Check that the result of kmalloc is not NULL before dereferencing it.
> The patch also replaces kmalloc + memset by kzalloc.

good that this driver is not merged upstream yet. I apply the patch to
my tree. Thanks.

Regards

Marcel


