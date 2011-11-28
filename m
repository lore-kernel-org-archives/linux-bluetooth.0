Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v2 7/9] Bluetooth: Add 'eir_len' param to mgmt_device_found()
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=US-ASCII
From: Andre Guedes <andre.guedes@openbossa.org>
In-Reply-To: <CAJdJm_NFpZv8_qaPw=UfTRAD0=FHCSs5ev-4QQdNRW4FLfE0_A@mail.gmail.com>
Date: Mon, 28 Nov 2011 11:06:17 -0300
Cc: "Ganir, Chen" <chen.ganir@ti.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <06CD7C58-6858-4425-87C9-FF569E73881D@openbossa.org>
References: <1322265226-6404-1-git-send-email-andre.guedes@openbossa.org> <1322265226-6404-8-git-send-email-andre.guedes@openbossa.org> <F0070FBC0FB3174D8D11444EB2D5B02641647C@DNCE02.ent.ti.com> <CAJdJm_NFpZv8_qaPw=UfTRAD0=FHCSs5ev-4QQdNRW4FLfE0_A@mail.gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen,

On Nov 28, 2011, at 8:08 AM, Anderson Lizardo wrote:

> Hi Chen,
> 
> On Sun, Nov 27, 2011 at 2:37 AM, Ganir, Chen <chen.ganir@ti.com> wrote:
>> Why do we really need this ? The GAP Spec clearly defines a fixed advertising size of 31 octets (Vol3, Part C, Section 11). Instead of reporting how much we got (may be other than 31 if the peer device does not conform to the spec as required), we should make sure that BlueZ will always report 31 octets, and make sure that the device found event always sends a buffer of 31 octets.
> 
> These functions are also used for BR/EDR, where EIR data is 240 bytes.
> If I remember correctly, it has already been discussed on this list
> about dropping this length, and the decision was against dropping it,
> otherwise we would send always 240 bytes containing mostly zeroes (for
> LE case).
> 
> Also note these items from the AD section:
> 
> "If the Length field is set to zero, then the Data field has zero
> octets. This shall
> only occur to allow an early termination of the Advertising or Scan Response
> data."
> 
> and:
> 
> "Only the significant part of the Advertising or Scan Response data needs to be
> sent over the air."
> 
> So a device sending less than 31 bytes of AD is compliant as long as
> the last AD length field is zero. The receiving controller is not
> required to fill the remaining AD with zeroes before sending it to the
> host.

I guess Lizardo already answered your question. Further info about this
issue please take a look at the early discussion we had here in the ML.

Subject: [PATCH v2 11/16] Bluetooth: Add 'eir_len' param to mgmt_device_found()

BR,

Andre

