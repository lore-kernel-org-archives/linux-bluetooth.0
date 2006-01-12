Return-Path: <linux-kernel-owner+marcel=40holtmann.org-S964975AbWALJNk@vger.kernel.org>
Subject: Re: patch: problem with sco
From: Marcel Holtmann <marcel@holtmann.org>
To: Wolfgang Walter <wolfgang.walter@studentenwerk.mhn.de>
Cc: bluez-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        maxk@qualcomm.com
In-Reply-To: <200601120138.31791.wolfgang.walter@studentenwerk.mhn.de>
References: <200601120138.31791.wolfgang.walter@studentenwerk.mhn.de>
Content-Type: text/plain
Date: Thu, 12 Jan 2006 10:14:04 +0100
Message-Id: <1137057244.3955.3.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Wolfgang,

> A friend and I encountered a problem with sco transfers to a headset using
> linux (vanilla 2.6.15). While all sco packets sent by the headset were
> received there was no outgoing traffic.
> 
> After switching debugging output on we found that actually sco_cnt was always
> zero in hci_sched_sco.
> 
> hciconfig hci0 shows sco_mtu to be 64:0. Changing that to 64:8 did not help.
> 
> This was because in hci_cc_info_param hdev->sco_pkts is set to zero. When we
> changed this line so that hdev->sco_pkts is set to 8 if bs->sco_max_pkt is 0
> sco transfer to the headset started to work just fine.

send in the information from "hciconfig -a" for this device, because
this is a hardware bug and you can't be sure that you can have eight
outstanding SCO packets.

I personally prefer to implement this as a quirk which can be activated
by the driver. Once I have seen the device information, I will think
about how we might deal with it.

Regards

Marcel


