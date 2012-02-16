Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120216221526.GA4446@x220.ger.corp.intel.com>
References: <1329429041-30715-1-git-send-email-andre.guedes@openbossa.org>
	<1329429041-30715-2-git-send-email-andre.guedes@openbossa.org>
	<20120216221526.GA4446@x220.ger.corp.intel.com>
Date: Thu, 16 Feb 2012 20:30:15 -0300
Message-ID: <CACJA=fXw2Dx2bWE-=GKhmJKBTKK3NvNWjTqATSLvi2xgFi0m1A@mail.gmail.com>
Subject: Re: [RFC 1/4] Bluetooth: Prepare start_discovery
From: Andre Guedes <andre.guedes@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Thu, Feb 16, 2012 at 7:15 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Andre,
>
> On Thu, Feb 16, 2012, Andre Guedes wrote:
>> +#define DISCOV_TYPE_BREDR            (BIT(0))
>> +#define DISCOV_TYPE_LE                       (BIT(1) | BIT(2))
>> +#define DISCOV_TYPE_INTERLEAVED              (BIT(0) | BIT(1) | BIT(2))
>
> Defining these like this looks a bit (no pun intended) odd. The previous
> code was at least using the mgmt defs instead of magic numbers (which is
> how these values have been originally chosen too).

Do you think this would be better?

+#define DISCOV_TYPE_BREDR            (BIT(MGMT_ADDR_BREDR))
+#define DISCOV_TYPE_LE               (BIT(MGMT_ADDR_LE_PUBLIC) |
BIT(MGMT_ADDR_LE_RANDOM))
+#define DISCOV_TYPE_INTERLEAVED      (BIT(MGMT_ADDR_BREDR) |
BIT(MGMT_ADDR_LE_PUBLIC) | \
+
BIT(MGMT_ADDR_LE_RANDOM))

Andre
