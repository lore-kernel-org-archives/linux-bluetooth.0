Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH v2 2/2] doc: Introduce Start/Stop Connection Monitor
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1399545077-9344-2-git-send-email-lukasz.rymanowski@tieto.com>
Date: Thu, 8 May 2014 13:33:58 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <536296DB-E012-42F6-8C83-003DA67AB524@holtmann.org>
References: <1399545077-9344-1-git-send-email-lukasz.rymanowski@tieto.com> <1399545077-9344-2-git-send-email-lukasz.rymanowski@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

> This patch introduces device method to start and stop connection monitor
> and two new device properties ConnectionRSSI, ConnectionTXPower and
> ConnectionTXPowerMax.
> 
> ConnectionRSSI and ConnectionTXPower  are tracked when monitor is active

lets leave this until we have figure out the kernel API for this. We are still going forth and back on that. Please also keep in mind that the kernel mgmt API will not be present on many systems for at least 6 month.

Regards

Marcel

