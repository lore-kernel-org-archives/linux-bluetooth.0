Return-Path: <cyrus@holtmann.org>
Date: Tue, 31 Mar 2015 08:11:51 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v6 1/8] core: device: add device_set_rssi_no_delta
Message-ID: <20150331051151.GA16011@t440s.P-661HNU-F1>
References: <1427758340-14949-1-git-send-email-jpawlowski@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1427758340-14949-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Mon, Mar 30, 2015, Jakub Pawlowski wrote:
> This patch adds new method that allow to update RSSI value without
> taking delta into account. It will be used by StartFilteredDiscovery
> method, in order to achieve more accurate proximity detection.
> ---
>  src/device.c | 14 +++++++++++---
>  src/device.h |  2 ++
>  2 files changed, 13 insertions(+), 3 deletions(-)

The commit message subject refers to a non-existing
device_set_rssi_no_delta().  The commit message itself is also phrased
as if the function was named that way.

Johan
