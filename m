Return-Path: <cyrus@holtmann.org>
Date: Wed, 17 Jun 2009 19:34:29 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vikram Kandukuri <Vikram.Kandukuri@Atheros.com>
Cc: Jothikumar Mothilal <Jothikumar.Mothilal@Atheros.com>,
	"marcel@holtmann.org" <marcel@holtmann.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: HSP Ring command
Message-ID: <20090617163429.GA14295@jh-x301>
References: <44EE5C37ADC36343B0625A05DD408C485068E39C2B@CHEXMB-01.global.atheros.com> <20090617154529.GA12943@jh-x301> <44EE5C37ADC36343B0625A05DD408C485068E39C75@CHEXMB-01.global.atheros.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <44EE5C37ADC36343B0625A05DD408C485068E39C75@CHEXMB-01.global.atheros.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Please don't use top posting on this list. The flow of quoted emails gets
messed up when inline and top posting are mixed.

On Wed, Jun 17, 2009, Vikram Kandukuri wrote:
> Do we have any VOIP application like SKYPE which has implemented D-Bus
> methods for incoming/outgoing/call hold indications?

AFAIK no.

> If we do not use *RING* indication for inband ring from HSP 1.2 I wonder
> why BQB tests for HSP still have a test case where we have to send
> AT+RING command when we place a call.

I'm not sure what you're referring to here. I've never heard of an AT+RING
AT command. Also the HSP spec has no mention of such a thing and actually
the AG is never sending AT commands to the headset but only responses to
AT commands or unsolicited result codes like the RING indication.

If you were talking about the RING indication and not an AT command, then
it should depend on what kind of PICS values you have selected. It is
possible to disable the RING requirement for the AG role completely with
HSP 1.2.

Johan
