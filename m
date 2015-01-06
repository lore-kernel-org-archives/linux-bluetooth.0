Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: BlueZ question about HID profile
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <7FF7EC0D6ACE2E4297FA998A42F07AD6195AF357@QS-MBX02.benq.corp.com>
Date: Mon, 5 Jan 2015 17:38:28 -0800
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <E1E9C166-A11C-4A76-8B60-BF168C918F2B@holtmann.org>
References: <m3oaqfl79f.fsf@carbon.jhcloos.org> <D043D131-E9F8-43C1-8671-0EACAE810420@holtmann.org> <m361cklxwo.fsf@carbon.jhcloos.org> <C5CDA647-8415-44F3-9F89-0D596D76498F@holtmann.org> <m3zj9wkfsw.fsf@carbon.jhcloos.org> <7FF7EC0D6ACE2E4297FA998A42F07AD6195AF357@QS-MBX02.benq.corp.com>
To: Gilbert Gao <Gilbert.Gao@Qisda.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gilbert,

> Here is an emergent question about BlueZ feature:
> I read the doc "supported-features.txt", which says BlueZ supports HID host.
> And my question is whether HID device is supported?
> Or can I use BlueZ HID profile to implement the Bluetooth HID device such as a Bluetooth mouse or keyboard?

it should be pretty simple to implement a HID device role. There have been external projects in the past that did this. The reason why this is not in BlueZ is mainly due to the fact that we would need to get the input events from some kind of source. So if you have that figured out, then it should be simple to provided HID device role.

Regards

Marcel


