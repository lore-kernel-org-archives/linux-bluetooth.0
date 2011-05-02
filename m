Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BANLkTin7oCB9L0S0_kjESF6SfMfaqjwMtA@mail.gmail.com>
References: <1304123252-14464-1-git-send-email-andre.guedes@openbossa.org>
	<BANLkTin7oCB9L0S0_kjESF6SfMfaqjwMtA@mail.gmail.com>
Date: Mon, 2 May 2011 10:01:51 -0400
Message-ID: <BANLkTimMf6YZRPT+V4dLiEH0iN0gsv=FbQ@mail.gmail.com>
Subject: Re: [RFC 00/16] Discovery procedure refactoring
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Andre Guedes <andre.guedes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, May 2, 2011 at 4:39 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Im afraid because of dual mode adapters we may need to change the
> D-Bus API in the future and have the client to specify somehow on
> StartDiscovery if LE only, BR/EDR only or both like connman does with
> RequestScan, otherwise it may take too long (each cycle taking 20-30
> seconds) to discover devices because it wasting time scanning or
> resolving names in the wrong technology.

On dual mode devices, there is a specific procedure (defined by the
Core spec) for discovery, called "interleaved discovery" where BR/EDR
and LE discovery procedures are alternated at specific times. It
cannot just do BR/EDR or LE, unless we want to "fake" a single mode
adapter.

In summary, if the adapter is to work as a compliant dual mode device,
it shall use the interleaved discovery procedure. BR/EDR only or LE
only discovery would only be acceptable for single mode adapters. We
could as well have configuration options to "simulate" single mode on
dual mode adapters.

HTH,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
