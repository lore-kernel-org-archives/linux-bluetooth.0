Return-Path: <cyrus@holtmann.org>
Date: Tue, 30 Apr 2013 11:38:03 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 13/13] Bluetooth: Mgmt Device Found Event
Message-ID: <20130430083803.GO777@x220.ger.corp.intel.com>
References: <1367300704-703-1-git-send-email-andre.guedes@openbossa.org>
 <1367300704-703-14-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1367300704-703-14-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Tue, Apr 30, 2013, Andre Guedes wrote:
> We only want to send Mgmt Device Found Events if we are running the
> Device Discovery procedure (started by the MGMT Start Discovery
> Command). Inquiry or LE scanning triggered by HCI raw interface (e.g.
> hcitool) or kernel internals should not send Mgmt Device Found Events.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  net/bluetooth/mgmt.c | 3 +++
>  1 file changed, 3 insertions(+)

Acked-by: Johan Hedberg <johan.hedberg@intel.com>

Johan
