Return-Path: <linux-kernel-owner+marcel=40holtmann.org-S1751165AbWALNbV@vger.kernel.org>
Subject: Re: patch: problem with sco
From: Marcel Holtmann <marcel@holtmann.org>
To: Patrick McHardy <kaber@trash.net>
Cc: Wolfgang Walter <wolfgang.walter@studentenwerk.mhn.de>,
        bluez-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        maxk@qualcomm.com
In-Reply-To: <43C64B0C.2080903@trash.net>
References: <200601120138.31791.wolfgang.walter@studentenwerk.mhn.de>
	 <1137057244.3955.3.camel@localhost.localdomain>
	 <43C64B0C.2080903@trash.net>
Content-Type: text/plain
Date: Thu, 12 Jan 2006 14:31:47 +0100
Message-Id: <1137072707.5013.7.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Patrick,

> >>A friend and I encountered a problem with sco transfers to a headset using
> >>linux (vanilla 2.6.15). While all sco packets sent by the headset were
> >>received there was no outgoing traffic.
> >>
> >>After switching debugging output on we found that actually sco_cnt was always
> >>zero in hci_sched_sco.
> 
> I'm seeing the exact same problem with a Logitech "mobile Freedom"
> headset. I'm using this patch to work around the problem:

so it seems that Broadcom really messed the SCO MTU settings up and we
have to workaround with some sane values.

Please also include the lspci for these devices.

Regards

Marcel


