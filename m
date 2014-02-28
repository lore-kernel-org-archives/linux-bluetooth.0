Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH BlueZ] core: retry connect_dbus() several times
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1393571362-27898-1-git-send-email-adam8157@gmail.com>
Date: Thu, 27 Feb 2014 23:15:01 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <04802ECE-6B8D-4DF4-BFFD-EABBD42BD30F@holtmann.org>
References: <1393571362-27898-1-git-send-email-adam8157@gmail.com>
To: Adam Lee <adam8157@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Adadm,

> Sometimes the hardware, especially which needs firmware patching, is not
> yet ready when connect_dbus().

this makes no sense. Connecting to D-Bus has nothing to do with firmware patching. What are you exactly fixing here?

Regards

Marcel

