Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: Bluez 5.18 on 3.12
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <BC611432-5B36-4EA5-8667-082F55020330@me.com>
Date: Fri, 9 May 2014 04:06:20 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <52C9C733-259A-427E-A857-9A291047620D@holtmann.org>
References: <BC611432-5B36-4EA5-8667-082F55020330@me.com>
To: David Eriksson <ftslc@me.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

> Anyone here that have a feeling on how hard it would be to get bluez 5.18+ with mgmt api running on 3.12?

that should just work. Linux kernel 3.4 and later should be supported. I recommend at least kernel 3.9 to get mgmt API 1.3 which contains a bunch of fixes that we otherwise have to work around.

Unless you need features from mgmt API 1.4, then you need at least Linux kernel 3.13.

Regards

Marcel

