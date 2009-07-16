Return-Path: <cyrus@holtmann.org>
Subject: Re: Device number limit
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrej Rosano <andrejro@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <20090716074714.GD3351@stjenka>
References: <20090716074714.GD3351@stjenka>
Content-Type: text/plain
Date: Thu, 16 Jul 2009 10:20:36 +0200
Message-Id: <1247732436.4549.49.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrej,

> the maximum number of bluetooth devices (hci interfaces) active on the system is
> limited to 16. Is it possible to increase this limit or there are some
> restrictions?

it is a libbluetooth restriction. The kernel itself has no such
restriction.

Regards

Marcel


