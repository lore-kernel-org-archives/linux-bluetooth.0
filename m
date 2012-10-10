Return-Path: <cyrus@holtmann.org>
Message-ID: <1349891245.27233.153.camel@aeonflux>
Subject: Re: [PATCH 1/4] Bluetooth: Fix L2CAP PSM bind issue
From: Marcel Holtmann <marcel@holtmann.org>
To: Syam Sidhardhan <s.syam@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 10 Oct 2012 19:47:25 +0200
In-Reply-To: <1349887169-20880-1-git-send-email-s.syam@samsung.com>
References: <1349887169-20880-1-git-send-email-s.syam@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Syam,

> Problem: If we bind a particular PSM with source address as BDADDR_ANY,
> then we are able to bind the same PSM with adapter address(or any other
> address), which is incorrect.

why is this incorrect? Explain that to me.

Regards

Marcel


