Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1522225312.14955.25.camel@hadess.net>
Subject: Re: [PATCH] Bluetooth: hidp: sixaxis dualshock report via ctrl quirk
From: Bastien Nocera <hadess@hadess.net>
To: Arnaud Rebillout <arnaud.rebillout@collabora.com>,
        linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, vivek@collabora.com
Date: Wed, 28 Mar 2018 10:21:52 +0200
In-Reply-To: <20180328034526.13446-1-arnaud.rebillout@collabora.com>
References: <20180328034526.13446-1-arnaud.rebillout@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 2018-03-28 at 10:45 +0700, Arnaud Rebillout wrote:
> From: vivek <vivek@collabora.com>
> 
> The Sixaxis and Dualshock 4 wants report sent via the ctrl channel.
> 
> This patch has been used in the SteamOS kernel for a while now.
> <https://github.com/ValveSoftware/steamos_kernel/commit/6e215b67a13c8
> 5d0cf5a9e0970acd9df7d2b77bd>

Given that both types of devices already work via Bluetooth, what is
this supposed to fix? The commit message will need work.
