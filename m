Return-Path: <cyrus@holtmann.org>
Subject: Re: [patch 2/2] bluetooth: CONFIG_DEBUG_LOCK_ALLOC ifdefs remove
From: Marcel Holtmann <marcel@holtmann.org>
To: akpm@linux-foundation.org
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
	hidave.darkstar@gmail.com, mingo@elte.hu
In-Reply-To: <200902112128.n1BLSCdw000376@imap1.linux-foundation.org>
References: <200902112128.n1BLSCdw000376@imap1.linux-foundation.org>
Content-Type: text/plain
Date: Thu, 12 Feb 2009 02:52:38 +0100
Message-Id: <1234403558.7293.28.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrew,

> Due to lockdep changes the CONFIG_DEBUG_LOCK_ALLOC ifdef is not needed
> now, just remove it here.
> 
> The following commit fixed the !lockdep build warnings:

already part of my bluetooth-testing.git tree.

Regards

Marcel


