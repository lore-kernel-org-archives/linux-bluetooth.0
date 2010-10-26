Return-Path: <cyrus@holtmann.org>
Date: Tue, 26 Oct 2010 12:38:08 +0300
From: Ville Tervo <ville.tervo@nokia.com>
To: ext Anderson Briglia <anderson.briglia@openbossa.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC] SMP initial draft
Message-ID: <20101026093808.GE15050@null>
References: <linux-bluetooth@vger.kernel.org>
 <1287791820-22693-1-git-send-email-anderson.briglia@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1287791820-22693-1-git-send-email-anderson.briglia@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Sat, Oct 23, 2010 at 01:56:54AM +0200, ext Anderson Briglia wrote:
> This RFC is about Security Manager Protocol (SMP).
> Basically this patchset implements the initial negotiation over L2CAP and LE
> connections between a Master and a Slave. TK and STK keys are not being generated
> and/or exchanged yet, do not expect real encryption/decryption by now.
> Actually, our next tasks are related to integrate current implementation and
> Criptographic Toolbox ah, c1 and s1 functions for TK and STK key generation for
> Just Works SMP pairing method.

I think some kind of mechanism to start encryption on already existing
connection is needed. It depends on attribute if security is needed or not. One
might read unsecure attributes and then needs to start encryption because it
wants to read encrypted attribute.

Is that already planned somehow?

> 
> To test this RFC you need to have the Ville Tervo[1] kernel tree with LE connection
> patches. Of course you need LE devices and bluez git tree (master branch). Just run
> the bluetoothd and try to list the primary services using gatttool over an LE channel.
> eg.: gatttool --primary --le -i hci0 -b 00:17:E7:DD:08:FF

I guess I should take patches which are fixing plain LE (2/6) and (5/6)
connection to my tree alread. How it sounds to you?

> Comments are welcome.
> 
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/vtervo/bluetooth-le-2.6.git
> 
> [PATCH 1/6] Bluetooth: Add SMP command structures
> [PATCH 2/6] Bluetooth: fix receiving L2CAP packets over LE
> [PATCH 3/6] Bluetooth: Implement the first SMP commands
> [PATCH 4/6] Bluetooth: Start SMP procedure
> [PATCH 5/6] Bluetooth: Fix initiated LE connections
> [PATCH 6/6] Bluetooth: simple SMP pairing negotiation
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
