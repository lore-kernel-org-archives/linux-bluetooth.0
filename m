Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <001F63875E1AF5428162B5A2D3ED1BDD8E98@IRSMSX101.ger.corp.intel.com>
References: <001F63875E1AF5428162B5A2D3ED1BDD8E98@IRSMSX101.ger.corp.intel.com>
Date: Thu, 5 Jan 2012 15:34:13 +0200
Message-ID: <CABBYNZJrQMnLXxzNhXPRn34kJv7u0gDphqb5OjScJX4DptWBCQ@mail.gmail.com>
Subject: Re: [PATCH] Breaks in A2DP playback during device search
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "Aj, SanthoshX" <santhoshx.aj@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Holtmann, Marcel" <marcel.holtmann@intel.com>,
	"Nair, Rashmi G" <rashmi.g.nair@intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Jan 5, 2012 at 6:39 AM, Aj, SanthoshX <santhoshx.aj@intel.com> wrote:
> From 8ecb4074305613a113d1c8dd220ab856c5f7ebc1 Mon Sep 17 00:00:00 2001
> From: Santhosh <santhoshx.aj@intel.com>
> Date: Wed, 4 Jan 2012 12:44:37 +0530
> Subject: [PATCH] To change the latency of controller
>  This change is done to fix the a2dp breaks as the IMC controller
>  expects the latency to be set explicitly by calling HCI QoS setup
>
> ---
>  audio/device.c         |    7 +++
>  common/Android.mk      |    3 +-
>  common/android_bluez.c |  111 ++++++++++++++++++++++++++++++++++++++---------
>  3 files changed, 98 insertions(+), 23 deletions(-)

This code is not upstream so we cannot really apply it, but the
problem exists so I would like a bit more feedback on what can be
done. The problem is that it is not known if this will work for other
controllers nor the relation it has when inquiry is active (e.g. does
it changes the inquiry settings somehow?).

Btw, both HCI_QoS_Setup and HCI_Flow_Specification are not supposed to
be configured directly but instead combine the QoS of L2CAP
connections using the ACL. QoS in L2CAP appears to be negotiate during
connection phase, but to really support this completely we would need
support for guaranteed service type which requires a much more complex
queuing discipline than what we currently have.

Perhaps we can tune inquiry parameters when connections exists so they
are not affected?

-- 
Luiz Augusto von Dentz
